import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_config.freezed.dart';
part 'feedback_config.g.dart';

@freezed
abstract class FeedbackConfig with _$FeedbackConfig {
  @JsonSerializable(explicitToJson: true)
  factory FeedbackConfig({
    @JsonKey(name: 'events') Map<String, int>? events,
    @JsonKey(name: 'expiration_delay_days') int? expirationDelayDays,
    @JsonKey(name: 'do_not_disturb_on_new_version')
    bool? doNotDisturbOnNewVersion,
  }) = _FeedbackConfig;

  factory FeedbackConfig.fromJson(Map<String, dynamic> json) =>
      _$FeedbackConfigFromJson(json);
}
