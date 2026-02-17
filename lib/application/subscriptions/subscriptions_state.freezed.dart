// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscriptions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionState {

 bool get isLoading; bool get isPaymentLoading; int get selectPayment; int get selectSubscribe; List<SubscriptionData> get list; List<PaymentData>? get payments;
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateCopyWith<SubscriptionState> get copyWith => _$SubscriptionStateCopyWithImpl<SubscriptionState>(this as SubscriptionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPaymentLoading, isPaymentLoading) || other.isPaymentLoading == isPaymentLoading)&&(identical(other.selectPayment, selectPayment) || other.selectPayment == selectPayment)&&(identical(other.selectSubscribe, selectSubscribe) || other.selectSubscribe == selectSubscribe)&&const DeepCollectionEquality().equals(other.list, list)&&const DeepCollectionEquality().equals(other.payments, payments));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isPaymentLoading,selectPayment,selectSubscribe,const DeepCollectionEquality().hash(list),const DeepCollectionEquality().hash(payments));

@override
String toString() {
  return 'SubscriptionState(isLoading: $isLoading, isPaymentLoading: $isPaymentLoading, selectPayment: $selectPayment, selectSubscribe: $selectSubscribe, list: $list, payments: $payments)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateCopyWith<$Res>  {
  factory $SubscriptionStateCopyWith(SubscriptionState value, $Res Function(SubscriptionState) _then) = _$SubscriptionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isPaymentLoading, int selectPayment, int selectSubscribe, List<SubscriptionData> list, List<PaymentData>? payments
});




}
/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._self, this._then);

  final SubscriptionState _self;
  final $Res Function(SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isPaymentLoading = null,Object? selectPayment = null,Object? selectSubscribe = null,Object? list = null,Object? payments = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPaymentLoading: null == isPaymentLoading ? _self.isPaymentLoading : isPaymentLoading // ignore: cast_nullable_to_non_nullable
as bool,selectPayment: null == selectPayment ? _self.selectPayment : selectPayment // ignore: cast_nullable_to_non_nullable
as int,selectSubscribe: null == selectSubscribe ? _self.selectSubscribe : selectSubscribe // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<SubscriptionData>,payments: freezed == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentData>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionState].
extension SubscriptionStatePatterns on SubscriptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionState value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionState value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isPaymentLoading,  int selectPayment,  int selectSubscribe,  List<SubscriptionData> list,  List<PaymentData>? payments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.isLoading,_that.isPaymentLoading,_that.selectPayment,_that.selectSubscribe,_that.list,_that.payments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isPaymentLoading,  int selectPayment,  int selectSubscribe,  List<SubscriptionData> list,  List<PaymentData>? payments)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState():
return $default(_that.isLoading,_that.isPaymentLoading,_that.selectPayment,_that.selectSubscribe,_that.list,_that.payments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isPaymentLoading,  int selectPayment,  int selectSubscribe,  List<SubscriptionData> list,  List<PaymentData>? payments)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.isLoading,_that.isPaymentLoading,_that.selectPayment,_that.selectSubscribe,_that.list,_that.payments);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionState extends SubscriptionState {
  const _SubscriptionState({this.isLoading = false, this.isPaymentLoading = false, this.selectPayment = 1, this.selectSubscribe = 0, final  List<SubscriptionData> list = const [], final  List<PaymentData>? payments = const []}): _list = list,_payments = payments,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isPaymentLoading;
@override@JsonKey() final  int selectPayment;
@override@JsonKey() final  int selectSubscribe;
 final  List<SubscriptionData> _list;
@override@JsonKey() List<SubscriptionData> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}

 final  List<PaymentData>? _payments;
@override@JsonKey() List<PaymentData>? get payments {
  final value = _payments;
  if (value == null) return null;
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStateCopyWith<_SubscriptionState> get copyWith => __$SubscriptionStateCopyWithImpl<_SubscriptionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isPaymentLoading, isPaymentLoading) || other.isPaymentLoading == isPaymentLoading)&&(identical(other.selectPayment, selectPayment) || other.selectPayment == selectPayment)&&(identical(other.selectSubscribe, selectSubscribe) || other.selectSubscribe == selectSubscribe)&&const DeepCollectionEquality().equals(other._list, _list)&&const DeepCollectionEquality().equals(other._payments, _payments));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isPaymentLoading,selectPayment,selectSubscribe,const DeepCollectionEquality().hash(_list),const DeepCollectionEquality().hash(_payments));

@override
String toString() {
  return 'SubscriptionState(isLoading: $isLoading, isPaymentLoading: $isPaymentLoading, selectPayment: $selectPayment, selectSubscribe: $selectSubscribe, list: $list, payments: $payments)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStateCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory _$SubscriptionStateCopyWith(_SubscriptionState value, $Res Function(_SubscriptionState) _then) = __$SubscriptionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isPaymentLoading, int selectPayment, int selectSubscribe, List<SubscriptionData> list, List<PaymentData>? payments
});




}
/// @nodoc
class __$SubscriptionStateCopyWithImpl<$Res>
    implements _$SubscriptionStateCopyWith<$Res> {
  __$SubscriptionStateCopyWithImpl(this._self, this._then);

  final _SubscriptionState _self;
  final $Res Function(_SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isPaymentLoading = null,Object? selectPayment = null,Object? selectSubscribe = null,Object? list = null,Object? payments = freezed,}) {
  return _then(_SubscriptionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isPaymentLoading: null == isPaymentLoading ? _self.isPaymentLoading : isPaymentLoading // ignore: cast_nullable_to_non_nullable
as bool,selectPayment: null == selectPayment ? _self.selectPayment : selectPayment // ignore: cast_nullable_to_non_nullable
as int,selectSubscribe: null == selectSubscribe ? _self.selectSubscribe : selectSubscribe // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<SubscriptionData>,payments: freezed == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentData>?,
  ));
}


}

// dart format on
