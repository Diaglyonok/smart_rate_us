import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rate_us/data/feedback_service.dart';
import 'package:smart_rate_us/default/default_configs_repository.dart';
import 'package:smart_rate_us/default/views/default_dialog_builder.dart';
import 'package:smart_rate_us/default/views/default_write_us_page_builder.dart';
import 'package:smart_rate_us/logic/config_repository.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/widgets/feedaback_repo_provider.dart';
import 'package:smart_rate_us/widgets/write_feedback_screen.dart';

import '../logic/feedback_bloc.dart';
import 'do_you_love_us_dialog.dart';

/// Configuration class for the FeedbackWrapper widget.
///
/// This class holds all the necessary configurations for customizing the feedback flow,
/// including services, UI builders, and callbacks.
class FeedbackWrapperConfig {
  /// Service responsible for sending feedback to the backend
  final FeedbackService feedbackService;

  /// Service for managing remote configurations
  final ConfigsService remoteConfigRepo;

  /// Builder function for creating the "Do you love us?" dialog
  final DialogBuilder doYouLoveUsDialogBuilder;

  /// Builder function for creating the feedback writing page
  final WriteFeedbackPageBuilder writeFeedbackPageBuilder;

  /// Callback function executed when feedback is successfully sent
  final Future<void> Function(BuildContext context)? onFinalSuccessCallback;

  /// Creates a new FeedbackWrapperConfig with custom configurations.
  ///
  /// All parameters are required for a fully customized feedback experience.
  FeedbackWrapperConfig({
    required this.writeFeedbackPageBuilder,
    required this.onFinalSuccessCallback,
    required this.feedbackService,
    required this.remoteConfigRepo,
    required this.doYouLoveUsDialogBuilder,
  });

  /// Creates a FeedbackWrapperConfig with default configurations.
  ///
  /// This factory constructor provides sensible defaults for all components
  /// except the feedbackService, which must be provided.
  ///
  /// Default components:
  /// - Uses DefaultFeedbackConfigsRepository for remote configs
  /// - Uses buildDefaultDialogWidget for dialog UI
  /// - Uses buildDefaultWriteUsPageWidget for feedback page UI
  /// - Uses defaultOpenDialogCallback for success handling
  FeedbackWrapperConfig.defaultConfig({required this.feedbackService})
    : remoteConfigRepo = DefaultFeedbackConfigsRepository(),
      doYouLoveUsDialogBuilder = buildDefaultDialogWidget,
      writeFeedbackPageBuilder = buildDefaultWriteUsPageWidget,
      onFinalSuccessCallback = defaultOpenDialogCallback;
}

/// Main wrapper widget that provides feedback functionality throughout the app.
///
/// This widget sets up the necessary providers and listeners for the feedback system.
/// It wraps your app's main widget and provides access to feedback functionality
/// through the FeedbackRepoProvider.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   home: FeedbackWrapper(
///     feedbackConfig: FeedbackWrapperConfig.defaultConfig(
///       feedbackService: YourFeedbackService(),
///     ),
///     child: YourMainWidget(),
///   ),
/// )
/// ```
class FeedbackWrapper extends StatefulWidget {
  /// Creates a new FeedbackWrapper.
  ///
  /// [child] - The main widget to be wrapped
  /// [feedbackConfig] - Configuration for the feedback system
  /// [onRepositoryCreated] - Optional callback when the repository is created
  const FeedbackWrapper({
    super.key,
    required this.child,
    required this.feedbackConfig,
    this.onRepositoryCreated,
  });

  /// The main widget to be wrapped by the feedback system
  final Widget child;

  /// Configuration for the feedback system
  final FeedbackWrapperConfig feedbackConfig;

  /// Optional callback that is called when the FeedbackRepository is created.
  /// Useful for saving the repository reference to your own DI container.
  final void Function(FeedbackRepository remoteConfigRepo)? onRepositoryCreated;

  @override
  State<FeedbackWrapper> createState() => _FeedbackWrapperState();
}

class _FeedbackWrapperState extends State<FeedbackWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        final repo = FeedbackRepository(
          feedbackService: widget.feedbackConfig.feedbackService,
          remoteConfigRepo: widget.feedbackConfig.remoteConfigRepo,
        );
        widget.onRepositoryCreated?.call(repo);
        return repo;
      },
      child: Builder(
        builder: (context) {
          return FeedbackRepoProvider(
            feedbackRepository: RepositoryProvider.of<FeedbackRepository>(
              context,
            ),
            child: BlocProvider<FeedbackCubit>(
              create: (context) => FeedbackCubit(
                repository: RepositoryProvider.of<FeedbackRepository>(context),
              ),
              child: BlocListener<FeedbackCubit, FeedbackBaseState>(
                child: widget.child,
                listener: (context, state) {
                  if (state is ShowFeedbackState && !kIsWeb) {
                    final repo = RepositoryProvider.of<FeedbackRepository>(
                      context,
                    );
                    unawaited(
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => RepositoryProvider.value(
                          value: repo,
                          child: DoYouLoveUsDialog(
                            writeFeedbackPageBuilder:
                                widget.feedbackConfig.writeFeedbackPageBuilder,
                            onFinalSuccessCallback:
                                widget.feedbackConfig.onFinalSuccessCallback,
                            dialogBuilder:
                                widget.feedbackConfig.doYouLoveUsDialogBuilder,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
