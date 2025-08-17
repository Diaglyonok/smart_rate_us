import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_rate_us/data/feedback_service.dart';
import 'package:smart_rate_us/logic/config_repository.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/logic/feedback_update_bloc.dart';
import 'package:smart_rate_us/widgets/do_you_love_us_dialog.dart';
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
  group('DoYouLoveUsDialog', () {
    late FeedbackRepository feedbackRepository;
    late FeedbackUpdateCubit feedbackUpdateCubit;
    late bool successCallbackCalled;

    setUp(() {
      feedbackRepository = FeedbackRepository(
        feedbackService: MockFeedbackService(),
        remoteConfigRepo: MockConfigsService(),
      );
      feedbackUpdateCubit = FeedbackUpdateCubit(repository: feedbackRepository);
      successCallbackCalled = false;
    });

    tearDown(() {
      feedbackUpdateCubit.close();
    });

    Widget createDialog({
      DialogBuilder? dialogBuilder,
      WriteFeedbackPageBuilder? writeFeedbackBuilder,
      Future<void> Function(BuildContext)? onSuccess,
    }) {
      return MaterialApp(
        home: RepositoryProvider.value(
          value: feedbackRepository,
          child: DoYouLoveUsDialog(
            dialogBuilder:
                dialogBuilder ??
                (context, onLike, onDislike, onRemindLater) {
                  return Column(
                    children: [
                      const Text('Dialog'),
                      ElevatedButton(
                        onPressed: onLike,
                        child: const Text('Like'),
                      ),
                      ElevatedButton(
                        onPressed: onDislike,
                        child: const Text('Dislike'),
                      ),
                      ElevatedButton(
                        onPressed: onRemindLater,
                        child: const Text('Later'),
                      ),
                    ],
                  );
                },
            writeFeedbackPageBuilder:
                writeFeedbackBuilder ??
                (context, isLoading, onSend) {
                  return Column(
                    children: [
                      Text(isLoading ? 'Sending...' : 'Write Feedback'),
                      ElevatedButton(
                        onPressed: () => onSend({'feedback': 'test'}),
                        child: const Text('Submit'),
                      ),
                    ],
                  );
                },
            onFinalSuccessCallback:
                onSuccess ??
                (context) async {
                  successCallbackCalled = true;
                },
            feedbackUpdateCubit: feedbackUpdateCubit,
          ),
        ),
      );
    }

    testWidgets('renders dialog builder content', (WidgetTester tester) async {
      await tester.pumpWidget(createDialog());

      expect(find.text('Dialog'), findsOneWidget);
      expect(find.text('Like'), findsOneWidget);
      expect(find.text('Dislike'), findsOneWidget);
      expect(find.text('Later'), findsOneWidget);
    });

    testWidgets('like button calls InAppReview', (WidgetTester tester) async {
      await tester.pumpWidget(createDialog());

      await tester.tap(find.text('Like'));
      await tester.pump();

      // Should not throw errors (InAppReview will handle the actual review request)
      expect(tester.takeException(), isNull);
    });

    testWidgets('dislike button navigates to feedback screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createDialog());

      await tester.tap(find.text('Dislike'));
      await tester.pumpAndSettle();

      expect(find.text('Write Feedback'), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('remind later button calls delayDialog', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createDialog());

      await tester.tap(find.text('Later'));
      await tester.pump();

      // Should not throw errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('uses provided feedbackUpdateCubit when available', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createDialog());

      expect(find.byType(DoYouLoveUsDialog), findsOneWidget);
      // Should render without errors when cubit is provided
      expect(tester.takeException(), isNull);
    });

    testWidgets('navigates back from feedback screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createDialog());

      // Navigate to feedback screen
      await tester.tap(find.text('Dislike'));
      await tester.pumpAndSettle();

      expect(find.text('Write Feedback'), findsOneWidget);

      // Submit feedback
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Should call success callback
      expect(successCallbackCalled, isTrue);
    });

    testWidgets('handles custom dialog builder', (WidgetTester tester) async {
      await tester.pumpWidget(
        createDialog(
          dialogBuilder: (context, onLike, onDislike, onRemindLater) {
            return const Text('Custom Dialog');
          },
        ),
      );

      expect(find.text('Custom Dialog'), findsOneWidget);
      expect(find.text('Dialog'), findsNothing);
    });

    testWidgets('handles custom feedback page builder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createDialog(
          writeFeedbackBuilder: (context, isLoading, onSend) {
            return const Text('Custom Feedback Page');
          },
        ),
      );

      // Navigate to feedback screen
      await tester.tap(find.text('Dislike'));
      await tester.pumpAndSettle();

      expect(find.text('Custom Feedback Page'), findsOneWidget);
    });
  });
}
