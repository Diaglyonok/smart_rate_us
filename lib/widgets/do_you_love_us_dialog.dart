import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/widgets/write_feedback_screen.dart';

import '../logic/feedback_update_bloc.dart';

typedef DialogBuilder =
    Widget Function(
      BuildContext context,
      VoidCallback onLike,
      VoidCallback onDislike,
      VoidCallback onRemindLater,
    );

class DoYouLoveUsDialog extends StatefulWidget {
  final DialogBuilder? dialogBuilder;
  final FeedbackUpdateCubit? feedbackUpdateCubit;
  final WriteFeedbackPageBuilder writeFeedbackPageBuilder;
  final Future<void> Function(BuildContext context)? onFinalSuccessCallback;

  const DoYouLoveUsDialog({
    super.key,
    required this.writeFeedbackPageBuilder,
    required this.onFinalSuccessCallback,
    this.dialogBuilder,
    this.feedbackUpdateCubit,
  });

  @override
  State<DoYouLoveUsDialog> createState() => _DoYouLoveUsDialogState();
}

class _DoYouLoveUsDialogState extends State<DoYouLoveUsDialog> {
  @override
  Widget build(BuildContext context) {
    final repository = context.read<FeedbackRepository>();

    return widget.dialogBuilder!.call(
      context,
      () async {
        Navigator.of(context).pop();
        final InAppReview inAppReview = InAppReview.instance;

        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      },
      () {
        Navigator.of(context).pop();
        Navigator.of(context).push<void>(
          MaterialPageRoute(
            builder: (context) {
              return RepositoryProvider.value(
                value: repository,
                child: WriteFeedbackScreen(
                  builder: widget.writeFeedbackPageBuilder,
                  onFinalSuccessCallback: widget.onFinalSuccessCallback,
                ),
              );
            },
          ),
        );
      },
      () {
        Navigator.of(context).pop();
        widget.feedbackUpdateCubit?.delayDialog();
      },
    );
  }

  VoidCallback callback(VoidCallback action) {
    return () {
      Navigator.of(context).pop();
      action.call();
    };
  }
}
