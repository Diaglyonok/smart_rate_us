import 'dart:async';

abstract class ConfigsService {
  void startLoading();
  FutureOr<Map<String, dynamic>?> getConfigs();
}
