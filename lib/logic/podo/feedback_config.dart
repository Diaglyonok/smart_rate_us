// Note: Didn't use freezed to avoid dependencies issues in future

import 'package:smart_rate_us/utils/map_utils.dart';

class FeedbackConfig {
  final Map<String, int>? events;
  final int? expirationDelayDays;
  final bool? doNotDisturbOnNewVersion;

  const FeedbackConfig({this.events, this.expirationDelayDays, this.doNotDisturbOnNewVersion});

  Map<String, dynamic> toJson() {
    return {
      'events': events,
      'expiration_delay_days': expirationDelayDays,
      'do_not_disturb_on_new_version': doNotDisturbOnNewVersion,
    };
  }

  factory FeedbackConfig.fromJson(Map<String, dynamic> json) {
    return FeedbackConfig(
      events: json['events'] != null ? Map<String, int>.from(json['events'] as Map) : null,
      expirationDelayDays: json['expiration_delay_days'] as int?,
      doNotDisturbOnNewVersion: json['do_not_disturb_on_new_version'] as bool?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FeedbackConfig &&
        mapEquals(other.events, events) &&
        other.expirationDelayDays == expirationDelayDays &&
        other.doNotDisturbOnNewVersion == doNotDisturbOnNewVersion;
  }

  @override
  int get hashCode {
    return events.hashCode ^ expirationDelayDays.hashCode ^ doNotDisturbOnNewVersion.hashCode;
  }

  @override
  String toString() {
    return 'FeedbackConfig(events: $events, expirationDelayDays: $expirationDelayDays, doNotDisturbOnNewVersion: $doNotDisturbOnNewVersion)';
  }
}
