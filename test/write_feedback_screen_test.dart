import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_rate_us/data/feedback_service.dart';
import 'package:smart_rate_us/logic/config_repository.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/widgets/write_feedback_screen.dart';

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

void main() {
  group('WriteFeedbackScreen', () {
    late FeedbackRepository feedbackRepository;
    late bool successCallbackCalled;

    setUp(() {
      feedbackRepository = FeedbackRepository(
        feedbackService: MockFeedbackService(),
        remoteConfigRepo: MockConfigsService(),
      );
      successCallbackCalled = false;
    });

    Widget createScreen({
      WriteFeedbackPageBuilder? builder,
      Future<void> Function(BuildContext)? onSuccess,
    }) {
      return MaterialApp(
        home: RepositoryProvider.value(
          value: feedbackRepository,
          child: WriteFeedbackScreen(
            onPopCallback: (context) async {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            builder:
                builder ??
                (context, isLoading, onSend) {
                  return Column(
                    children: [
                      Text(isLoading ? 'Loading...' : 'Ready'),
                      ElevatedButton(
                        onPressed: () => onSend({'test': 'feedback'}),
                        child: const Text('Send'),
                      ),
                    ],
                  );
                },
            onFinalSuccessCallback:
                onSuccess ??
                (context) async {
                  successCallbackCalled = true;
                },
          ),
        ),
      );
    }

    testWidgets('renders builder content correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createScreen());

      expect(find.text('Ready'), findsOneWidget);
      expect(find.text('Send'), findsOneWidget);
      expect(find.byType(WriteFeedbackScreen), findsOneWidget);
    });

    testWidgets('builder receives isLoading parameter', (
      WidgetTester tester,
    ) async {
      bool receivedLoadingState = false;

      await tester.pumpWidget(
        MaterialApp(
          home: RepositoryProvider.value(
            value: feedbackRepository,
            child: WriteFeedbackScreen(
              onPopCallback: (context) async {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, isLoading, onSend) {
                receivedLoadingState = isLoading;
                return Text(isLoading ? 'Loading' : 'Ready');
              },
              onFinalSuccessCallback: (context) async {},
            ),
          ),
        ),
      );

      expect(find.text('Ready'), findsOneWidget);
      expect(receivedLoadingState, isFalse);
    });

    testWidgets('calls onSend callback when button pressed', (
      WidgetTester tester,
    ) async {
      Map<String, dynamic>? sentFeedback;

      await tester.pumpWidget(
        MaterialApp(
          home: RepositoryProvider.value(
            value: feedbackRepository,
            child: WriteFeedbackScreen(
              onPopCallback: (context) async {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, isLoading, onSend) {
                return ElevatedButton(
                  onPressed: () {
                    sentFeedback = {'test': 'data'};
                    onSend(sentFeedback!);
                  },
                  child: const Text('Send Feedback'),
                );
              },
              onFinalSuccessCallback: (context) async {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('Send Feedback'));
      await tester.pump();

      expect(sentFeedback, isNotNull);
      expect(sentFeedback!['test'], equals('data'));
    });

    testWidgets('creates screen without errors', (WidgetTester tester) async {
      await tester.pumpWidget(createScreen());

      expect(find.byType(WriteFeedbackScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('handles custom success callback', (WidgetTester tester) async {
      bool customCallbackCalled = false;

      await tester.pumpWidget(
        createScreen(
          onSuccess: (context) async {
            customCallbackCalled = true;
          },
        ),
      );

      await tester.tap(find.text('Send'));
      await tester.pumpAndSettle();

      expect(customCallbackCalled, isTrue);
      expect(successCallbackCalled, isFalse);
    });

    testWidgets('provides correct parameters to builder', (
      WidgetTester tester,
    ) async {
      bool isLoadingParam = false;
      bool onSendCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: RepositoryProvider.value(
            value: feedbackRepository,
            child: WriteFeedbackScreen(
              onPopCallback: (context) async {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, isLoading, onSend) {
                isLoadingParam = isLoading;
                return ElevatedButton(
                  onPressed: () {
                    onSendCalled = true;
                    onSend({'feedback': 'test'});
                  },
                  child: Text(isLoading ? 'Sending...' : 'Send'),
                );
              },
              onFinalSuccessCallback: (context) async {},
            ),
          ),
        ),
      );

      // Initially not loading
      expect(isLoadingParam, isFalse);
      expect(find.text('Send'), findsOneWidget);

      // Tap to send
      await tester.tap(find.text('Send'));
      await tester.pump();

      expect(onSendCalled, isTrue);
    });
  });
}
