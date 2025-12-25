import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/logic/feedback_update_bloc.dart';

/// Function signature for building the feedback collection page UI.
///
/// [context] - The build context
/// [isLoading] - Whether feedback is currently being sent
/// [onSend] - Callback to send feedback data to the backend
///
/// The builder should create a form or interface that allows users to
/// provide feedback and call [onSend] with the collected data.
typedef WriteFeedbackPageBuilder =
    Widget Function(
      BuildContext context,
      bool isLoading,
      void Function(Map<String, dynamic> feedback) onSend,
      String? userEmail,
    );

/// Screen widget for collecting user feedback.
///
/// This widget provides a customizable interface for users to submit feedback
/// when they've indicated they want to provide improvement suggestions.
///
/// The screen manages the feedback submission state and handles success/failure
/// scenarios through the provided callbacks.
///
/// Features:
/// - Loading state management during feedback submission
/// - Success callback handling
/// - Integration with FeedbackRepository for data persistence
/// - BLoC pattern for state management
///
/// Example:
/// ```dart
/// WriteFeedbackScreen(
///   builder: (context, isLoading, onSend) {
///     return YourFeedbackForm(
///       isLoading: isLoading,
///       onSubmit: (feedbackData) => onSend(feedbackData),
///     );
///   },
///   onFinalSuccessCallback: (context) async {
///     // Show success message
///     Navigator.pop(context);
///   },
/// )
/// ```
class WriteFeedbackScreen extends StatefulWidget {
  /// Creates a WriteFeedbackScreen.
  ///
  /// [builder] - Function that builds the feedback collection UI
  /// [onFinalSuccessCallback] - Callback when feedback is successfully sent
  const WriteFeedbackScreen({
    super.key,
    required this.builder,
    required this.onFinalSuccessCallback,
    required this.onPopCallback,
    this.userEmail,
  });

  /// Builder function for creating the feedback collection UI.
  ///
  /// The builder receives the current loading state and a callback function
  /// for sending feedback data. It should render appropriate UI based on
  /// the loading state and call the onSend callback when ready to submit.
  final WriteFeedbackPageBuilder builder;

  /// Callback executed when feedback is successfully submitted.
  ///
  /// This can be used to show success messages, navigate away from the
  /// feedback screen, or perform other post-submission actions.
  final Future<void> Function(BuildContext context)? onFinalSuccessCallback;

  /// Callback executed when navigation should go back.
  /// Used for closing the feedback screen after successful submission.
  final Future<void> Function(BuildContext context) onPopCallback;

  /// Optional user email to be used for feedback submission.
  final String? userEmail;

  @override
  State<WriteFeedbackScreen> createState() => _WriteFeedbackScreenState();
}

class _WriteFeedbackScreenState extends State<WriteFeedbackScreen> {
  FeedbackUpdateCubit? _feedbackUpdateCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _feedbackUpdateCubit ??= FeedbackUpdateCubit(repository: context.read<FeedbackRepository>());
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
            if (context.mounted && (ModalRoute.of(context)?.isCurrent ?? false)) {
              widget.onPopCallback.call(context);
            }
          }

          widget.onFinalSuccessCallback?.call(context) ?? defaultFinalCallback();
        }
      },
      builder: (context, state) {
        return widget.builder(context, state is UpdateInProgressState, (feedback) {
          _feedbackUpdateCubit?.sendFeedback(feedback);
        }, widget.userEmail);
      },
    );
  }
}
