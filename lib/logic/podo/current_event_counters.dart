// https://github.com/rrousselGit/freezed/issues/488
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_event_counters.freezed.dart';
part 'current_event_counters.g.dart';

@freezed
abstract class CurrentFeedbackCounters with _$CurrentFeedbackCounters {
  @JsonSerializable(explicitToJson: true)
  factory CurrentFeedbackCounters({
    final Map<String, int>? events,
    final String? savedAppVersion,
    @Default(false) bool? feedbackDialogShown,
    int? feedbackDelayDateMillis,
  }) = _CurrentFeedbackCounterss;

  factory CurrentFeedbackCounters.fromJson(Map<String, dynamic> json) =>
      _$CurrentFeedbackCountersFromJson(json);
}
