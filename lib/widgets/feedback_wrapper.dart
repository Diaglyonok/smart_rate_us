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

class FeedbackWrapperConfig {
  final FeedbackService feedbackService;
  final ConfigsService remoteConfigRepo;
  final DialogBuilder doYouLoveUsDialogBuilder;
  final WriteFeedbackPageBuilder writeFeedbackPageBuilder;
  final Future<void> Function(BuildContext context)? onFinalSuccessCallback;

  FeedbackWrapperConfig({
    required this.writeFeedbackPageBuilder,
    required this.onFinalSuccessCallback,
    required this.feedbackService,
    required this.remoteConfigRepo,
    required this.doYouLoveUsDialogBuilder,
  });

  FeedbackWrapperConfig.defaultConfig({required this.feedbackService})
    : remoteConfigRepo = DefaultFeedbackConfigsRepository(),
      doYouLoveUsDialogBuilder = buildDefaultDialogWidget,
      writeFeedbackPageBuilder = buildDefaultWriteUsPageWidget,
      onFinalSuccessCallback = defaultOpenDialogCallback;
}

class FeedbackWrapper extends StatefulWidget {
  const FeedbackWrapper({
    super.key,
    required this.child,
    required this.feedbackConfig,
    this.onRepositoryCreated,
  });
  final Widget child;
  final FeedbackWrapperConfig feedbackConfig;
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
