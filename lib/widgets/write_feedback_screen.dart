import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/logic/feedback_update_bloc.dart';

typedef WriteFeedbackPageBuilder =
    Widget Function(
      BuildContext context,
      bool isLoading,
      void Function(Map<String, dynamic> feedback) onSend,
    );

class WriteFeedbackScreen extends StatefulWidget {
  final WriteFeedbackPageBuilder builder;
  final Future<void> Function(BuildContext context)? onFinalSuccessCallback;

  const WriteFeedbackScreen({
    super.key,
    required this.builder,
    required this.onFinalSuccessCallback,
  });

  @override
  State<WriteFeedbackScreen> createState() => _WriteFeedbackScreenState();
}

class _WriteFeedbackScreenState extends State<WriteFeedbackScreen> {
  FeedbackUpdateCubit? _feedbackUpdateCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _feedbackUpdateCubit ??= FeedbackUpdateCubit(
      repository: context.read<FeedbackRepository>(),
    );
  }

  @override
  void dispose() {
    _feedbackUpdateCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackUpdateCubit, FeedbackUpdateBaseState>(
      bloc: _feedbackUpdateCubit,
      listener: (context, state) async {
        if (state is UpdateSucceededState) {
          void defaultFinalCallback() {
            if (context.mounted &&
                (ModalRoute.of(context)?.isCurrent ?? false)) {
              Navigator.of(context).pop();
            }
          }

          widget.onFinalSuccessCallback?.call(context) ??
              defaultFinalCallback();
        }
      },
      builder: (context, state) {
        return widget.builder(context, state is UpdateInProgressState, (
          feedback,
        ) {
          _feedbackUpdateCubit?.sendFeedback(feedback);
        });
      },
    );
  }
}
