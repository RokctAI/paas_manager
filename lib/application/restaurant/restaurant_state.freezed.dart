// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestaurantState {

 bool get isLoading; String? get backgroundImageFile; String? get logoImageFile; String? get orderPayment; ShopData? get shop;
/// Create a copy of RestaurantState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantStateCopyWith<RestaurantState> get copyWith => _$RestaurantStateCopyWithImpl<RestaurantState>(this as RestaurantState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.backgroundImageFile, backgroundImageFile) || other.backgroundImageFile == backgroundImageFile)&&(identical(other.logoImageFile, logoImageFile) || other.logoImageFile == logoImageFile)&&(identical(other.orderPayment, orderPayment) || other.orderPayment == orderPayment)&&(identical(other.shop, shop) || other.shop == shop));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,backgroundImageFile,logoImageFile,orderPayment,shop);

@override
String toString() {
  return 'RestaurantState(isLoading: $isLoading, backgroundImageFile: $backgroundImageFile, logoImageFile: $logoImageFile, orderPayment: $orderPayment, shop: $shop)';
}


}

/// @nodoc
abstract mixin class $RestaurantStateCopyWith<$Res>  {
  factory $RestaurantStateCopyWith(RestaurantState value, $Res Function(RestaurantState) _then) = _$RestaurantStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? backgroundImageFile, String? logoImageFile, String? orderPayment, ShopData? shop
});




}
/// @nodoc
class _$RestaurantStateCopyWithImpl<$Res>
    implements $RestaurantStateCopyWith<$Res> {
  _$RestaurantStateCopyWithImpl(this._self, this._then);

  final RestaurantState _self;
  final $Res Function(RestaurantState) _then;

/// Create a copy of RestaurantState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? backgroundImageFile = freezed,Object? logoImageFile = freezed,Object? orderPayment = freezed,Object? shop = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,backgroundImageFile: freezed == backgroundImageFile ? _self.backgroundImageFile : backgroundImageFile // ignore: cast_nullable_to_non_nullable
as String?,logoImageFile: freezed == logoImageFile ? _self.logoImageFile : logoImageFile // ignore: cast_nullable_to_non_nullable
as String?,orderPayment: freezed == orderPayment ? _self.orderPayment : orderPayment // ignore: cast_nullable_to_non_nullable
as String?,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as ShopData?,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantState].
extension RestaurantStatePatterns on RestaurantState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantState value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantState value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String? backgroundImageFile,  String? logoImageFile,  String? orderPayment,  ShopData? shop)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantState() when $default != null:
return $default(_that.isLoading,_that.backgroundImageFile,_that.logoImageFile,_that.orderPayment,_that.shop);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String? backgroundImageFile,  String? logoImageFile,  String? orderPayment,  ShopData? shop)  $default,) {final _that = this;
switch (_that) {
case _RestaurantState():
return $default(_that.isLoading,_that.backgroundImageFile,_that.logoImageFile,_that.orderPayment,_that.shop);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String? backgroundImageFile,  String? logoImageFile,  String? orderPayment,  ShopData? shop)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantState() when $default != null:
return $default(_that.isLoading,_that.backgroundImageFile,_that.logoImageFile,_that.orderPayment,_that.shop);case _:
  return null;

}
}

}

/// @nodoc


class _RestaurantState extends RestaurantState {
  const _RestaurantState({this.isLoading = false, this.backgroundImageFile, this.logoImageFile, this.orderPayment, this.shop}): super._();
  

@override@JsonKey() final  bool isLoading;
@override final  String? backgroundImageFile;
@override final  String? logoImageFile;
@override final  String? orderPayment;
@override final  ShopData? shop;

/// Create a copy of RestaurantState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantStateCopyWith<_RestaurantState> get copyWith => __$RestaurantStateCopyWithImpl<_RestaurantState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.backgroundImageFile, backgroundImageFile) || other.backgroundImageFile == backgroundImageFile)&&(identical(other.logoImageFile, logoImageFile) || other.logoImageFile == logoImageFile)&&(identical(other.orderPayment, orderPayment) || other.orderPayment == orderPayment)&&(identical(other.shop, shop) || other.shop == shop));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,backgroundImageFile,logoImageFile,orderPayment,shop);

@override
String toString() {
  return 'RestaurantState(isLoading: $isLoading, backgroundImageFile: $backgroundImageFile, logoImageFile: $logoImageFile, orderPayment: $orderPayment, shop: $shop)';
}


}

/// @nodoc
abstract mixin class _$RestaurantStateCopyWith<$Res> implements $RestaurantStateCopyWith<$Res> {
  factory _$RestaurantStateCopyWith(_RestaurantState value, $Res Function(_RestaurantState) _then) = __$RestaurantStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? backgroundImageFile, String? logoImageFile, String? orderPayment, ShopData? shop
});




}
/// @nodoc
class __$RestaurantStateCopyWithImpl<$Res>
    implements _$RestaurantStateCopyWith<$Res> {
  __$RestaurantStateCopyWithImpl(this._self, this._then);

  final _RestaurantState _self;
  final $Res Function(_RestaurantState) _then;

/// Create a copy of RestaurantState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? backgroundImageFile = freezed,Object? logoImageFile = freezed,Object? orderPayment = freezed,Object? shop = freezed,}) {
  return _then(_RestaurantState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,backgroundImageFile: freezed == backgroundImageFile ? _self.backgroundImageFile : backgroundImageFile // ignore: cast_nullable_to_non_nullable
as String?,logoImageFile: freezed == logoImageFile ? _self.logoImageFile : logoImageFile // ignore: cast_nullable_to_non_nullable
as String?,orderPayment: freezed == orderPayment ? _self.orderPayment : orderPayment // ignore: cast_nullable_to_non_nullable
as String?,shop: freezed == shop ? _self.shop : shop // ignore: cast_nullable_to_non_nullable
as ShopData?,
  ));
}


}

// dart format on
