# Smart Rate Us

A Flutter package for smart app rating prompts with customizable UI and analytics-driven triggers.

## Features

- **Smart Triggering**: Show rating prompts based on user actions and engagement metrics
- **Customizable UI**: Complete control over dialog appearance and animations
- **Analytics Integration**: Track user interactions and feedback patterns
- **Animated Stars**: Beautiful sequential star animations with bounce effects
- **Flexible Configuration**: Easy setup with sensible defaults
- **In-App Review Support**: Seamless integration with platform-native review flows

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  smart_rate_us: ^1.0.0
```

## Usage

### Basic Setup

Wrap your app with `FeedbackWrapper`:

```dart
import 'package:smart_rate_us/widgets/feedback_wrapper.dart';
import 'package:smart_rate_us/default/default_feedback_service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackWrapper(
        feedbackConfig: FeedbackWrapperConfig.defaultConfig(
          feedbackService: YourFeedbackService(), // Implement FeedbackService
        ),
        child: YourMainWidget(),
      ),
    );
  }
}
```

### Trigger Rating Prompts

```dart
// Trigger rating prompt after specific user actions
FeedbackRepoProvider.of(context)?.addCounterAndCheck('success_action_5');
```

### Custom Dialog UI

```dart
FeedbackWrapperConfig(
  feedbackService: YourFeedbackService(),
  remoteConfigRepo: YourConfigService(),
  doYouLoveUsDialogBuilder: (context, onLike, onDislike, onRemindLater) {
    return YourCustomDialog(
      onLike: onLike,
      onDislike: onDislike, 
      onRemindLater: onRemindLater,
    );
  },
  writeFeedbackPageBuilder: (context, isLoading, onSend) {
    return YourCustomFeedbackForm(
      isLoading: isLoading,
      onSend: onSend,
    );
  },
  onFinalSuccessCallback: (context) async {
    // Handle success
  },
)
```

### Animated Stars Widget

Use the included animated stars widget:

```dart
DefaultStarsView(
  starBuilder: (context) => Icon(
    Icons.star,
    color: Colors.amber,
    size: 48,
  ),
)
```

## Configuration

The package supports event-based triggering with configurable thresholds:

```json
{
  "events": {
    "success_action_2": 2,
    "success_action_3": 3,
    "success_action_5": 5,
    "success_action_10": 10
  },
  "expiration_delay_days": 7,
  "do_not_disturb_on_new_version": true
}
```

## Implementation Requirements

### Implement FeedbackService

```dart
class YourFeedbackService extends FeedbackService {
  @override
  Future<bool> sendFeedback({required Map<String, dynamic> feedback}) async {
    // Send feedback to your backend
    return true; // Return success status
  }
}
```

### Implement ConfigsService (Optional)

```dart
class YourConfigService extends ConfigsService {
  @override
  void startLoading() {
    // Start loading remote config
  }

  @override
  FutureOr<Map<String, dynamic>?> getConfigs() async {
    // Return your remote config
    return yourRemoteConfig;
  }
}
```

## Widget Components

- **FeedbackWrapper**: Main wrapper component
- **DoYouLoveUsDialog**: Rating prompt dialog
- **WriteFeedbackScreen**: Feedback collection screen
- **DefaultStarsView**: Animated stars component
- **DefaultButtonView**: Customizable button component

## License

MIT License - see LICENSE file for details.
