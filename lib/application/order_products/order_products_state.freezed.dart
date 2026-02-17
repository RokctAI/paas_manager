// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderProductsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<ProductData> get products => throw _privateConstructorUsedError;

  /// Create a copy of OrderProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderProductsStateCopyWith<OrderProductsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderProductsStateCopyWith<$Res> {
  factory $OrderProductsStateCopyWith(
          OrderProductsState value, $Res Function(OrderProductsState) then) =
      _$OrderProductsStateCopyWithImpl<$Res, OrderProductsState>;
  @useResult
  $Res call({bool isLoading, List<ProductData> products});
}

/// @nodoc
class _$OrderProductsStateCopyWithImpl<$Res, $Val extends OrderProductsState>
    implements $OrderProductsStateCopyWith<$Res> {
  _$OrderProductsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderProductsStateImplCopyWith<$Res>
    implements $OrderProductsStateCopyWith<$Res> {
  factory _$$OrderProductsStateImplCopyWith(_$OrderProductsStateImpl value,
          $Res Function(_$OrderProductsStateImpl) then) =
      __$$OrderProductsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<ProductData> products});
}

/// @nodoc
class __$$OrderProductsStateImplCopyWithImpl<$Res>
    extends _$OrderProductsStateCopyWithImpl<$Res, _$OrderProductsStateImpl>
    implements _$$OrderProductsStateImplCopyWith<$Res> {
  __$$OrderProductsStateImplCopyWithImpl(_$OrderProductsStateImpl _value,
      $Res Function(_$OrderProductsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? products = null,
  }) {
    return _then(_$OrderProductsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ));
  }
}

/// @nodoc

class _$OrderProductsStateImpl extends _OrderProductsState {
  const _$OrderProductsStateImpl(
      {this.isLoading = false, final List<ProductData> products = const []})
      : _products = products,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<ProductData> _products;
  @override
  @JsonKey()
  List<ProductData> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'OrderProductsState(isLoading: $isLoading, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderProductsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_products));

  /// Create a copy of OrderProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderProductsStateImplCopyWith<_$OrderProductsStateImpl> get copyWith =>
      __$$OrderProductsStateImplCopyWithImpl<_$OrderProductsStateImpl>(
          this, _$identity);
}

abstract class _OrderProductsState extends OrderProductsState {
  const factory _OrderProductsState(
      {final bool isLoading,
      final List<ProductData> products}) = _$OrderProductsStateImpl;
  const _OrderProductsState._() : super._();

  @override
  bool get isLoading;
  @override
  List<ProductData> get products;

  /// Create a copy of OrderProductsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderProductsStateImplCopyWith<_$OrderProductsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
