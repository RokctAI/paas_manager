// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodayOrdersState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<OrderData> get todayOrders => throw _privateConstructorUsedError;
  OrdersStatistic? get ordersStatistic => throw _privateConstructorUsedError;
  OrderData? get lastOrder => throw _privateConstructorUsedError;

  /// Create a copy of TodayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodayOrdersStateCopyWith<TodayOrdersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayOrdersStateCopyWith<$Res> {
  factory $TodayOrdersStateCopyWith(
          TodayOrdersState value, $Res Function(TodayOrdersState) then) =
      _$TodayOrdersStateCopyWithImpl<$Res, TodayOrdersState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<OrderData> todayOrders,
      OrdersStatistic? ordersStatistic,
      OrderData? lastOrder});
}

/// @nodoc
class _$TodayOrdersStateCopyWithImpl<$Res, $Val extends TodayOrdersState>
    implements $TodayOrdersStateCopyWith<$Res> {
  _$TodayOrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? todayOrders = null,
    Object? ordersStatistic = freezed,
    Object? lastOrder = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      todayOrders: null == todayOrders
          ? _value.todayOrders
          : todayOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderData>,
      ordersStatistic: freezed == ordersStatistic
          ? _value.ordersStatistic
          : ordersStatistic // ignore: cast_nullable_to_non_nullable
              as OrdersStatistic?,
      lastOrder: freezed == lastOrder
          ? _value.lastOrder
          : lastOrder // ignore: cast_nullable_to_non_nullable
              as OrderData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodayOrdersStateImplCopyWith<$Res>
    implements $TodayOrdersStateCopyWith<$Res> {
  factory _$$TodayOrdersStateImplCopyWith(_$TodayOrdersStateImpl value,
          $Res Function(_$TodayOrdersStateImpl) then) =
      __$$TodayOrdersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<OrderData> todayOrders,
      OrdersStatistic? ordersStatistic,
      OrderData? lastOrder});
}

/// @nodoc
class __$$TodayOrdersStateImplCopyWithImpl<$Res>
    extends _$TodayOrdersStateCopyWithImpl<$Res, _$TodayOrdersStateImpl>
    implements _$$TodayOrdersStateImplCopyWith<$Res> {
  __$$TodayOrdersStateImplCopyWithImpl(_$TodayOrdersStateImpl _value,
      $Res Function(_$TodayOrdersStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? todayOrders = null,
    Object? ordersStatistic = freezed,
    Object? lastOrder = freezed,
  }) {
    return _then(_$TodayOrdersStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      todayOrders: null == todayOrders
          ? _value._todayOrders
          : todayOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderData>,
      ordersStatistic: freezed == ordersStatistic
          ? _value.ordersStatistic
          : ordersStatistic // ignore: cast_nullable_to_non_nullable
              as OrdersStatistic?,
      lastOrder: freezed == lastOrder
          ? _value.lastOrder
          : lastOrder // ignore: cast_nullable_to_non_nullable
              as OrderData?,
    ));
  }
}

/// @nodoc

class _$TodayOrdersStateImpl extends _TodayOrdersState {
  const _$TodayOrdersStateImpl(
      {this.isLoading = false,
      final List<OrderData> todayOrders = const [],
      this.ordersStatistic,
      this.lastOrder})
      : _todayOrders = todayOrders,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<OrderData> _todayOrders;
  @override
  @JsonKey()
  List<OrderData> get todayOrders {
    if (_todayOrders is EqualUnmodifiableListView) return _todayOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todayOrders);
  }

  @override
  final OrdersStatistic? ordersStatistic;
  @override
  final OrderData? lastOrder;

  @override
  String toString() {
    return 'TodayOrdersState(isLoading: $isLoading, todayOrders: $todayOrders, ordersStatistic: $ordersStatistic, lastOrder: $lastOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayOrdersStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._todayOrders, _todayOrders) &&
            (identical(other.ordersStatistic, ordersStatistic) ||
                other.ordersStatistic == ordersStatistic) &&
            (identical(other.lastOrder, lastOrder) ||
                other.lastOrder == lastOrder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_todayOrders),
      ordersStatistic,
      lastOrder);

  /// Create a copy of TodayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayOrdersStateImplCopyWith<_$TodayOrdersStateImpl> get copyWith =>
      __$$TodayOrdersStateImplCopyWithImpl<_$TodayOrdersStateImpl>(
          this, _$identity);
}

abstract class _TodayOrdersState extends TodayOrdersState {
  const factory _TodayOrdersState(
      {final bool isLoading,
      final List<OrderData> todayOrders,
      final OrdersStatistic? ordersStatistic,
      final OrderData? lastOrder}) = _$TodayOrdersStateImpl;
  const _TodayOrdersState._() : super._();

  @override
  bool get isLoading;
  @override
  List<OrderData> get todayOrders;
  @override
  OrdersStatistic? get ordersStatistic;
  @override
  OrderData? get lastOrder;

  /// Create a copy of TodayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodayOrdersStateImplCopyWith<_$TodayOrdersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
