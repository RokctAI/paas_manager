// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_time_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryTimeState {

 String get deliveryDate;
/// Create a copy of DeliveryTimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryTimeStateCopyWith<DeliveryTimeState> get copyWith => _$DeliveryTimeStateCopyWithImpl<DeliveryTimeState>(this as DeliveryTimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryTimeState&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate));
}


@override
int get hashCode => Object.hash(runtimeType,deliveryDate);

@override
String toString() {
  return 'DeliveryTimeState(deliveryDate: $deliveryDate)';
}


}

/// @nodoc
abstract mixin class $DeliveryTimeStateCopyWith<$Res>  {
  factory $DeliveryTimeStateCopyWith(DeliveryTimeState value, $Res Function(DeliveryTimeState) _then) = _$DeliveryTimeStateCopyWithImpl;
@useResult
$Res call({
 String deliveryDate
});




}
/// @nodoc
class _$DeliveryTimeStateCopyWithImpl<$Res>
    implements $DeliveryTimeStateCopyWith<$Res> {
  _$DeliveryTimeStateCopyWithImpl(this._self, this._then);

  final DeliveryTimeState _self;
  final $Res Function(DeliveryTimeState) _then;

/// Create a copy of DeliveryTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deliveryDate = null,}) {
  return _then(_self.copyWith(
deliveryDate: null == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryTimeState].
extension DeliveryTimeStatePatterns on DeliveryTimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryTimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryTimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryTimeState value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryTimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryTimeState value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryTimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deliveryDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryTimeState() when $default != null:
return $default(_that.deliveryDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deliveryDate)  $default,) {final _that = this;
switch (_that) {
case _DeliveryTimeState():
return $default(_that.deliveryDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deliveryDate)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryTimeState() when $default != null:
return $default(_that.deliveryDate);case _:
  return null;

}
}

}

/// @nodoc


class _DeliveryTimeState extends DeliveryTimeState {
  const _DeliveryTimeState({this.deliveryDate = ''}): super._();
  

@override@JsonKey() final  String deliveryDate;

/// Create a copy of DeliveryTimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryTimeStateCopyWith<_DeliveryTimeState> get copyWith => __$DeliveryTimeStateCopyWithImpl<_DeliveryTimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryTimeState&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate));
}


@override
int get hashCode => Object.hash(runtimeType,deliveryDate);

@override
String toString() {
  return 'DeliveryTimeState(deliveryDate: $deliveryDate)';
}


}

/// @nodoc
abstract mixin class _$DeliveryTimeStateCopyWith<$Res> implements $DeliveryTimeStateCopyWith<$Res> {
  factory _$DeliveryTimeStateCopyWith(_DeliveryTimeState value, $Res Function(_DeliveryTimeState) _then) = __$DeliveryTimeStateCopyWithImpl;
@override @useResult
$Res call({
 String deliveryDate
});




}
/// @nodoc
class __$DeliveryTimeStateCopyWithImpl<$Res>
    implements _$DeliveryTimeStateCopyWith<$Res> {
  __$DeliveryTimeStateCopyWithImpl(this._self, this._then);

  final _DeliveryTimeState _self;
  final $Res Function(_DeliveryTimeState) _then;

/// Create a copy of DeliveryTimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deliveryDate = null,}) {
  return _then(_DeliveryTimeState(
deliveryDate: null == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
