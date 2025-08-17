import 'package:flutter/material.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';

class FeedbackRepoProvider extends InheritedWidget {
  const FeedbackRepoProvider({
    super.key,
    required super.child,
    required this.feedbackRepository,
  });

  final FeedbackRepository feedbackRepository;

  static FeedbackRepository? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FeedbackRepoProvider>()
        ?.feedbackRepository;
  }

  @override
  bool updateShouldNotify(FeedbackRepoProvider oldWidget) {
    return oldWidget.feedbackRepository != feedbackRepository;
  }
}
