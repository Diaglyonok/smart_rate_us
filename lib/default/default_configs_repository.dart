import 'dart:async';

import 'package:smart_rate_us/logic/config_repository.dart';

class DefaultFeedbackConfigsRepository implements ConfigsService {
  static const _defaultConfigs = {
    "events": {
      "success_action_2": 2,
      "success_action_3": 3,
      "success_action_5": 5,
      "success_action_7": 7,
      "success_action_10": 10,
    },
    "expiration_delay_days": 7,
    "do_not_disturb_on_new_version": true,
  };

  Map<String, dynamic>? _configs;

  @override
  FutureOr<Map<String, dynamic>?> getConfigs() async {
    if (_configs != null) {
      return _configs;
    }

    await _doLoadConfigs();
    return _configs;
  }

  @override
  void startLoading() {
    _doLoadConfigs();
  }

  Future<void> _doLoadConfigs() async {
    Future.delayed(const Duration(seconds: 1), () {
      _configs = _defaultConfigs;
    });
  }
}
