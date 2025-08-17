// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedbackConfig {

@JsonKey(name: 'events') Map<String, int>? get events;@JsonKey(name: 'expiration_delay_days') int? get expirationDelayDays;@JsonKey(name: 'do_not_disturb_on_new_version') bool? get doNotDisturbOnNewVersion;
/// Create a copy of FeedbackConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackConfigCopyWith<FeedbackConfig> get copyWith => _$FeedbackConfigCopyWithImpl<FeedbackConfig>(this as FeedbackConfig, _$identity);

  /// Serializes this FeedbackConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackConfig&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.expirationDelayDays, expirationDelayDays) || other.expirationDelayDays == expirationDelayDays)&&(identical(other.doNotDisturbOnNewVersion, doNotDisturbOnNewVersion) || other.doNotDisturbOnNewVersion == doNotDisturbOnNewVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(events),expirationDelayDays,doNotDisturbOnNewVersion);

@override
String toString() {
  return 'FeedbackConfig(events: $events, expirationDelayDays: $expirationDelayDays, doNotDisturbOnNewVersion: $doNotDisturbOnNewVersion)';
}


}

/// @nodoc
abstract mixin class $FeedbackConfigCopyWith<$Res>  {
  factory $FeedbackConfigCopyWith(FeedbackConfig value, $Res Function(FeedbackConfig) _then) = _$FeedbackConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'events') Map<String, int>? events,@JsonKey(name: 'expiration_delay_days') int? expirationDelayDays,@JsonKey(name: 'do_not_disturb_on_new_version') bool? doNotDisturbOnNewVersion
});




}
/// @nodoc
class _$FeedbackConfigCopyWithImpl<$Res>
    implements $FeedbackConfigCopyWith<$Res> {
  _$FeedbackConfigCopyWithImpl(this._self, this._then);

  final FeedbackConfig _self;
  final $Res Function(FeedbackConfig) _then;

/// Create a copy of FeedbackConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = freezed,Object? expirationDelayDays = freezed,Object? doNotDisturbOnNewVersion = freezed,}) {
  return _then(_self.copyWith(
events: freezed == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,expirationDelayDays: freezed == expirationDelayDays ? _self.expirationDelayDays : expirationDelayDays // ignore: cast_nullable_to_non_nullable
as int?,doNotDisturbOnNewVersion: freezed == doNotDisturbOnNewVersion ? _self.doNotDisturbOnNewVersion : doNotDisturbOnNewVersion // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackConfig].
extension FeedbackConfigPatterns on FeedbackConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackConfig value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackConfig value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'events')  Map<String, int>? events, @JsonKey(name: 'expiration_delay_days')  int? expirationDelayDays, @JsonKey(name: 'do_not_disturb_on_new_version')  bool? doNotDisturbOnNewVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackConfig() when $default != null:
return $default(_that.events,_that.expirationDelayDays,_that.doNotDisturbOnNewVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'events')  Map<String, int>? events, @JsonKey(name: 'expiration_delay_days')  int? expirationDelayDays, @JsonKey(name: 'do_not_disturb_on_new_version')  bool? doNotDisturbOnNewVersion)  $default,) {final _that = this;
switch (_that) {
case _FeedbackConfig():
return $default(_that.events,_that.expirationDelayDays,_that.doNotDisturbOnNewVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'events')  Map<String, int>? events, @JsonKey(name: 'expiration_delay_days')  int? expirationDelayDays, @JsonKey(name: 'do_not_disturb_on_new_version')  bool? doNotDisturbOnNewVersion)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackConfig() when $default != null:
return $default(_that.events,_that.expirationDelayDays,_that.doNotDisturbOnNewVersion);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _FeedbackConfig implements FeedbackConfig {
   _FeedbackConfig({@JsonKey(name: 'events') final  Map<String, int>? events, @JsonKey(name: 'expiration_delay_days') this.expirationDelayDays, @JsonKey(name: 'do_not_disturb_on_new_version') this.doNotDisturbOnNewVersion}): _events = events;
  factory _FeedbackConfig.fromJson(Map<String, dynamic> json) => _$FeedbackConfigFromJson(json);

 final  Map<String, int>? _events;
@override@JsonKey(name: 'events') Map<String, int>? get events {
  final value = _events;
  if (value == null) return null;
  if (_events is EqualUnmodifiableMapView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'expiration_delay_days') final  int? expirationDelayDays;
@override@JsonKey(name: 'do_not_disturb_on_new_version') final  bool? doNotDisturbOnNewVersion;

/// Create a copy of FeedbackConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackConfigCopyWith<_FeedbackConfig> get copyWith => __$FeedbackConfigCopyWithImpl<_FeedbackConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedbackConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackConfig&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.expirationDelayDays, expirationDelayDays) || other.expirationDelayDays == expirationDelayDays)&&(identical(other.doNotDisturbOnNewVersion, doNotDisturbOnNewVersion) || other.doNotDisturbOnNewVersion == doNotDisturbOnNewVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events),expirationDelayDays,doNotDisturbOnNewVersion);

@override
String toString() {
  return 'FeedbackConfig(events: $events, expirationDelayDays: $expirationDelayDays, doNotDisturbOnNewVersion: $doNotDisturbOnNewVersion)';
}


}

/// @nodoc
abstract mixin class _$FeedbackConfigCopyWith<$Res> implements $FeedbackConfigCopyWith<$Res> {
  factory _$FeedbackConfigCopyWith(_FeedbackConfig value, $Res Function(_FeedbackConfig) _then) = __$FeedbackConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'events') Map<String, int>? events,@JsonKey(name: 'expiration_delay_days') int? expirationDelayDays,@JsonKey(name: 'do_not_disturb_on_new_version') bool? doNotDisturbOnNewVersion
});




}
/// @nodoc
class __$FeedbackConfigCopyWithImpl<$Res>
    implements _$FeedbackConfigCopyWith<$Res> {
  __$FeedbackConfigCopyWithImpl(this._self, this._then);

  final _FeedbackConfig _self;
  final $Res Function(_FeedbackConfig) _then;

/// Create a copy of FeedbackConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = freezed,Object? expirationDelayDays = freezed,Object? doNotDisturbOnNewVersion = freezed,}) {
  return _then(_FeedbackConfig(
events: freezed == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,expirationDelayDays: freezed == expirationDelayDays ? _self.expirationDelayDays : expirationDelayDays // ignore: cast_nullable_to_non_nullable
as int?,doNotDisturbOnNewVersion: freezed == doNotDisturbOnNewVersion ? _self.doNotDisturbOnNewVersion : doNotDisturbOnNewVersion // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
