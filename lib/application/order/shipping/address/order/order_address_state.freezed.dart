// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_address_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderAddressState {

 TextEditingController? get textController; LocationData? get location; String get entrance; String get floor; String get house;
/// Create a copy of OrderAddressState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderAddressStateCopyWith<OrderAddressState> get copyWith => _$OrderAddressStateCopyWithImpl<OrderAddressState>(this as OrderAddressState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderAddressState&&(identical(other.textController, textController) || other.textController == textController)&&(identical(other.location, location) || other.location == location)&&(identical(other.entrance, entrance) || other.entrance == entrance)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.house, house) || other.house == house));
}


@override
int get hashCode => Object.hash(runtimeType,textController,location,entrance,floor,house);

@override
String toString() {
  return 'OrderAddressState(textController: $textController, location: $location, entrance: $entrance, floor: $floor, house: $house)';
}


}

/// @nodoc
abstract mixin class $OrderAddressStateCopyWith<$Res>  {
  factory $OrderAddressStateCopyWith(OrderAddressState value, $Res Function(OrderAddressState) _then) = _$OrderAddressStateCopyWithImpl;
@useResult
$Res call({
 TextEditingController? textController, LocationData? location, String entrance, String floor, String house
});




}
/// @nodoc
class _$OrderAddressStateCopyWithImpl<$Res>
    implements $OrderAddressStateCopyWith<$Res> {
  _$OrderAddressStateCopyWithImpl(this._self, this._then);

  final OrderAddressState _self;
  final $Res Function(OrderAddressState) _then;

/// Create a copy of OrderAddressState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textController = freezed,Object? location = freezed,Object? entrance = null,Object? floor = null,Object? house = null,}) {
  return _then(_self.copyWith(
textController: freezed == textController ? _self.textController : textController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData?,entrance: null == entrance ? _self.entrance : entrance // ignore: cast_nullable_to_non_nullable
as String,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String,house: null == house ? _self.house : house // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderAddressState].
extension OrderAddressStatePatterns on OrderAddressState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderAddressState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderAddressState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderAddressState value)  $default,){
final _that = this;
switch (_that) {
case _OrderAddressState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderAddressState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderAddressState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextEditingController? textController,  LocationData? location,  String entrance,  String floor,  String house)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderAddressState() when $default != null:
return $default(_that.textController,_that.location,_that.entrance,_that.floor,_that.house);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextEditingController? textController,  LocationData? location,  String entrance,  String floor,  String house)  $default,) {final _that = this;
switch (_that) {
case _OrderAddressState():
return $default(_that.textController,_that.location,_that.entrance,_that.floor,_that.house);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextEditingController? textController,  LocationData? location,  String entrance,  String floor,  String house)?  $default,) {final _that = this;
switch (_that) {
case _OrderAddressState() when $default != null:
return $default(_that.textController,_that.location,_that.entrance,_that.floor,_that.house);case _:
  return null;

}
}

}

/// @nodoc


class _OrderAddressState extends OrderAddressState {
  const _OrderAddressState({this.textController, this.location, this.entrance = '', this.floor = '', this.house = ''}): super._();
  

@override final  TextEditingController? textController;
@override final  LocationData? location;
@override@JsonKey() final  String entrance;
@override@JsonKey() final  String floor;
@override@JsonKey() final  String house;

/// Create a copy of OrderAddressState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderAddressStateCopyWith<_OrderAddressState> get copyWith => __$OrderAddressStateCopyWithImpl<_OrderAddressState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderAddressState&&(identical(other.textController, textController) || other.textController == textController)&&(identical(other.location, location) || other.location == location)&&(identical(other.entrance, entrance) || other.entrance == entrance)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.house, house) || other.house == house));
}


@override
int get hashCode => Object.hash(runtimeType,textController,location,entrance,floor,house);

@override
String toString() {
  return 'OrderAddressState(textController: $textController, location: $location, entrance: $entrance, floor: $floor, house: $house)';
}


}

/// @nodoc
abstract mixin class _$OrderAddressStateCopyWith<$Res> implements $OrderAddressStateCopyWith<$Res> {
  factory _$OrderAddressStateCopyWith(_OrderAddressState value, $Res Function(_OrderAddressState) _then) = __$OrderAddressStateCopyWithImpl;
@override @useResult
$Res call({
 TextEditingController? textController, LocationData? location, String entrance, String floor, String house
});




}
/// @nodoc
class __$OrderAddressStateCopyWithImpl<$Res>
    implements _$OrderAddressStateCopyWith<$Res> {
  __$OrderAddressStateCopyWithImpl(this._self, this._then);

  final _OrderAddressState _self;
  final $Res Function(_OrderAddressState) _then;

/// Create a copy of OrderAddressState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textController = freezed,Object? location = freezed,Object? entrance = null,Object? floor = null,Object? house = null,}) {
  return _then(_OrderAddressState(
textController: freezed == textController ? _self.textController : textController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData?,entrance: null == entrance ? _self.entrance : entrance // ignore: cast_nullable_to_non_nullable
as String,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String,house: null == house ? _self.house : house // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
