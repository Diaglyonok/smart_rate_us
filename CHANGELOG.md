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

## 1.0.1

Updated Readme.md

## 1.1.0

### 🚀 Breaking Changes

* **Router Support**: Added navigation callbacks for custom router compatibility
  - Added `onPopCallback` parameter to `FeedbackWrapperConfig`
  - Added `onWriteFeedbackCallback` parameter to `FeedbackWrapperConfig`
  - Both callbacks are now required in custom configurations
  - `FeedbackWrapperConfig.defaultConfig()` provides backward-compatible defaults

### ✨ New Features

* **Custom Router Compatibility**: Full support for go_router, AutoRoute, and other custom routers
* **Navigation Flexibility**: No more hard dependency on `Navigator.of(context)`
* **Improved Documentation**: Added router examples in README and code documentation

### 🛠️ Improvements

* **Code Quality**: Fixed deprecated `Matrix4.translate()` warnings
* **Formatting**: Applied consistent Dart formatting across all files
* **iOS Compatibility**: Updated minimum iOS version to 13.0
* **Dependencies**: Changed `flutter_bloc` to flexible version constraint

### 📚 Documentation

* Added router support examples in README
* Improved API documentation with usage examples
* Added migration examples for different router types

### 🧪 Testing

* All existing tests continue to pass
* Added proper callback handling in test scenarios

## 1.1.1

Updated changelog
Updated umbrella smart_rate_us.dart file

## 1.1.2

Updated colors:
  default widgets now use primary color instead of secondary