// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodayOrdersState {

 bool get isLoading; List<OrderData> get todayOrders; OrdersStatistic? get ordersStatistic; OrderData? get lastOrder;
/// Create a copy of TodayOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayOrdersStateCopyWith<TodayOrdersState> get copyWith => _$TodayOrdersStateCopyWithImpl<TodayOrdersState>(this as TodayOrdersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayOrdersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.todayOrders, todayOrders)&&(identical(other.ordersStatistic, ordersStatistic) || other.ordersStatistic == ordersStatistic)&&(identical(other.lastOrder, lastOrder) || other.lastOrder == lastOrder));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(todayOrders),ordersStatistic,lastOrder);

@override
String toString() {
  return 'TodayOrdersState(isLoading: $isLoading, todayOrders: $todayOrders, ordersStatistic: $ordersStatistic, lastOrder: $lastOrder)';
}


}

/// @nodoc
abstract mixin class $TodayOrdersStateCopyWith<$Res>  {
  factory $TodayOrdersStateCopyWith(TodayOrdersState value, $Res Function(TodayOrdersState) _then) = _$TodayOrdersStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<OrderData> todayOrders, OrdersStatistic? ordersStatistic, OrderData? lastOrder
});




}
/// @nodoc
class _$TodayOrdersStateCopyWithImpl<$Res>
    implements $TodayOrdersStateCopyWith<$Res> {
  _$TodayOrdersStateCopyWithImpl(this._self, this._then);

  final TodayOrdersState _self;
  final $Res Function(TodayOrdersState) _then;

/// Create a copy of TodayOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? todayOrders = null,Object? ordersStatistic = freezed,Object? lastOrder = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,todayOrders: null == todayOrders ? _self.todayOrders : todayOrders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,ordersStatistic: freezed == ordersStatistic ? _self.ordersStatistic : ordersStatistic // ignore: cast_nullable_to_non_nullable
as OrdersStatistic?,lastOrder: freezed == lastOrder ? _self.lastOrder : lastOrder // ignore: cast_nullable_to_non_nullable
as OrderData?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayOrdersState].
extension TodayOrdersStatePatterns on TodayOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayOrdersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayOrdersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayOrdersState value)  $default,){
final _that = this;
switch (_that) {
case _TodayOrdersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayOrdersState value)?  $default,){
final _that = this;
switch (_that) {
case _TodayOrdersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<OrderData> todayOrders,  OrdersStatistic? ordersStatistic,  OrderData? lastOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayOrdersState() when $default != null:
return $default(_that.isLoading,_that.todayOrders,_that.ordersStatistic,_that.lastOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<OrderData> todayOrders,  OrdersStatistic? ordersStatistic,  OrderData? lastOrder)  $default,) {final _that = this;
switch (_that) {
case _TodayOrdersState():
return $default(_that.isLoading,_that.todayOrders,_that.ordersStatistic,_that.lastOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<OrderData> todayOrders,  OrdersStatistic? ordersStatistic,  OrderData? lastOrder)?  $default,) {final _that = this;
switch (_that) {
case _TodayOrdersState() when $default != null:
return $default(_that.isLoading,_that.todayOrders,_that.ordersStatistic,_that.lastOrder);case _:
  return null;

}
}

}

/// @nodoc


class _TodayOrdersState extends TodayOrdersState {
  const _TodayOrdersState({this.isLoading = false, final  List<OrderData> todayOrders = const [], this.ordersStatistic, this.lastOrder}): _todayOrders = todayOrders,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<OrderData> _todayOrders;
@override@JsonKey() List<OrderData> get todayOrders {
  if (_todayOrders is EqualUnmodifiableListView) return _todayOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todayOrders);
}

@override final  OrdersStatistic? ordersStatistic;
@override final  OrderData? lastOrder;

/// Create a copy of TodayOrdersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayOrdersStateCopyWith<_TodayOrdersState> get copyWith => __$TodayOrdersStateCopyWithImpl<_TodayOrdersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayOrdersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._todayOrders, _todayOrders)&&(identical(other.ordersStatistic, ordersStatistic) || other.ordersStatistic == ordersStatistic)&&(identical(other.lastOrder, lastOrder) || other.lastOrder == lastOrder));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_todayOrders),ordersStatistic,lastOrder);

@override
String toString() {
  return 'TodayOrdersState(isLoading: $isLoading, todayOrders: $todayOrders, ordersStatistic: $ordersStatistic, lastOrder: $lastOrder)';
}


}

/// @nodoc
abstract mixin class _$TodayOrdersStateCopyWith<$Res> implements $TodayOrdersStateCopyWith<$Res> {
  factory _$TodayOrdersStateCopyWith(_TodayOrdersState value, $Res Function(_TodayOrdersState) _then) = __$TodayOrdersStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<OrderData> todayOrders, OrdersStatistic? ordersStatistic, OrderData? lastOrder
});




}
/// @nodoc
class __$TodayOrdersStateCopyWithImpl<$Res>
    implements _$TodayOrdersStateCopyWith<$Res> {
  __$TodayOrdersStateCopyWithImpl(this._self, this._then);

  final _TodayOrdersState _self;
  final $Res Function(_TodayOrdersState) _then;

/// Create a copy of TodayOrdersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? todayOrders = null,Object? ordersStatistic = freezed,Object? lastOrder = freezed,}) {
  return _then(_TodayOrdersState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,todayOrders: null == todayOrders ? _self._todayOrders : todayOrders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,ordersStatistic: freezed == ordersStatistic ? _self.ordersStatistic : ordersStatistic // ignore: cast_nullable_to_non_nullable
as OrdersStatistic?,lastOrder: freezed == lastOrder ? _self.lastOrder : lastOrder // ignore: cast_nullable_to_non_nullable
as OrderData?,
  ));
}


}

// dart format on
