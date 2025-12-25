// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:clean_cubit_reactor/clean_cubit_reactor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rate_us/data/feedback_service.dart';
import 'package:smart_rate_us/logic/config_repository.dart';
import 'package:smart_rate_us/logic/listeners_type.dart';
import 'package:smart_rate_us/logic/podo/current_event_counters.dart';
import 'package:smart_rate_us/logic/podo/feedback_config.dart';
import 'package:smart_rate_us/utils/app_data.dart';

const int INT_FEEDBACK_MAX_VALUE = 10000;

const int DEFAULT_DELAY_DAYS = 14;

const String requestCreatedEventKey = 'request_created';
const String requestArchivedEventKey = 'request_archived';
const String exportDoneEventKey = 'export_done';

const String SHARED_PREFS_FEEDBACK_KEY = 'shared_prefs_feedback_key';

class FeedbackRepository with Reactor<ListenersType, FeedbackRepoResponse> {
  FeedbackRepository({
    required this.feedbackService,
    required ConfigsService remoteConfigRepo,
    this.onDebugPrint,
  }) {
    _remoteConfigRepo = remoteConfigRepo;
    _remoteConfigRepo.startLoading();
  }
  late ConfigsService _remoteConfigRepo;
  final FeedbackService feedbackService;

  final void Function(String)? onDebugPrint;

  Future<void> sendFeedback(Map<String, dynamic> feedback) async {
    setLoading(currentData: FeedbackRepoUpdateResponse());
    final bool sent = await feedbackService.sendFeedback(feedback: feedback);
    provideDataToListeners(FeedbackRepoUpdateResponse(taskDone: sent));
  }

  ///should be called when event with [eventName] is caught
  ///
  void addCounterAndCheck(String eventName) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    try {
      final mapConfig = await _remoteConfigRepo.getConfigs();
      final config = mapConfig == null ? null : FeedbackConfig.fromJson(mapConfig);

      if (config == null) {
        throw Exception('configs null');
      }

      final events = config.events;

      if (events == null) {
        throw Exception('null events');
      }

      final counter = events[eventName];

      if (counter == null) {
        throw Exception('invalid counter');
      }

      final prefs = await SharedPreferences.getInstance();

      /// getting current counters map
      CurrentFeedbackCounters currentCounters = _loadCounters(prefs);

      final Map<String, int> eventsMap = {};
      eventsMap.addAll(currentCounters.events ?? {});

      /// incrementing [eventName] counter
      int value = eventsMap[eventName] ?? 0;
      value += 1;

      if (value >= INT_FEEDBACK_MAX_VALUE - 1) {
        value -= 1;
      }

      final currVersion = await _appVersion();

      final savedAppVersion = currentCounters.savedAppVersion ?? currVersion;
      final dontDisturb = config.doNotDisturbOnNewVersion ?? false;

      /// if last time dialog was shown in another app version and also dont_disturb_on_new_versions is false
      /// we will renew all the counters (set all to 0 and reacted one to 1) and set feedbackDialogShown to false;
      /// so next time any counter will reach needed number, dialog will be shown.
      /// dont_disturb_on_new_versions is true, we'll skip it and dialog won't be shown
      ///
      if (savedAppVersion != currVersion && !dontDisturb) {
        for (final String key in events.keys.toList()) {
          int v = 0;
          if (key == eventName) {
            v = 1;
          }

          eventsMap[key] = v;
        }

        currentCounters = currentCounters.copyWith(
          feedbackDialogShown: false,
          savedAppVersion: currVersion,
          events: eventsMap,
        );

        _saveCounters(prefs, currentCounters);

        /// FeedbackRepoResponse() has countersBorderPassed = false, so bloc shouldn't react to it
        /// showing feedback dialog.
        provideDataToListeners(FeedbackRepoLoadResponse());
        return;
      }

      eventsMap[eventName] = value;
      currentCounters = currentCounters.copyWith(events: eventsMap);

      onDebugPrint?.call('added constant value to $eventName, val is $value');

      bool hasShown = currentCounters.feedbackDialogShown ?? false;
      hasShown = _checkDelayed(config, currentCounters, hasShown);

      if (value >= counter && !hasShown) {
        currentCounters = currentCounters.copyWith(
          feedbackDialogShown: true,
          savedAppVersion: currVersion,
          feedbackDelayDateMillis: null,
        );

        provideDataToListeners(FeedbackRepoLoadResponse.passed());
        _saveCounters(prefs, currentCounters);
        return;
      }

      provideDataToListeners(FeedbackRepoLoadResponse());
      _saveCounters(prefs, currentCounters);
    } catch (e) {
      onDebugPrint?.call(
        'Catched Exception: cannot write $eventName value. Cause: ${e.toString()}',
      );
    }

    provideDataToListeners(FeedbackRepoLoadResponse());
  }

  Future<void> resetCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final currentCounters = _loadCounters(prefs);

    await _saveCounters(
      prefs,
      currentCounters.copyWith(
        events: {},
        savedAppVersion: null,
        feedbackDialogShown: false,
        feedbackDelayDateMillis: null,
      ),
    );
  }

  Future<void> delayDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final currentCounters = _loadCounters(prefs);

    final now = DateTime.now();

    await _saveCounters(
      prefs,
      currentCounters.copyWith(feedbackDelayDateMillis: now.millisecondsSinceEpoch),
    );
    onDebugPrint?.call('feedback delayed for $DEFAULT_DELAY_DAYS days (default, could be changed)');
  }

  Future<bool> _saveCounters(SharedPreferences prefs, CurrentFeedbackCounters counters) async {
    return prefs.setString(SHARED_PREFS_FEEDBACK_KEY, jsonEncode(counters.toJson()));
  }

  CurrentFeedbackCounters _loadCounters(SharedPreferences prefs) {
    CurrentFeedbackCounters currentCounters = CurrentFeedbackCounters();

    // current counters map is storred in preferences, could be moved to any other storage if needed.
    try {
      currentCounters = CurrentFeedbackCounters.fromJson(
        jsonDecode(prefs.getString(SHARED_PREFS_FEEDBACK_KEY)!) as Map<String, dynamic>,
      );
    } catch (e) {
      //couldn't parse, nothing to do
    }

    return currentCounters;
  }

  bool _checkDelayed(
    FeedbackConfig mapCounters,
    CurrentFeedbackCounters currentCounters,
    bool hasShown,
  ) {
    final int diff = mapCounters.expirationDelayDays ?? DEFAULT_DELAY_DAYS;

    final int? delayedDate = currentCounters.feedbackDelayDateMillis;

    if (!hasShown || delayedDate == null) {
      return hasShown;
    }

    //return false if screen needs to be shown,
    //return true when screen doesn't need to be shown.
    return DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(delayedDate)).inDays <
        diff;
  }

  Future<String> _appVersion() async {
    final packageInfo = await AppVersion.getPackageInfo();
    return packageInfo.version;
  }
}

abstract class FeedbackRepoResponse extends ReactorResponse<ListenersType> {}

class FeedbackRepoLoadResponse extends FeedbackRepoResponse {
  FeedbackRepoLoadResponse() : countersBorderPassed = false;

  FeedbackRepoLoadResponse.passed() : countersBorderPassed = true;
  final bool countersBorderPassed;

  @override
  ListenersType get type => ListenersType.loadListener;
}

class FeedbackRepoUpdateResponse extends FeedbackRepoResponse {
  FeedbackRepoUpdateResponse({this.taskDone = false});
  final bool taskDone;

  @override
  ListenersType get type => ListenersType.updateListener;
}
