// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'on_a_way_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnAWayOrdersState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<OrderData> get orders => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  /// Create a copy of OnAWayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnAWayOrdersStateCopyWith<OnAWayOrdersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnAWayOrdersStateCopyWith<$Res> {
  factory $OnAWayOrdersStateCopyWith(
          OnAWayOrdersState value, $Res Function(OnAWayOrdersState) then) =
      _$OnAWayOrdersStateCopyWithImpl<$Res, OnAWayOrdersState>;
  @useResult
  $Res call({bool isLoading, List<OrderData> orders, int totalCount});
}

/// @nodoc
class _$OnAWayOrdersStateCopyWithImpl<$Res, $Val extends OnAWayOrdersState>
    implements $OnAWayOrdersStateCopyWith<$Res> {
  _$OnAWayOrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnAWayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? orders = null,
    Object? totalCount = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderData>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnAWayOrdersStateImplCopyWith<$Res>
    implements $OnAWayOrdersStateCopyWith<$Res> {
  factory _$$OnAWayOrdersStateImplCopyWith(_$OnAWayOrdersStateImpl value,
          $Res Function(_$OnAWayOrdersStateImpl) then) =
      __$$OnAWayOrdersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<OrderData> orders, int totalCount});
}

/// @nodoc
class __$$OnAWayOrdersStateImplCopyWithImpl<$Res>
    extends _$OnAWayOrdersStateCopyWithImpl<$Res, _$OnAWayOrdersStateImpl>
    implements _$$OnAWayOrdersStateImplCopyWith<$Res> {
  __$$OnAWayOrdersStateImplCopyWithImpl(_$OnAWayOrdersStateImpl _value,
      $Res Function(_$OnAWayOrdersStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnAWayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? orders = null,
    Object? totalCount = null,
  }) {
    return _then(_$OnAWayOrdersStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderData>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$OnAWayOrdersStateImpl extends _OnAWayOrdersState {
  const _$OnAWayOrdersStateImpl(
      {this.isLoading = false,
      final List<OrderData> orders = const [],
      this.totalCount = 0})
      : _orders = orders,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<OrderData> _orders;
  @override
  @JsonKey()
  List<OrderData> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  @JsonKey()
  final int totalCount;

  @override
  String toString() {
    return 'OnAWayOrdersState(isLoading: $isLoading, orders: $orders, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnAWayOrdersStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_orders), totalCount);

  /// Create a copy of OnAWayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnAWayOrdersStateImplCopyWith<_$OnAWayOrdersStateImpl> get copyWith =>
      __$$OnAWayOrdersStateImplCopyWithImpl<_$OnAWayOrdersStateImpl>(
          this, _$identity);
}

abstract class _OnAWayOrdersState extends OnAWayOrdersState {
  const factory _OnAWayOrdersState(
      {final bool isLoading,
      final List<OrderData> orders,
      final int totalCount}) = _$OnAWayOrdersStateImpl;
  const _OnAWayOrdersState._() : super._();

  @override
  bool get isLoading;
  @override
  List<OrderData> get orders;
  @override
  int get totalCount;

  /// Create a copy of OnAWayOrdersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnAWayOrdersStateImplCopyWith<_$OnAWayOrdersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
