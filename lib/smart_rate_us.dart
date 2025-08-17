/// Smart Rate Us - A Flutter package for intelligent app rating prompts
///
/// This package provides a comprehensive solution for collecting user feedback
/// and ratings in Flutter applications. It features analytics-driven triggers,
/// customizable UI components, and seamless integration with platform-native
/// review systems.
///
/// ## Key Features
///
/// - **Smart Triggering**: Show rating prompts based on user engagement metrics
/// - **Animated UI**: Beautiful star animations with bounce effects
/// - **Customizable Components**: Complete control over dialog and form appearance
/// - **Analytics Integration**: Track user interactions and feedback patterns
/// - **In-App Review Support**: Native platform review integration
/// - **State Management**: Built on flutter_bloc for reliable state handling
///
/// ## Quick Start
///
/// 1. Wrap your app with [FeedbackWrapper]:
/// ```dart
/// MaterialApp(
///   home: FeedbackWrapper(
///     feedbackConfig: FeedbackWrapperConfig.defaultConfig(
///       feedbackService: YourFeedbackService(),
///     ),
///     child: YourMainWidget(),
///   ),
/// )
/// ```
///
/// 2. Trigger rating prompts:
/// ```dart
/// FeedbackRepoProvider.of(context)?.addCounterAndCheck('success_action_5');
/// ```
///
/// ## Core Components
///
/// - [FeedbackWrapper] - Main wrapper widget that sets up the feedback system
/// - [FeedbackRepoProvider] - Provides access to feedback functionality
/// - [DoYouLoveUsDialog] - Handles the initial rating prompt
/// - [WriteFeedbackScreen] - Collects detailed user feedback
/// - [DefaultStarsView] - Animated star rating component
///
/// ## Architecture
///
/// The package uses a layered architecture:
/// - **Widgets Layer**: UI components and screens
/// - **Logic Layer**: Business logic and state management
/// - **Data Layer**: Services and repositories
/// - **Default Layer**: Pre-built implementations and UI components
library;

// Core functionality - Main widgets for implementing feedback flow
export 'widgets/feedback_wrapper.dart'
    show FeedbackWrapper, FeedbackWrapperConfig;
export 'widgets/feedaback_repo_provider.dart' show FeedbackRepoProvider;
export 'widgets/do_you_love_us_dialog.dart'
    show DoYouLoveUsDialog, DialogBuilder;
export 'widgets/write_feedback_screen.dart'
    show WriteFeedbackScreen, WriteFeedbackPageBuilder;

// Data and logic - Core interfaces and business logic
export 'data/feedback_service.dart' show FeedbackService;
export 'logic/config_repository.dart' show ConfigsService;
export 'logic/feedback_repository.dart'
    show
        FeedbackRepository,
        FeedbackRepoResponse,
        FeedbackRepoLoadResponse,
        FeedbackRepoUpdateResponse;
export 'logic/feedback_bloc.dart'
    show FeedbackCubit, FeedbackBaseState, ShowFeedbackState;
export 'logic/feedback_update_bloc.dart'
    show
        FeedbackUpdateCubit,
        FeedbackUpdateBaseState,
        UpdateInProgressState,
        UpdateSucceededState;
export 'logic/podo/feedback_config.dart' show FeedbackConfig;
export 'logic/podo/current_event_counters.dart' show CurrentFeedbackCounters;

// Default implementations - Pre-built components ready to use
export 'default/default_feedback_service.dart' show FakeFeedbackService;
export 'default/default_configs_repository.dart'
    show DefaultFeedbackConfigsRepository;
export 'default/views/default_stars_view.dart' show DefaultStarsView;
export 'default/views/default_button_view.dart' show DefaultButtonView;
export 'default/views/default_dialog_builder.dart'
    show
        DoYouLoveUsDefaultDialog,
        DefaultDialogTextConfig,
        buildDefaultDialogWidget,
        defaultOpenDialogCallback,
        makeInformDialog;
export 'default/views/default_success_dialog_view.dart'
    show
        DefaultSuccessDialogView,
        DefaultSuccessDialogTextConfig,
        buildDefaultSuccessDialogView;
export 'default/views/default_write_us_page_builder.dart'
    show buildDefaultWriteUsPageWidget;
