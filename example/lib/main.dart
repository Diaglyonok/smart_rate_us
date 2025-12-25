import 'package:flutter/material.dart';
import 'package:smart_rate_us/default/default_feedback_service.dart';
import 'package:smart_rate_us/widgets/feedaback_repo_provider.dart';
import 'package:smart_rate_us/widgets/feedback_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          surface: AppColors.surfaceLight,
        ),
        scaffoldBackgroundColor: AppColors.backgroundLight,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundLight,
          foregroundColor: AppColors.textPrimaryLight,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryLight,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.borderLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          filled: true,
          fillColor: AppColors.surfaceLight,
        ),
      ),
      home: FeedbackWrapper(
        feedbackConfig: FeedbackWrapperConfig.defaultConfig(feedbackService: FakeFeedbackService()),
        getUserEmail: (context) => 'user@example.com',
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      FeedbackRepoProvider.of(context)?.addCounterAndCheck('success_action_3');
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            TextButton(
              onPressed: () {
                FeedbackRepoProvider.of(context)?.addCounterAndCheck('success_action_5');
              },
              child: const Text('Add 5'),
            ),

            TextButton(
              onPressed: () {
                FeedbackRepoProvider.of(context)?.resetCounters();
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0x1A6366F1); // 10% opacity
  static const Color secondary = Color(0xFF8B5CF6);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5); // green.shade100
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7); // orange.shade100
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2); // red.shade100
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDEECFF); // blue.shade100

  // Neutral Colors - Light Theme
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF9FAFB); // grey.shade50
  static const Color surface2Light = Color(0xFFF3F4F6); // grey.shade100
  static const Color surface3Light = Color(0xFFE5E7EB); // grey.shade200
  static const Color onSurface = Color(0xFF111827); // black87 equivalent
  static const Color onSurfaceLight = Color(0xFF6B7280); // grey.shade50

  // Text Colors - Light Theme
  static const Color textPrimaryLight = Color(0xFF111827); // black87 equivalent
  static const Color textSecondaryLight = Color(0xFF6B7280); // grey.shade500
  static const Color textTertiaryLight = Color(0xFF9CA3AF); // grey.shade400
  static const Color textDisabledLight = Color(0xFFD1D5DB); // grey.shade300

  // Border Colors - Light Theme
  static const Color borderLight = Color(0xFFE5E7EB); // grey.shade200
  static const Color borderFocusedLight = primary;
  static const Color borderErrorLight = error;

  // Neutral Colors - Dark Theme (future)
  static const Color backgroundDark = Color(0xFF0F0F0F);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surface2Dark = Color(0xFF262626);
  static const Color surface3Dark = Color(0xFF404040);

  // Text Colors - Dark Theme (future)
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);
  static const Color textTertiaryDark = Color(0xFF9CA3AF);
  static const Color textDisabledDark = Color(0xFF6B7280);

  // Border Colors - Dark Theme (future)
  static const Color borderDark = Color(0xFF374151);
  static const Color borderFocusedDark = primary;
  static const Color borderErrorDark = error;

  // Special Colors
  static const Color purpleLight = Color(0xFFEDE9FE);

  // Gradient Colors
  static const List<Color> primaryGradient = [primary, secondary];
  static const List<Color> disabledGradient = [
    Color(0xFFD1D5DB), // grey.shade300
    Color(0xFF9CA3AF), // grey.shade400
  ];
}
