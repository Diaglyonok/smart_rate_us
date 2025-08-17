import 'package:flutter/material.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';

/// Provides access to [FeedbackRepository] throughout the widget tree.
///
/// This InheritedWidget makes the feedback repository available to all descendant
/// widgets, allowing them to trigger rating prompts and manage feedback state.
///
/// The repository is typically created by [FeedbackWrapper] and provides methods
/// for tracking user actions and determining when to show rating dialogs.
///
/// Usage:
/// ```dart
/// // Access the repository from any descendant widget
/// final repository = FeedbackRepoProvider.of(context);
/// repository?.addCounterAndCheck('success_action_5');
/// ```
class FeedbackRepoProvider extends InheritedWidget {
  /// Creates a FeedbackRepoProvider.
  ///
  /// [child] - The widget subtree that will have access to the repository
  /// [feedbackRepository] - The repository instance to provide
  const FeedbackRepoProvider({
    super.key,
    required super.child,
    required this.feedbackRepository,
  });

  /// The feedback repository instance provided to descendant widgets
  final FeedbackRepository feedbackRepository;

  /// Retrieves the nearest [FeedbackRepository] from the widget tree.
  ///
  /// Returns null if no [FeedbackRepoProvider] is found in the widget tree.
  ///
  /// This is the primary way to access feedback functionality from anywhere
  /// in your app once it's wrapped with [FeedbackWrapper].
  ///
  /// Example:
  /// ```dart
  /// void _onUserSuccess() {
  ///   FeedbackRepoProvider.of(context)?.addCounterAndCheck('success_action_5');
  /// }
  /// ```
  static FeedbackRepository? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FeedbackRepoProvider>()
        ?.feedbackRepository;
  }

  /// Determines whether dependent widgets should rebuild when this provider updates.
  ///
  /// Returns true if the [feedbackRepository] instance has changed, which will
  /// trigger a rebuild of all dependent widgets.
  @override
  bool updateShouldNotify(FeedbackRepoProvider oldWidget) {
    return oldWidget.feedbackRepository != feedbackRepository;
  }
}
