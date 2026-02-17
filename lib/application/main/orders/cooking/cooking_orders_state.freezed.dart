// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cooking_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CookingOrdersState {

 bool get isLoading; List<OrderData> get orders; int get totalCount;
/// Create a copy of CookingOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookingOrdersStateCopyWith<CookingOrdersState> get copyWith => _$CookingOrdersStateCopyWithImpl<CookingOrdersState>(this as CookingOrdersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CookingOrdersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.orders, orders)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(orders),totalCount);

@override
String toString() {
  return 'CookingOrdersState(isLoading: $isLoading, orders: $orders, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class $CookingOrdersStateCopyWith<$Res>  {
  factory $CookingOrdersStateCopyWith(CookingOrdersState value, $Res Function(CookingOrdersState) _then) = _$CookingOrdersStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<OrderData> orders, int totalCount
});




}
/// @nodoc
class _$CookingOrdersStateCopyWithImpl<$Res>
    implements $CookingOrdersStateCopyWith<$Res> {
  _$CookingOrdersStateCopyWithImpl(this._self, this._then);

  final CookingOrdersState _self;
  final $Res Function(CookingOrdersState) _then;

/// Create a copy of CookingOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? orders = null,Object? totalCount = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CookingOrdersState].
extension CookingOrdersStatePatterns on CookingOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CookingOrdersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CookingOrdersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CookingOrdersState value)  $default,){
final _that = this;
switch (_that) {
case _CookingOrdersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CookingOrdersState value)?  $default,){
final _that = this;
switch (_that) {
case _CookingOrdersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<OrderData> orders,  int totalCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CookingOrdersState() when $default != null:
return $default(_that.isLoading,_that.orders,_that.totalCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<OrderData> orders,  int totalCount)  $default,) {final _that = this;
switch (_that) {
case _CookingOrdersState():
return $default(_that.isLoading,_that.orders,_that.totalCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<OrderData> orders,  int totalCount)?  $default,) {final _that = this;
switch (_that) {
case _CookingOrdersState() when $default != null:
return $default(_that.isLoading,_that.orders,_that.totalCount);case _:
  return null;

}
}

}

/// @nodoc


class _CookingOrdersState extends CookingOrdersState {
  const _CookingOrdersState({this.isLoading = false, final  List<OrderData> orders = const [], this.totalCount = 0}): _orders = orders,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<OrderData> _orders;
@override@JsonKey() List<OrderData> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

@override@JsonKey() final  int totalCount;

/// Create a copy of CookingOrdersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CookingOrdersStateCopyWith<_CookingOrdersState> get copyWith => __$CookingOrdersStateCopyWithImpl<_CookingOrdersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CookingOrdersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_orders),totalCount);

@override
String toString() {
  return 'CookingOrdersState(isLoading: $isLoading, orders: $orders, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class _$CookingOrdersStateCopyWith<$Res> implements $CookingOrdersStateCopyWith<$Res> {
  factory _$CookingOrdersStateCopyWith(_CookingOrdersState value, $Res Function(_CookingOrdersState) _then) = __$CookingOrdersStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<OrderData> orders, int totalCount
});




}
/// @nodoc
class __$CookingOrdersStateCopyWithImpl<$Res>
    implements _$CookingOrdersStateCopyWith<$Res> {
  __$CookingOrdersStateCopyWithImpl(this._self, this._then);

  final _CookingOrdersState _self;
  final $Res Function(_CookingOrdersState) _then;

/// Create a copy of CookingOrdersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? orders = null,Object? totalCount = null,}) {
  return _then(_CookingOrdersState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderData>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
