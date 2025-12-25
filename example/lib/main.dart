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
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: FeedbackWrapper(
        feedbackConfig: FeedbackWrapperConfig.defaultConfig(feedbackService: FakeFeedbackService()),
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
