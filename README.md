# Smart Rate Us

A Flutter package for intelligent app rating prompts with customizable UI and analytics-driven triggers.
### This package will improve your app's rating and search position by intelligently filtering negative reviews from your users.

## Principle

//will be added scheme later, don't touch

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
          // Implement FeedbackService - use FakeFeedbackService as an example
          feedbackService: YourFeedbackService(),
        ),
        child: YourMainWidget(),
      ),
    );
  }
}
```

**Note**: This uses default configurations and UI. Try it to see how it looks and works for you.
It uses non-localized English strings. You can check the implementation and adjust it for your needs.

Check the implementation of:
- `DefaultFeedbackConfigsRepository`
- `buildDefaultDialogWidget`
- `buildDefaultWriteUsPageWidget`
- `defaultOpenDialogCallback`
- `FeedbackWrapperConfig.defaultConfig`

for examples.

Every UI step, loading of configurations, and sending messages to your service are fully adjustable for your needs.

### Trigger Rating Prompts

```dart
// Trigger rating prompt after specific user actions
FeedbackRepoProvider.of(context)?.addCounterAndCheck('success_action_5');
```

Or use the `onRepositoryCreated` callback to save `FeedbackRepo` to your own DI container and use it later.

### Custom Dialog UI

**Recommended**: Use `FeedbackWrapperConfig.defaultConfig` default values as examples and configure your own.

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
    // Show your dialogs here, then call Navigator.of(context).pop(); to close write feedback route
  },
)
```

### Animated Stars Widget

Use the included animated stars widget in `DoYouLoveUsDefaultDialog` or in your own implementation.

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

You can create your own events with custom names and counts.
Other fields can also be configured in a `ConfigsService`.

Use `DefaultFeedbackConfigsRepository` as an example.

- **events**: Success cases where the value represents the number of cases required to trigger the dialog
- **expiration_delay_days**: When a user clicks "Remind me later", it will be delayed for that many days
- **do_not_disturb_on_new_version**: Configuration that resets all current settings after a new release

These settings can be stored in Firebase Remote Config or your own service and can be adjusted anytime.

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
