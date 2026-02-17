// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderCartState {

 List<Stock> get stocks; num get totalPrice;
/// Create a copy of OrderCartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCartStateCopyWith<OrderCartState> get copyWith => _$OrderCartStateCopyWithImpl<OrderCartState>(this as OrderCartState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderCartState&&const DeepCollectionEquality().equals(other.stocks, stocks)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stocks),totalPrice);

@override
String toString() {
  return 'OrderCartState(stocks: $stocks, totalPrice: $totalPrice)';
}


}

/// @nodoc
abstract mixin class $OrderCartStateCopyWith<$Res>  {
  factory $OrderCartStateCopyWith(OrderCartState value, $Res Function(OrderCartState) _then) = _$OrderCartStateCopyWithImpl;
@useResult
$Res call({
 List<Stock> stocks, num totalPrice
});




}
/// @nodoc
class _$OrderCartStateCopyWithImpl<$Res>
    implements $OrderCartStateCopyWith<$Res> {
  _$OrderCartStateCopyWithImpl(this._self, this._then);

  final OrderCartState _self;
  final $Res Function(OrderCartState) _then;

/// Create a copy of OrderCartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stocks = null,Object? totalPrice = null,}) {
  return _then(_self.copyWith(
stocks: null == stocks ? _self.stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderCartState].
extension OrderCartStatePatterns on OrderCartState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderCartState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderCartState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderCartState value)  $default,){
final _that = this;
switch (_that) {
case _OrderCartState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderCartState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderCartState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Stock> stocks,  num totalPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderCartState() when $default != null:
return $default(_that.stocks,_that.totalPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Stock> stocks,  num totalPrice)  $default,) {final _that = this;
switch (_that) {
case _OrderCartState():
return $default(_that.stocks,_that.totalPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Stock> stocks,  num totalPrice)?  $default,) {final _that = this;
switch (_that) {
case _OrderCartState() when $default != null:
return $default(_that.stocks,_that.totalPrice);case _:
  return null;

}
}

}

/// @nodoc


class _OrderCartState extends OrderCartState {
  const _OrderCartState({final  List<Stock> stocks = const [], this.totalPrice = 0}): _stocks = stocks,super._();
  

 final  List<Stock> _stocks;
@override@JsonKey() List<Stock> get stocks {
  if (_stocks is EqualUnmodifiableListView) return _stocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stocks);
}

@override@JsonKey() final  num totalPrice;

/// Create a copy of OrderCartState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCartStateCopyWith<_OrderCartState> get copyWith => __$OrderCartStateCopyWithImpl<_OrderCartState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderCartState&&const DeepCollectionEquality().equals(other._stocks, _stocks)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stocks),totalPrice);

@override
String toString() {
  return 'OrderCartState(stocks: $stocks, totalPrice: $totalPrice)';
}


}

/// @nodoc
abstract mixin class _$OrderCartStateCopyWith<$Res> implements $OrderCartStateCopyWith<$Res> {
  factory _$OrderCartStateCopyWith(_OrderCartState value, $Res Function(_OrderCartState) _then) = __$OrderCartStateCopyWithImpl;
@override @useResult
$Res call({
 List<Stock> stocks, num totalPrice
});




}
/// @nodoc
class __$OrderCartStateCopyWithImpl<$Res>
    implements _$OrderCartStateCopyWith<$Res> {
  __$OrderCartStateCopyWithImpl(this._self, this._then);

  final _OrderCartState _self;
  final $Res Function(_OrderCartState) _then;

/// Create a copy of OrderCartState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stocks = null,Object? totalPrice = null,}) {
  return _then(_OrderCartState(
stocks: null == stocks ? _self._stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
