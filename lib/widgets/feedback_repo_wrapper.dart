import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/widgets/feedback_wrapper.dart';

/// Wrapper widget that provides [FeedbackRepository] to the widget tree.
///
/// This widget uses [RepositoryProvider] to make the feedback repository
/// available to all descendant widgets. It should be placed at the root of
/// your app, typically wrapping [MaterialApp], before [FeedbackWidgetWrapper].
///
/// Usage:
/// ```dart
/// FeedbackRepoWrapper(
///   feedbackConfig: FeedbackWrapperConfig.defaultConfig(
///     feedbackService: YourFeedbackService(),
///   ),
///   child: MaterialApp(
///     home: FeedbackWidgetWrapper(
///       feedbackConfig: config,
///       child: YourMainWidget(),
///     ),
///   ),
/// )
/// ```
class FeedbackRepoWrapper extends StatelessWidget {
  /// Creates a FeedbackRepoWrapper.
  ///
  /// [child] - The widget subtree that will have access to the repository
  /// [feedbackConfig] - Configuration for creating the feedback repository
  const FeedbackRepoWrapper({super.key, required this.child, required this.feedbackConfig});

  /// Configuration for the feedback system
  final FeedbackWrapperConfig feedbackConfig;

  /// The widget subtree that will have access to the feedback repository
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        final repo = FeedbackRepository(
          feedbackService: feedbackConfig.feedbackService,
          remoteConfigRepo: feedbackConfig.remoteConfigRepo,
        );
        return repo;
      },

      child: child,
    );
  }
}
