// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_event_counters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentFeedbackCounterss _$CurrentFeedbackCounterssFromJson(
  Map<String, dynamic> json,
) => _CurrentFeedbackCounterss(
  events: (json['events'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
  savedAppVersion: json['savedAppVersion'] as String?,
  feedbackDialogShown: json['feedbackDialogShown'] as bool? ?? false,
  feedbackDelayDateMillis: (json['feedbackDelayDateMillis'] as num?)?.toInt(),
);

Map<String, dynamic> _$CurrentFeedbackCounterssToJson(
  _CurrentFeedbackCounterss instance,
) => <String, dynamic>{
  'events': instance.events,
  'savedAppVersion': instance.savedAppVersion,
  'feedbackDialogShown': instance.feedbackDialogShown,
  'feedbackDelayDateMillis': instance.feedbackDelayDateMillis,
};
