// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedbackConfig _$FeedbackConfigFromJson(Map<String, dynamic> json) =>
    _FeedbackConfig(
      events: (json['events'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      expirationDelayDays: (json['expiration_delay_days'] as num?)?.toInt(),
      doNotDisturbOnNewVersion: json['do_not_disturb_on_new_version'] as bool?,
    );

Map<String, dynamic> _$FeedbackConfigToJson(_FeedbackConfig instance) =>
    <String, dynamic>{
      'events': instance.events,
      'expiration_delay_days': instance.expirationDelayDays,
      'do_not_disturb_on_new_version': instance.doNotDisturbOnNewVersion,
    };
