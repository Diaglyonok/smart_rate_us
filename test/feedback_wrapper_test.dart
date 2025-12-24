import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_rate_us/data/feedback_service.dart';
import 'package:smart_rate_us/logic/config_repository.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/widgets/feedback_wrapper.dart';

class MockFeedbackService extends FeedbackService {
  @override
  Future<bool> sendFeedback({required Map<String, dynamic> feedback}) async {
    return true;
  }
}

class MockConfigsService extends ConfigsService {
  final Map<String, dynamic> _configs = {
    "events": {
      "success_action_2": 2,
      "success_action_3": 3,
      "success_action_5": 5,
    },
    "expiration_delay_days": 7,
    "do_not_disturb_on_new_version": true,
  };

  @override
  void startLoading() {
    // No async operations in mock
  }

  @override
  FutureOr<Map<String, dynamic>?> getConfigs() {
    return _configs; // Return synchronously, no Future.delayed
  }
}

void main() {
  group('FeedbackWrapperConfig', () {
    test('creates config with required parameters', () {
      final feedbackService = MockFeedbackService();
      final config = FeedbackWrapperConfig(
        onWriteFeedbackCallback: (context, page) async {
          await Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (context) {
                return page;
              },
            ),
          );
        },
        onPopCallback: (context) async {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        feedbackService: feedbackService,
        remoteConfigRepo: MockConfigsService(),
        doYouLoveUsDialogBuilder: (context, onLike, onDislike, onRemindLater) =>
            Container(),
        writeFeedbackPageBuilder: (context, isLoading, onSend) => Container(),
        onFinalSuccessCallback: (context) async {},
      );

      expect(config.feedbackService, equals(feedbackService));
      expect(config.remoteConfigRepo, isA<MockConfigsService>());
      expect(config.doYouLoveUsDialogBuilder, isNotNull);
      expect(config.writeFeedbackPageBuilder, isNotNull);
      expect(config.onFinalSuccessCallback, isNotNull);
    });

    test('creates default config', () {
      final feedbackService = MockFeedbackService();
      final config = FeedbackWrapperConfig.defaultConfig(
        feedbackService: feedbackService,
      );

      expect(config.feedbackService, equals(feedbackService));
      expect(config.remoteConfigRepo, isNotNull);
      expect(config.doYouLoveUsDialogBuilder, isNotNull);
      expect(config.writeFeedbackPageBuilder, isNotNull);
      expect(config.onFinalSuccessCallback, isNotNull);
    });
  });

  group('FeedbackWrapper', () {
    late FeedbackWrapperConfig config;
    late FeedbackRepository? createdRepository;

    setUp(() {
      config = FeedbackWrapperConfig(
        onWriteFeedbackCallback: (context, page) async {
          await Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (context) {
                return page;
              },
            ),
          );
        },
        onPopCallback: (context) async {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        feedbackService: MockFeedbackService(),
        remoteConfigRepo: MockConfigsService(),
        doYouLoveUsDialogBuilder: (context, onLike, onDislike, onRemindLater) =>
            Container(),
        writeFeedbackPageBuilder: (context, isLoading, onSend) => Container(),
        onFinalSuccessCallback: (context) async {},
      );
      createdRepository = null;
    });

    Widget createWrapper({
      Widget? child,
      void Function(FeedbackRepository)? onRepoCreated,
    }) {
      return MaterialApp(
        home: FeedbackWrapper(
          feedbackConfig: config,
          onRepositoryCreated:
              onRepoCreated ??
              (repo) {
                createdRepository = repo;
              },
          child: child ?? const Text('Child Widget'),
        ),
      );
    }

    testWidgets('renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(createWrapper(child: const Text('Test Child')));

      expect(find.text('Test Child'), findsOneWidget);
      expect(find.byType(FeedbackWrapper), findsOneWidget);
    });

    testWidgets('creates and provides FeedbackRepository', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWrapper());

      expect(createdRepository, isNotNull);
      expect(createdRepository, isA<FeedbackRepository>());
    });

    testWidgets('renders child widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWrapper(child: const Text('Test Child')));

      expect(find.text('Test Child'), findsOneWidget);
      expect(find.byType(FeedbackWrapper), findsOneWidget);
    });

    testWidgets('has proper widget structure', (WidgetTester tester) async {
      await tester.pumpWidget(createWrapper());

      expect(find.byType(FeedbackWrapper), findsOneWidget);
      expect(find.text('Child Widget'), findsOneWidget);
    });
  });
}
