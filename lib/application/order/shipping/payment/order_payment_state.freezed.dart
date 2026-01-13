// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_payment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderPaymentState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isCalculateLoading => throw _privateConstructorUsedError;
  List<Payment> get payments => throw _privateConstructorUsedError;
  int get selectedIndex => throw _privateConstructorUsedError;
  OrderCalculateDetail? get orderCalculate =>
      throw _privateConstructorUsedError;

  /// Create a copy of OrderPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderPaymentStateCopyWith<OrderPaymentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderPaymentStateCopyWith<$Res> {
  factory $OrderPaymentStateCopyWith(
          OrderPaymentState value, $Res Function(OrderPaymentState) then) =
      _$OrderPaymentStateCopyWithImpl<$Res, OrderPaymentState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isCalculateLoading,
      List<Payment> payments,
      int selectedIndex,
      OrderCalculateDetail? orderCalculate});
}

/// @nodoc
class _$OrderPaymentStateCopyWithImpl<$Res, $Val extends OrderPaymentState>
    implements $OrderPaymentStateCopyWith<$Res> {
  _$OrderPaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isCalculateLoading = null,
    Object? payments = null,
    Object? selectedIndex = null,
    Object? orderCalculate = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCalculateLoading: null == isCalculateLoading
          ? _value.isCalculateLoading
          : isCalculateLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<Payment>,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      orderCalculate: freezed == orderCalculate
          ? _value.orderCalculate
          : orderCalculate // ignore: cast_nullable_to_non_nullable
              as OrderCalculateDetail?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderPaymentStateImplCopyWith<$Res>
    implements $OrderPaymentStateCopyWith<$Res> {
  factory _$$OrderPaymentStateImplCopyWith(_$OrderPaymentStateImpl value,
          $Res Function(_$OrderPaymentStateImpl) then) =
      __$$OrderPaymentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isCalculateLoading,
      List<Payment> payments,
      int selectedIndex,
      OrderCalculateDetail? orderCalculate});
}

/// @nodoc
class __$$OrderPaymentStateImplCopyWithImpl<$Res>
    extends _$OrderPaymentStateCopyWithImpl<$Res, _$OrderPaymentStateImpl>
    implements _$$OrderPaymentStateImplCopyWith<$Res> {
  __$$OrderPaymentStateImplCopyWithImpl(_$OrderPaymentStateImpl _value,
      $Res Function(_$OrderPaymentStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isCalculateLoading = null,
    Object? payments = null,
    Object? selectedIndex = null,
    Object? orderCalculate = freezed,
  }) {
    return _then(_$OrderPaymentStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCalculateLoading: null == isCalculateLoading
          ? _value.isCalculateLoading
          : isCalculateLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      payments: null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<Payment>,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      orderCalculate: freezed == orderCalculate
          ? _value.orderCalculate
          : orderCalculate // ignore: cast_nullable_to_non_nullable
              as OrderCalculateDetail?,
    ));
  }
}

/// @nodoc

class _$OrderPaymentStateImpl extends _OrderPaymentState {
  const _$OrderPaymentStateImpl(
      {this.isLoading = false,
      this.isCalculateLoading = false,
      final List<Payment> payments = const [],
      this.selectedIndex = 0,
      this.orderCalculate})
      : _payments = payments,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isCalculateLoading;
  final List<Payment> _payments;
  @override
  @JsonKey()
  List<Payment> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  @JsonKey()
  final int selectedIndex;
  @override
  final OrderCalculateDetail? orderCalculate;

  @override
  String toString() {
    return 'OrderPaymentState(isLoading: $isLoading, isCalculateLoading: $isCalculateLoading, payments: $payments, selectedIndex: $selectedIndex, orderCalculate: $orderCalculate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderPaymentStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isCalculateLoading, isCalculateLoading) ||
                other.isCalculateLoading == isCalculateLoading) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.orderCalculate, orderCalculate) ||
                other.orderCalculate == orderCalculate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isCalculateLoading,
      const DeepCollectionEquality().hash(_payments),
      selectedIndex,
      orderCalculate);

  /// Create a copy of OrderPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderPaymentStateImplCopyWith<_$OrderPaymentStateImpl> get copyWith =>
      __$$OrderPaymentStateImplCopyWithImpl<_$OrderPaymentStateImpl>(
          this, _$identity);
}

abstract class _OrderPaymentState extends OrderPaymentState {
  const factory _OrderPaymentState(
      {final bool isLoading,
      final bool isCalculateLoading,
      final List<Payment> payments,
      final int selectedIndex,
      final OrderCalculateDetail? orderCalculate}) = _$OrderPaymentStateImpl;
  const _OrderPaymentState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isCalculateLoading;
  @override
  List<Payment> get payments;
  @override
  int get selectedIndex;
  @override
  OrderCalculateDetail? get orderCalculate;

  /// Create a copy of OrderPaymentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderPaymentStateImplCopyWith<_$OrderPaymentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
