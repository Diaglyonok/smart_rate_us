// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_event_counters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
CurrentFeedbackCounters _$CurrentFeedbackCountersFromJson(
  Map<String, dynamic> json
) {
    return _CurrentFeedbackCounterss.fromJson(
      json
    );
}

/// @nodoc
mixin _$CurrentFeedbackCounters {

 Map<String, int>? get events; String? get savedAppVersion; bool? get feedbackDialogShown; int? get feedbackDelayDateMillis;
/// Create a copy of CurrentFeedbackCounters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentFeedbackCountersCopyWith<CurrentFeedbackCounters> get copyWith => _$CurrentFeedbackCountersCopyWithImpl<CurrentFeedbackCounters>(this as CurrentFeedbackCounters, _$identity);

  /// Serializes this CurrentFeedbackCounters to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentFeedbackCounters&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.savedAppVersion, savedAppVersion) || other.savedAppVersion == savedAppVersion)&&(identical(other.feedbackDialogShown, feedbackDialogShown) || other.feedbackDialogShown == feedbackDialogShown)&&(identical(other.feedbackDelayDateMillis, feedbackDelayDateMillis) || other.feedbackDelayDateMillis == feedbackDelayDateMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(events),savedAppVersion,feedbackDialogShown,feedbackDelayDateMillis);

@override
String toString() {
  return 'CurrentFeedbackCounters(events: $events, savedAppVersion: $savedAppVersion, feedbackDialogShown: $feedbackDialogShown, feedbackDelayDateMillis: $feedbackDelayDateMillis)';
}


}

/// @nodoc
abstract mixin class $CurrentFeedbackCountersCopyWith<$Res>  {
  factory $CurrentFeedbackCountersCopyWith(CurrentFeedbackCounters value, $Res Function(CurrentFeedbackCounters) _then) = _$CurrentFeedbackCountersCopyWithImpl;
@useResult
$Res call({
 Map<String, int>? events, String? savedAppVersion, bool? feedbackDialogShown, int? feedbackDelayDateMillis
});




}
/// @nodoc
class _$CurrentFeedbackCountersCopyWithImpl<$Res>
    implements $CurrentFeedbackCountersCopyWith<$Res> {
  _$CurrentFeedbackCountersCopyWithImpl(this._self, this._then);

  final CurrentFeedbackCounters _self;
  final $Res Function(CurrentFeedbackCounters) _then;

/// Create a copy of CurrentFeedbackCounters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = freezed,Object? savedAppVersion = freezed,Object? feedbackDialogShown = freezed,Object? feedbackDelayDateMillis = freezed,}) {
  return _then(_self.copyWith(
events: freezed == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,savedAppVersion: freezed == savedAppVersion ? _self.savedAppVersion : savedAppVersion // ignore: cast_nullable_to_non_nullable
as String?,feedbackDialogShown: freezed == feedbackDialogShown ? _self.feedbackDialogShown : feedbackDialogShown // ignore: cast_nullable_to_non_nullable
as bool?,feedbackDelayDateMillis: freezed == feedbackDelayDateMillis ? _self.feedbackDelayDateMillis : feedbackDelayDateMillis // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentFeedbackCounters].
extension CurrentFeedbackCountersPatterns on CurrentFeedbackCounters {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentFeedbackCounterss value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentFeedbackCounterss() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentFeedbackCounterss value)  $default,){
final _that = this;
switch (_that) {
case _CurrentFeedbackCounterss():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentFeedbackCounterss value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentFeedbackCounterss() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, int>? events,  String? savedAppVersion,  bool? feedbackDialogShown,  int? feedbackDelayDateMillis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentFeedbackCounterss() when $default != null:
return $default(_that.events,_that.savedAppVersion,_that.feedbackDialogShown,_that.feedbackDelayDateMillis);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, int>? events,  String? savedAppVersion,  bool? feedbackDialogShown,  int? feedbackDelayDateMillis)  $default,) {final _that = this;
switch (_that) {
case _CurrentFeedbackCounterss():
return $default(_that.events,_that.savedAppVersion,_that.feedbackDialogShown,_that.feedbackDelayDateMillis);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, int>? events,  String? savedAppVersion,  bool? feedbackDialogShown,  int? feedbackDelayDateMillis)?  $default,) {final _that = this;
switch (_that) {
case _CurrentFeedbackCounterss() when $default != null:
return $default(_that.events,_that.savedAppVersion,_that.feedbackDialogShown,_that.feedbackDelayDateMillis);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _CurrentFeedbackCounterss implements CurrentFeedbackCounters {
   _CurrentFeedbackCounterss({final  Map<String, int>? events, this.savedAppVersion, this.feedbackDialogShown = false, this.feedbackDelayDateMillis}): _events = events;
  factory _CurrentFeedbackCounterss.fromJson(Map<String, dynamic> json) => _$CurrentFeedbackCounterssFromJson(json);

 final  Map<String, int>? _events;
@override Map<String, int>? get events {
  final value = _events;
  if (value == null) return null;
  if (_events is EqualUnmodifiableMapView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? savedAppVersion;
@override@JsonKey() final  bool? feedbackDialogShown;
@override final  int? feedbackDelayDateMillis;

/// Create a copy of CurrentFeedbackCounters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentFeedbackCounterssCopyWith<_CurrentFeedbackCounterss> get copyWith => __$CurrentFeedbackCounterssCopyWithImpl<_CurrentFeedbackCounterss>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentFeedbackCounterssToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentFeedbackCounterss&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.savedAppVersion, savedAppVersion) || other.savedAppVersion == savedAppVersion)&&(identical(other.feedbackDialogShown, feedbackDialogShown) || other.feedbackDialogShown == feedbackDialogShown)&&(identical(other.feedbackDelayDateMillis, feedbackDelayDateMillis) || other.feedbackDelayDateMillis == feedbackDelayDateMillis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events),savedAppVersion,feedbackDialogShown,feedbackDelayDateMillis);

@override
String toString() {
  return 'CurrentFeedbackCounters(events: $events, savedAppVersion: $savedAppVersion, feedbackDialogShown: $feedbackDialogShown, feedbackDelayDateMillis: $feedbackDelayDateMillis)';
}


}

/// @nodoc
abstract mixin class _$CurrentFeedbackCounterssCopyWith<$Res> implements $CurrentFeedbackCountersCopyWith<$Res> {
  factory _$CurrentFeedbackCounterssCopyWith(_CurrentFeedbackCounterss value, $Res Function(_CurrentFeedbackCounterss) _then) = __$CurrentFeedbackCounterssCopyWithImpl;
@override @useResult
$Res call({
 Map<String, int>? events, String? savedAppVersion, bool? feedbackDialogShown, int? feedbackDelayDateMillis
});




}
/// @nodoc
class __$CurrentFeedbackCounterssCopyWithImpl<$Res>
    implements _$CurrentFeedbackCounterssCopyWith<$Res> {
  __$CurrentFeedbackCounterssCopyWithImpl(this._self, this._then);

  final _CurrentFeedbackCounterss _self;
  final $Res Function(_CurrentFeedbackCounterss) _then;

/// Create a copy of CurrentFeedbackCounters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = freezed,Object? savedAppVersion = freezed,Object? feedbackDialogShown = freezed,Object? feedbackDelayDateMillis = freezed,}) {
  return _then(_CurrentFeedbackCounterss(
events: freezed == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,savedAppVersion: freezed == savedAppVersion ? _self.savedAppVersion : savedAppVersion // ignore: cast_nullable_to_non_nullable
as String?,feedbackDialogShown: freezed == feedbackDialogShown ? _self.feedbackDialogShown : feedbackDialogShown // ignore: cast_nullable_to_non_nullable
as bool?,feedbackDelayDateMillis: freezed == feedbackDelayDateMillis ? _self.feedbackDelayDateMillis : feedbackDelayDateMillis // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
