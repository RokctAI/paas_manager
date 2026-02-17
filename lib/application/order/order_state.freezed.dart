// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderState {

 bool get paymentType; bool get isLoading; List<OrderData> get orders; int get totalCount; int get deliveryTime; int get deliveryType; List<OrderData> get deliveredOrders; List<OrderData> get canceledOrders; int get totalDeliveredOrderCount; int get totalCanceledOrderCount;
/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStateCopyWith<OrderState> get copyWith => _$OrderStateCopyWithImpl<OrderState>(this as OrderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderState&&(identical(other.paymentType, paymentType) || other.paymentType == paymentType)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.orders, orders)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.deliveryType, deliveryType) || other.deliveryType == deliveryType)&&const DeepCollectionEquality().equals(other.deliveredOrders, deliveredOrders)&&const DeepCollectionEquality().equals(other.canceledOrders, canceledOrders)&&(identical(other.totalDeliveredOrderCount, totalDeliveredOrderCount) || other.totalDeliveredOrderCount == totalDeliveredOrderCount)&&(identical(other.totalCanceledOrderCount, totalCanceledOrderCount) || other.totalCanceledOrderCount == totalCanceledOrderCount));
}


@override
int get hashCode => Object.hash(runtimeType,paymentType,isLoading,const DeepCollectionEquality().hash(orders),totalCount,deliveryTime,deliveryType,const DeepCollectionEquality().hash(deliveredOrders),const DeepCollectionEquality().hash(canceledOrders),totalDeliveredOrderCount,totalCanceledOrderCount);

@override
String toString() {
  return 'OrderState(paymentType: $paymentType, isLoading: $isLoading, orders: $orders, totalCount: $totalCount, deliveryTime: $deliveryTime, deliveryType: $deliveryType, deliveredOrders: $deliveredOrders, canceledOrders: $canceledOrders, totalDeliveredOrderCount: $totalDeliveredOrderCount, totalCanceledOrderCount: $totalCanceledOrderCount)';
}


}

/// @nodoc
abstract mixin class $OrderStateCopyWith<$Res>  {
  factory $OrderStateCopyWith(OrderState value, $Res Function(OrderState) _then) = _$OrderStateCopyWithImpl;
@useResult
$Res call({
 bool paymentType, bool isLoading, List<OrderData> orders, int totalCount, int deliveryTime, int deliveryType, List<OrderData> deliveredOrders, List<OrderData> canceledOrders, int totalDeliveredOrderCount, int totalCanceledOrderCount
});




}
/// @nodoc
class _$OrderStateCopyWithImpl<$Res>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._self, this._then);

  final OrderState _self;
  final $Res Function(OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentType = null,Object? isLoading = null,Object? orders = null,Object? totalCount = null,Object? deliveryTime = null,Object? deliveryType = null,Object? deliveredOrders = null,Object? canceledOrders = null,Object? totalDeliveredOrderCount = null,Object? totalCanceledOrderCount = null,}) {
  return _then(_self.copyWith(
paymentType: null == paymentType ? _self.paymentType : paymentType // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as int,deliveryType: null == deliveryType ? _self.deliveryType : deliveryType // ignore: cast_nullable_to_non_nullable
as int,deliveredOrders: null == deliveredOrders ? _self.deliveredOrders : deliveredOrders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,canceledOrders: null == canceledOrders ? _self.canceledOrders : canceledOrders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,totalDeliveredOrderCount: null == totalDeliveredOrderCount ? _self.totalDeliveredOrderCount : totalDeliveredOrderCount // ignore: cast_nullable_to_non_nullable
as int,totalCanceledOrderCount: null == totalCanceledOrderCount ? _self.totalCanceledOrderCount : totalCanceledOrderCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderState].
extension OrderStatePatterns on OrderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrdrState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrdrState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrdrState value)  $default,){
final _that = this;
switch (_that) {
case _OrdrState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrdrState value)?  $default,){
final _that = this;
switch (_that) {
case _OrdrState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool paymentType,  bool isLoading,  List<OrderData> orders,  int totalCount,  int deliveryTime,  int deliveryType,  List<OrderData> deliveredOrders,  List<OrderData> canceledOrders,  int totalDeliveredOrderCount,  int totalCanceledOrderCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrdrState() when $default != null:
return $default(_that.paymentType,_that.isLoading,_that.orders,_that.totalCount,_that.deliveryTime,_that.deliveryType,_that.deliveredOrders,_that.canceledOrders,_that.totalDeliveredOrderCount,_that.totalCanceledOrderCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool paymentType,  bool isLoading,  List<OrderData> orders,  int totalCount,  int deliveryTime,  int deliveryType,  List<OrderData> deliveredOrders,  List<OrderData> canceledOrders,  int totalDeliveredOrderCount,  int totalCanceledOrderCount)  $default,) {final _that = this;
switch (_that) {
case _OrdrState():
return $default(_that.paymentType,_that.isLoading,_that.orders,_that.totalCount,_that.deliveryTime,_that.deliveryType,_that.deliveredOrders,_that.canceledOrders,_that.totalDeliveredOrderCount,_that.totalCanceledOrderCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool paymentType,  bool isLoading,  List<OrderData> orders,  int totalCount,  int deliveryTime,  int deliveryType,  List<OrderData> deliveredOrders,  List<OrderData> canceledOrders,  int totalDeliveredOrderCount,  int totalCanceledOrderCount)?  $default,) {final _that = this;
switch (_that) {
case _OrdrState() when $default != null:
return $default(_that.paymentType,_that.isLoading,_that.orders,_that.totalCount,_that.deliveryTime,_that.deliveryType,_that.deliveredOrders,_that.canceledOrders,_that.totalDeliveredOrderCount,_that.totalCanceledOrderCount);case _:
  return null;

}
}

}

/// @nodoc


class _OrdrState extends OrderState {
  const _OrdrState({this.paymentType = false, this.isLoading = false, final  List<OrderData> orders = const [], this.totalCount = 0, this.deliveryTime = 0, this.deliveryType = 0, final  List<OrderData> deliveredOrders = const [], final  List<OrderData> canceledOrders = const [], this.totalDeliveredOrderCount = 0, this.totalCanceledOrderCount = 0}): _orders = orders,_deliveredOrders = deliveredOrders,_canceledOrders = canceledOrders,super._();
  

@override@JsonKey() final  bool paymentType;
@override@JsonKey() final  bool isLoading;
 final  List<OrderData> _orders;
@override@JsonKey() List<OrderData> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int deliveryTime;
@override@JsonKey() final  int deliveryType;
 final  List<OrderData> _deliveredOrders;
@override@JsonKey() List<OrderData> get deliveredOrders {
  if (_deliveredOrders is EqualUnmodifiableListView) return _deliveredOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deliveredOrders);
}

 final  List<OrderData> _canceledOrders;
@override@JsonKey() List<OrderData> get canceledOrders {
  if (_canceledOrders is EqualUnmodifiableListView) return _canceledOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_canceledOrders);
}

@override@JsonKey() final  int totalDeliveredOrderCount;
@override@JsonKey() final  int totalCanceledOrderCount;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrdrStateCopyWith<_OrdrState> get copyWith => __$OrdrStateCopyWithImpl<_OrdrState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrdrState&&(identical(other.paymentType, paymentType) || other.paymentType == paymentType)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.deliveryType, deliveryType) || other.deliveryType == deliveryType)&&const DeepCollectionEquality().equals(other._deliveredOrders, _deliveredOrders)&&const DeepCollectionEquality().equals(other._canceledOrders, _canceledOrders)&&(identical(other.totalDeliveredOrderCount, totalDeliveredOrderCount) || other.totalDeliveredOrderCount == totalDeliveredOrderCount)&&(identical(other.totalCanceledOrderCount, totalCanceledOrderCount) || other.totalCanceledOrderCount == totalCanceledOrderCount));
}


@override
int get hashCode => Object.hash(runtimeType,paymentType,isLoading,const DeepCollectionEquality().hash(_orders),totalCount,deliveryTime,deliveryType,const DeepCollectionEquality().hash(_deliveredOrders),const DeepCollectionEquality().hash(_canceledOrders),totalDeliveredOrderCount,totalCanceledOrderCount);

@override
String toString() {
  return 'OrderState(paymentType: $paymentType, isLoading: $isLoading, orders: $orders, totalCount: $totalCount, deliveryTime: $deliveryTime, deliveryType: $deliveryType, deliveredOrders: $deliveredOrders, canceledOrders: $canceledOrders, totalDeliveredOrderCount: $totalDeliveredOrderCount, totalCanceledOrderCount: $totalCanceledOrderCount)';
}


}

/// @nodoc
abstract mixin class _$OrdrStateCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory _$OrdrStateCopyWith(_OrdrState value, $Res Function(_OrdrState) _then) = __$OrdrStateCopyWithImpl;
@override @useResult
$Res call({
 bool paymentType, bool isLoading, List<OrderData> orders, int totalCount, int deliveryTime, int deliveryType, List<OrderData> deliveredOrders, List<OrderData> canceledOrders, int totalDeliveredOrderCount, int totalCanceledOrderCount
});




}
/// @nodoc
class __$OrdrStateCopyWithImpl<$Res>
    implements _$OrdrStateCopyWith<$Res> {
  __$OrdrStateCopyWithImpl(this._self, this._then);

  final _OrdrState _self;
  final $Res Function(_OrdrState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentType = null,Object? isLoading = null,Object? orders = null,Object? totalCount = null,Object? deliveryTime = null,Object? deliveryType = null,Object? deliveredOrders = null,Object? canceledOrders = null,Object? totalDeliveredOrderCount = null,Object? totalCanceledOrderCount = null,}) {
  return _then(_OrdrState(
paymentType: null == paymentType ? _self.paymentType : paymentType // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as int,deliveryType: null == deliveryType ? _self.deliveryType : deliveryType // ignore: cast_nullable_to_non_nullable
as int,deliveredOrders: null == deliveredOrders ? _self._deliveredOrders : deliveredOrders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,canceledOrders: null == canceledOrders ? _self._canceledOrders : canceledOrders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,totalDeliveredOrderCount: null == totalDeliveredOrderCount ? _self.totalDeliveredOrderCount : totalDeliveredOrderCount // ignore: cast_nullable_to_non_nullable
as int,totalCanceledOrderCount: null == totalCanceledOrderCount ? _self.totalCanceledOrderCount : totalCanceledOrderCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
