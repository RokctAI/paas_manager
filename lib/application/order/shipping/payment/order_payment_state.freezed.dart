// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_payment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderPaymentState {

 bool get isLoading; bool get isCalculateLoading; List<PaymentData> get payments; int get selectedIndex; OrderCalculateDetail? get orderCalculate;
/// Create a copy of OrderPaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderPaymentStateCopyWith<OrderPaymentState> get copyWith => _$OrderPaymentStateCopyWithImpl<OrderPaymentState>(this as OrderPaymentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderPaymentState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCalculateLoading, isCalculateLoading) || other.isCalculateLoading == isCalculateLoading)&&const DeepCollectionEquality().equals(other.payments, payments)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.orderCalculate, orderCalculate) || other.orderCalculate == orderCalculate));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isCalculateLoading,const DeepCollectionEquality().hash(payments),selectedIndex,orderCalculate);

@override
String toString() {
  return 'OrderPaymentState(isLoading: $isLoading, isCalculateLoading: $isCalculateLoading, payments: $payments, selectedIndex: $selectedIndex, orderCalculate: $orderCalculate)';
}


}

/// @nodoc
abstract mixin class $OrderPaymentStateCopyWith<$Res>  {
  factory $OrderPaymentStateCopyWith(OrderPaymentState value, $Res Function(OrderPaymentState) _then) = _$OrderPaymentStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isCalculateLoading, List<PaymentData> payments, int selectedIndex, OrderCalculateDetail? orderCalculate
});




}
/// @nodoc
class _$OrderPaymentStateCopyWithImpl<$Res>
    implements $OrderPaymentStateCopyWith<$Res> {
  _$OrderPaymentStateCopyWithImpl(this._self, this._then);

  final OrderPaymentState _self;
  final $Res Function(OrderPaymentState) _then;

/// Create a copy of OrderPaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isCalculateLoading = null,Object? payments = null,Object? selectedIndex = null,Object? orderCalculate = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCalculateLoading: null == isCalculateLoading ? _self.isCalculateLoading : isCalculateLoading // ignore: cast_nullable_to_non_nullable
as bool,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentData>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,orderCalculate: freezed == orderCalculate ? _self.orderCalculate : orderCalculate // ignore: cast_nullable_to_non_nullable
as OrderCalculateDetail?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderPaymentState].
extension OrderPaymentStatePatterns on OrderPaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderPaymentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderPaymentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderPaymentState value)  $default,){
final _that = this;
switch (_that) {
case _OrderPaymentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderPaymentState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderPaymentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isCalculateLoading,  List<PaymentData> payments,  int selectedIndex,  OrderCalculateDetail? orderCalculate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderPaymentState() when $default != null:
return $default(_that.isLoading,_that.isCalculateLoading,_that.payments,_that.selectedIndex,_that.orderCalculate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isCalculateLoading,  List<PaymentData> payments,  int selectedIndex,  OrderCalculateDetail? orderCalculate)  $default,) {final _that = this;
switch (_that) {
case _OrderPaymentState():
return $default(_that.isLoading,_that.isCalculateLoading,_that.payments,_that.selectedIndex,_that.orderCalculate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isCalculateLoading,  List<PaymentData> payments,  int selectedIndex,  OrderCalculateDetail? orderCalculate)?  $default,) {final _that = this;
switch (_that) {
case _OrderPaymentState() when $default != null:
return $default(_that.isLoading,_that.isCalculateLoading,_that.payments,_that.selectedIndex,_that.orderCalculate);case _:
  return null;

}
}

}

/// @nodoc


class _OrderPaymentState extends OrderPaymentState {
  const _OrderPaymentState({this.isLoading = false, this.isCalculateLoading = false, final  List<PaymentData> payments = const [], this.selectedIndex = 0, this.orderCalculate}): _payments = payments,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isCalculateLoading;
 final  List<PaymentData> _payments;
@override@JsonKey() List<PaymentData> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

@override@JsonKey() final  int selectedIndex;
@override final  OrderCalculateDetail? orderCalculate;

/// Create a copy of OrderPaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderPaymentStateCopyWith<_OrderPaymentState> get copyWith => __$OrderPaymentStateCopyWithImpl<_OrderPaymentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderPaymentState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCalculateLoading, isCalculateLoading) || other.isCalculateLoading == isCalculateLoading)&&const DeepCollectionEquality().equals(other._payments, _payments)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.orderCalculate, orderCalculate) || other.orderCalculate == orderCalculate));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isCalculateLoading,const DeepCollectionEquality().hash(_payments),selectedIndex,orderCalculate);

@override
String toString() {
  return 'OrderPaymentState(isLoading: $isLoading, isCalculateLoading: $isCalculateLoading, payments: $payments, selectedIndex: $selectedIndex, orderCalculate: $orderCalculate)';
}


}

/// @nodoc
abstract mixin class _$OrderPaymentStateCopyWith<$Res> implements $OrderPaymentStateCopyWith<$Res> {
  factory _$OrderPaymentStateCopyWith(_OrderPaymentState value, $Res Function(_OrderPaymentState) _then) = __$OrderPaymentStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isCalculateLoading, List<PaymentData> payments, int selectedIndex, OrderCalculateDetail? orderCalculate
});




}
/// @nodoc
class __$OrderPaymentStateCopyWithImpl<$Res>
    implements _$OrderPaymentStateCopyWith<$Res> {
  __$OrderPaymentStateCopyWithImpl(this._self, this._then);

  final _OrderPaymentState _self;
  final $Res Function(_OrderPaymentState) _then;

/// Create a copy of OrderPaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isCalculateLoading = null,Object? payments = null,Object? selectedIndex = null,Object? orderCalculate = freezed,}) {
  return _then(_OrderPaymentState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCalculateLoading: null == isCalculateLoading ? _self.isCalculateLoading : isCalculateLoading // ignore: cast_nullable_to_non_nullable
as bool,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentData>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,orderCalculate: freezed == orderCalculate ? _self.orderCalculate : orderCalculate // ignore: cast_nullable_to_non_nullable
as OrderCalculateDetail?,
  ));
}


}

// dart format on
