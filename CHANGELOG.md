## 1.0.0

### Features

* **Smart Rating System**: Analytics-driven rating prompts based on user engagement
* **Animated Star Views**: Beautiful sequential star animations with fade-in, zoom, and rotation effects
* **Customizable UI Components**: 
  - `DefaultStarsView` with customizable star builders
  - `DefaultButtonView` with multiple styles (normal, secondary, transparent, border)
  - `DefaultDialogBuilder` for rating dialogs
  - `DefaultSuccessDialogView` for feedback confirmation
* **Flexible Architecture**:
  - `FeedbackWrapper` for easy app integration
  - `FeedbackRepoProvider` for state management
  - `WriteFeedbackScreen` for collecting user feedback
  - `DoYouLoveUsDialog` for rating prompts
* **Event-Based Triggers**: Configurable counters for when to show rating prompts
* **Platform Integration**: Native in-app review support via `in_app_review` package
* **State Management**: Built on `flutter_bloc` for reliable state handling
* **Persistent Storage**: User preferences and counters stored via `shared_preferences`
* **Version Awareness**: Smart handling of app version changes
* **Delay Support**: Configurable delays between rating prompt attempts

### Dependencies

* `flutter_bloc: ^9.1.1` - State management
* `shared_preferences: ^2.5.3` - Local storage
* `in_app_review: ^2.0.10` - Native review dialogs
* `package_info_plus: ^8.3.1` - App version detection
* `freezed: ^3.2.0` - Immutable data classes
* `json_serializable: ^6.10.0` - JSON serialization

### Getting Started

See README.md for detailed implementation guide and examples.
