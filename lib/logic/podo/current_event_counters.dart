// https://github.com/rrousselGit/freezed/issues/488
// ignore_for_file: invalid_annotation_target

// Note: Didn't use freezed to avoid dependencies issues in future

import 'package:smart_rate_us/utils/map_utils.dart';

class CurrentFeedbackCounters {
  final Map<String, int>? events;
  final String? savedAppVersion;
  final bool? feedbackDialogShown;
  final int? feedbackDelayDateMillis;

  const CurrentFeedbackCounters({
    this.events,
    this.savedAppVersion,
    this.feedbackDialogShown = false,
    this.feedbackDelayDateMillis,
  });

  CurrentFeedbackCounters copyWith({
    Map<String, int>? events,
    String? savedAppVersion,
    bool? feedbackDialogShown,
    int? feedbackDelayDateMillis,
  }) {
    return CurrentFeedbackCounters(
      events: events ?? this.events,
      savedAppVersion: savedAppVersion ?? this.savedAppVersion,
      feedbackDialogShown: feedbackDialogShown ?? this.feedbackDialogShown,
      feedbackDelayDateMillis: feedbackDelayDateMillis ?? this.feedbackDelayDateMillis,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'events': events,
      'savedAppVersion': savedAppVersion,
      'feedbackDialogShown': feedbackDialogShown,
      'feedbackDelayDateMillis': feedbackDelayDateMillis,
    };
  }

  factory CurrentFeedbackCounters.fromJson(Map<String, dynamic> json) {
    return CurrentFeedbackCounters(
      events: json['events'] != null ? Map<String, int>.from(json['events'] as Map) : null,
      savedAppVersion: json['savedAppVersion'] as String?,
      feedbackDialogShown: json['feedbackDialogShown'] as bool? ?? false,
      feedbackDelayDateMillis: json['feedbackDelayDateMillis'] as int?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CurrentFeedbackCounters &&
        mapEquals(other.events, events) &&
        other.savedAppVersion == savedAppVersion &&
        other.feedbackDialogShown == feedbackDialogShown &&
        other.feedbackDelayDateMillis == feedbackDelayDateMillis;
  }

  @override
  int get hashCode {
    return events.hashCode ^
        savedAppVersion.hashCode ^
        feedbackDialogShown.hashCode ^
        feedbackDelayDateMillis.hashCode;
  }

  @override
  String toString() {
    return 'CurrentFeedbackCounters(events: $events, savedAppVersion: $savedAppVersion, feedbackDialogShown: $feedbackDialogShown, feedbackDelayDateMillis: $feedbackDelayDateMillis)';
  }
}
