// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderCartState {
  List<Stock> get stocks => throw _privateConstructorUsedError;
  num get totalPrice => throw _privateConstructorUsedError;

  /// Create a copy of OrderCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCartStateCopyWith<OrderCartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCartStateCopyWith<$Res> {
  factory $OrderCartStateCopyWith(
          OrderCartState value, $Res Function(OrderCartState) then) =
      _$OrderCartStateCopyWithImpl<$Res, OrderCartState>;
  @useResult
  $Res call({List<Stock> stocks, num totalPrice});
}

/// @nodoc
class _$OrderCartStateCopyWithImpl<$Res, $Val extends OrderCartState>
    implements $OrderCartStateCopyWith<$Res> {
  _$OrderCartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderCartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = null,
    Object? totalPrice = null,
  }) {
    return _then(_value.copyWith(
      stocks: null == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderCartStateImplCopyWith<$Res>
    implements $OrderCartStateCopyWith<$Res> {
  factory _$$OrderCartStateImplCopyWith(_$OrderCartStateImpl value,
          $Res Function(_$OrderCartStateImpl) then) =
      __$$OrderCartStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Stock> stocks, num totalPrice});
}

/// @nodoc
class __$$OrderCartStateImplCopyWithImpl<$Res>
    extends _$OrderCartStateCopyWithImpl<$Res, _$OrderCartStateImpl>
    implements _$$OrderCartStateImplCopyWith<$Res> {
  __$$OrderCartStateImplCopyWithImpl(
      _$OrderCartStateImpl _value, $Res Function(_$OrderCartStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderCartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = null,
    Object? totalPrice = null,
  }) {
    return _then(_$OrderCartStateImpl(
      stocks: null == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

class _$OrderCartStateImpl extends _OrderCartState {
  const _$OrderCartStateImpl(
      {final List<Stock> stocks = const [], this.totalPrice = 0})
      : _stocks = stocks,
        super._();

  final List<Stock> _stocks;
  @override
  @JsonKey()
  List<Stock> get stocks {
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stocks);
  }

  @override
  @JsonKey()
  final num totalPrice;

  @override
  String toString() {
    return 'OrderCartState(stocks: $stocks, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCartStateImpl &&
            const DeepCollectionEquality().equals(other._stocks, _stocks) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_stocks), totalPrice);

  /// Create a copy of OrderCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderCartStateImplCopyWith<_$OrderCartStateImpl> get copyWith =>
      __$$OrderCartStateImplCopyWithImpl<_$OrderCartStateImpl>(
          this, _$identity);
}

abstract class _OrderCartState extends OrderCartState {
  const factory _OrderCartState(
      {final List<Stock> stocks, final num totalPrice}) = _$OrderCartStateImpl;
  const _OrderCartState._() : super._();

  @override
  List<Stock> get stocks;
  @override
  num get totalPrice;

  /// Create a copy of OrderCartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderCartStateImplCopyWith<_$OrderCartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
