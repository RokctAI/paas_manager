// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_type_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryTypeState {

 String get type;
/// Create a copy of DeliveryTypeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryTypeStateCopyWith<DeliveryTypeState> get copyWith => _$DeliveryTypeStateCopyWithImpl<DeliveryTypeState>(this as DeliveryTypeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryTypeState&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'DeliveryTypeState(type: $type)';
}


}

/// @nodoc
abstract mixin class $DeliveryTypeStateCopyWith<$Res>  {
  factory $DeliveryTypeStateCopyWith(DeliveryTypeState value, $Res Function(DeliveryTypeState) _then) = _$DeliveryTypeStateCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$DeliveryTypeStateCopyWithImpl<$Res>
    implements $DeliveryTypeStateCopyWith<$Res> {
  _$DeliveryTypeStateCopyWithImpl(this._self, this._then);

  final DeliveryTypeState _self;
  final $Res Function(DeliveryTypeState) _then;

/// Create a copy of DeliveryTypeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryTypeState].
extension DeliveryTypeStatePatterns on DeliveryTypeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryTypeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryTypeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryTypeState value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryTypeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryTypeState value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryTypeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryTypeState() when $default != null:
return $default(_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type)  $default,) {final _that = this;
switch (_that) {
case _DeliveryTypeState():
return $default(_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryTypeState() when $default != null:
return $default(_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryTypeState extends DeliveryTypeState {
  const _DeliveryTypeState({this.type = TrKeys.delivery}): super._();
  

@override@JsonKey() final  String type;

/// Create a copy of DeliveryTypeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryTypeStateCopyWith<_DeliveryTypeState> get copyWith => __$DeliveryTypeStateCopyWithImpl<_DeliveryTypeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryTypeState&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'DeliveryTypeState(type: $type)';
}


}

/// @nodoc
abstract mixin class _$DeliveryTypeStateCopyWith<$Res> implements $DeliveryTypeStateCopyWith<$Res> {
  factory _$DeliveryTypeStateCopyWith(_DeliveryTypeState value, $Res Function(_DeliveryTypeState) _then) = __$DeliveryTypeStateCopyWithImpl;
@override @useResult
$Res call({
 String type
});




}
/// @nodoc
class __$DeliveryTypeStateCopyWithImpl<$Res>
    implements _$DeliveryTypeStateCopyWith<$Res> {
  __$DeliveryTypeStateCopyWithImpl(this._self, this._then);

  final _DeliveryTypeState _self;
  final $Res Function(_DeliveryTypeState) _then;

/// Create a copy of DeliveryTypeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(_DeliveryTypeState(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
