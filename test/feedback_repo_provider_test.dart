import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_rate_us/data/feedback_service.dart';
import 'package:smart_rate_us/logic/config_repository.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/widgets/feedaback_repo_provider.dart';

class MockFeedbackService extends FeedbackService {
  @override
  Future<bool> sendFeedback({required Map<String, dynamic> feedback}) async {
    return true;
  }
}

class MockConfigsService extends ConfigsService {
  @override
  void startLoading() {}

  @override
  FutureOr<Map<String, dynamic>?> getConfigs() async {
    return {};
  }
}

class MockFeedbackRepository extends FeedbackRepository {
  MockFeedbackRepository()
    : super(
        feedbackService: MockFeedbackService(),
        remoteConfigRepo: MockConfigsService(),
      );
}

void main() {
  group('FeedbackRepoProvider', () {
    late MockFeedbackRepository mockRepository;

    setUp(() {
      mockRepository = MockFeedbackRepository();
    });

    testWidgets('provides feedback repository to child widgets', (
      WidgetTester tester,
    ) async {
      FeedbackRepository? providedRepository;

      await tester.pumpWidget(
        MaterialApp(
          home: FeedbackRepoProvider(
            feedbackRepository: mockRepository,
            child: Builder(
              builder: (context) {
                providedRepository = FeedbackRepoProvider.of(context);
                return const Text('Child');
              },
            ),
          ),
        ),
      );

      expect(providedRepository, equals(mockRepository));
      expect(find.text('Child'), findsOneWidget);
    });

    testWidgets('returns null when no provider found', (
      WidgetTester tester,
    ) async {
      FeedbackRepository? providedRepository;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              providedRepository = FeedbackRepoProvider.of(context);
              return const Text('No Provider');
            },
          ),
        ),
      );

      expect(providedRepository, isNull);
      expect(find.text('No Provider'), findsOneWidget);
    });

    testWidgets('updateShouldNotify returns true when repository changes', (
      WidgetTester tester,
    ) async {
      final provider1 = FeedbackRepoProvider(
        feedbackRepository: mockRepository,
        child: const Text('Test'),
      );

      final provider2 = FeedbackRepoProvider(
        feedbackRepository: MockFeedbackRepository(),
        child: const Text('Test'),
      );

      expect(provider1.updateShouldNotify(provider2), isTrue);
    });

    testWidgets('updateShouldNotify returns false when repository is same', (
      WidgetTester tester,
    ) async {
      final provider1 = FeedbackRepoProvider(
        feedbackRepository: mockRepository,
        child: const Text('Test'),
      );

      final provider2 = FeedbackRepoProvider(
        feedbackRepository: mockRepository,
        child: const Text('Test'),
      );

      expect(provider1.updateShouldNotify(provider2), isFalse);
    });

    testWidgets('can be nested and provides correct repository', (
      WidgetTester tester,
    ) async {
      final outerRepo = MockFeedbackRepository();
      final innerRepo = MockFeedbackRepository();

      FeedbackRepository? outerProvidedRepo;
      FeedbackRepository? innerProvidedRepo;

      await tester.pumpWidget(
        MaterialApp(
          home: FeedbackRepoProvider(
            feedbackRepository: outerRepo,
            child: Builder(
              builder: (context) {
                outerProvidedRepo = FeedbackRepoProvider.of(context);
                return FeedbackRepoProvider(
                  feedbackRepository: innerRepo,
                  child: Builder(
                    builder: (context) {
                      innerProvidedRepo = FeedbackRepoProvider.of(context);
                      return const Text('Nested');
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(outerProvidedRepo, equals(outerRepo));
      expect(innerProvidedRepo, equals(innerRepo));
      expect(find.text('Nested'), findsOneWidget);
    });
  });
}
