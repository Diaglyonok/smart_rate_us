import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/widgets/write_feedback_screen.dart';

import '../logic/feedback_update_bloc.dart';

/// Function signature for building the rating dialog UI.
///
/// [context] - The build context
/// [onLike] - Callback when user indicates they like the app
/// [onDislike] - Callback when user indicates they want to provide feedback
/// [onRemindLater] - Callback when user wants to be reminded later
///
/// The dialog should provide these three interaction options to properly
/// integrate with the feedback flow.
typedef DialogBuilder =
    Widget Function(
      BuildContext context,
      VoidCallback onLike,
      VoidCallback onDislike,
      VoidCallback onRemindLater,
    );

/// Dialog widget that handles the initial "Do you love us?" rating prompt.
///
/// This widget orchestrates the feedback flow by:
/// - Showing a rating dialog to the user
/// - Handling positive feedback with in-app review
/// - Navigating to feedback collection for negative feedback
/// - Managing "remind me later" functionality
///
/// The dialog integrates with the platform's native review system when users
/// indicate they like the app, and provides a custom feedback collection
/// flow for users who want to provide improvement suggestions.
///
/// Example:
/// ```dart
/// DoYouLoveUsDialog(
///   dialogBuilder: (context, onLike, onDislike, onRemindLater) {
///     return YourCustomDialog(
///       onLike: onLike,
///       onDislike: onDislike,
///       onRemindLater: onRemindLater,
///     );
///   },
///   writeFeedbackPageBuilder: (context, isLoading, onSend) {
///     return YourFeedbackForm(onSend: onSend);
///   },
///   onFinalSuccessCallback: (context) async {
///     // Handle successful feedback submission
///   },
/// )
/// ```
class DoYouLoveUsDialog extends StatefulWidget {
  /// Creates a DoYouLoveUsDialog.
  ///
  /// [writeFeedbackPageBuilder] - Builder for the feedback collection page
  /// [onFinalSuccessCallback] - Callback when feedback is successfully sent
  /// [dialogBuilder] - Optional custom dialog builder (uses default if null)
  /// [feedbackUpdateCubit] - Optional cubit for managing feedback updates
  const DoYouLoveUsDialog({
    super.key,
    required this.writeFeedbackPageBuilder,
    required this.onFinalSuccessCallback,
    required this.onPopCallback,
    required this.onWriteFeedbackCallback,
    this.dialogBuilder,
    this.feedbackUpdateCubit,
  });

  /// Builder function for creating the rating dialog UI.
  /// If null, a default dialog implementation will be used.
  final DialogBuilder? dialogBuilder;

  /// Optional cubit for managing feedback update state.
  /// Used for handling "remind me later" functionality.
  final FeedbackUpdateCubit? feedbackUpdateCubit;

  /// Builder function for creating the feedback collection page.
  /// This page is shown when users indicate they want to provide feedback.
  final WriteFeedbackPageBuilder writeFeedbackPageBuilder;

  /// Callback executed when feedback is successfully submitted.
  /// Can be used to show success dialogs or navigate to other screens.
  final Future<void> Function(BuildContext context)? onFinalSuccessCallback;

  /// Callback executed when navigation should go back.
  /// Used for closing the dialog or feedback screen.
  final Future<void> Function(BuildContext context) onPopCallback;

  /// Callback executed when navigating to the feedback writing screen.
  /// Receives the context and the pre-built feedback page widget.
  final Future<void> Function(BuildContext context, Widget writeFeedbackPage)
  onWriteFeedbackCallback;

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
        widget.onPopCallback.call(context);
        final InAppReview inAppReview = InAppReview.instance;

        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      },
      () {
        widget.onPopCallback.call(context);
        widget.onWriteFeedbackCallback(
          context,
          RepositoryProvider.value(
            value: repository,
            child: WriteFeedbackScreen(
              onPopCallback: widget.onPopCallback,
              builder: widget.writeFeedbackPageBuilder,
              onFinalSuccessCallback: widget.onFinalSuccessCallback,
            ),
          ),
        );
      },
      () {
        widget.onPopCallback.call(context);
        widget.feedbackUpdateCubit?.delayDialog();
      },
    );
  }

  VoidCallback callback(VoidCallback action) {
    return () {
      widget.onPopCallback.call(context);
      action.call();
    };
  }
}
