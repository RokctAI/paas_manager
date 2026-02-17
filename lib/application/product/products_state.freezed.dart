// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<TypedExtra> get typedExtras => throw _privateConstructorUsedError;
  List<Stock> get initialStocks => throw _privateConstructorUsedError;
  List<int> get selectedIndexes => throw _privateConstructorUsedError;
  int get stockCount => throw _privateConstructorUsedError;
  ProductData? get productData => throw _privateConstructorUsedError;
  Stock? get selectedStock => throw _privateConstructorUsedError;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductsStateCopyWith<ProductsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsStateCopyWith<$Res> {
  factory $ProductsStateCopyWith(
          ProductsState value, $Res Function(ProductsState) then) =
      _$ProductsStateCopyWithImpl<$Res, ProductsState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<TypedExtra> typedExtras,
      List<Stock> initialStocks,
      List<int> selectedIndexes,
      int stockCount,
      ProductData? productData,
      Stock? selectedStock});
}

/// @nodoc
class _$ProductsStateCopyWithImpl<$Res, $Val extends ProductsState>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? typedExtras = null,
    Object? initialStocks = null,
    Object? selectedIndexes = null,
    Object? stockCount = null,
    Object? productData = freezed,
    Object? selectedStock = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      typedExtras: null == typedExtras
          ? _value.typedExtras
          : typedExtras // ignore: cast_nullable_to_non_nullable
              as List<TypedExtra>,
      initialStocks: null == initialStocks
          ? _value.initialStocks
          : initialStocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>,
      selectedIndexes: null == selectedIndexes
          ? _value.selectedIndexes
          : selectedIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      stockCount: null == stockCount
          ? _value.stockCount
          : stockCount // ignore: cast_nullable_to_non_nullable
              as int,
      productData: freezed == productData
          ? _value.productData
          : productData // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      selectedStock: freezed == selectedStock
          ? _value.selectedStock
          : selectedStock // ignore: cast_nullable_to_non_nullable
              as Stock?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductsStateImplCopyWith<$Res>
    implements $ProductsStateCopyWith<$Res> {
  factory _$$ProductsStateImplCopyWith(
          _$ProductsStateImpl value, $Res Function(_$ProductsStateImpl) then) =
      __$$ProductsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<TypedExtra> typedExtras,
      List<Stock> initialStocks,
      List<int> selectedIndexes,
      int stockCount,
      ProductData? productData,
      Stock? selectedStock});
}

/// @nodoc
class __$$ProductsStateImplCopyWithImpl<$Res>
    extends _$ProductsStateCopyWithImpl<$Res, _$ProductsStateImpl>
    implements _$$ProductsStateImplCopyWith<$Res> {
  __$$ProductsStateImplCopyWithImpl(
      _$ProductsStateImpl _value, $Res Function(_$ProductsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? typedExtras = null,
    Object? initialStocks = null,
    Object? selectedIndexes = null,
    Object? stockCount = null,
    Object? productData = freezed,
    Object? selectedStock = freezed,
  }) {
    return _then(_$ProductsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      typedExtras: null == typedExtras
          ? _value._typedExtras
          : typedExtras // ignore: cast_nullable_to_non_nullable
              as List<TypedExtra>,
      initialStocks: null == initialStocks
          ? _value._initialStocks
          : initialStocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>,
      selectedIndexes: null == selectedIndexes
          ? _value._selectedIndexes
          : selectedIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      stockCount: null == stockCount
          ? _value.stockCount
          : stockCount // ignore: cast_nullable_to_non_nullable
              as int,
      productData: freezed == productData
          ? _value.productData
          : productData // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      selectedStock: freezed == selectedStock
          ? _value.selectedStock
          : selectedStock // ignore: cast_nullable_to_non_nullable
              as Stock?,
    ));
  }
}

/// @nodoc

class _$ProductsStateImpl extends _ProductsState {
  const _$ProductsStateImpl(
      {this.isLoading = false,
      final List<TypedExtra> typedExtras = const [],
      final List<Stock> initialStocks = const [],
      final List<int> selectedIndexes = const [],
      this.stockCount = 0,
      this.productData,
      this.selectedStock})
      : _typedExtras = typedExtras,
        _initialStocks = initialStocks,
        _selectedIndexes = selectedIndexes,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<TypedExtra> _typedExtras;
  @override
  @JsonKey()
  List<TypedExtra> get typedExtras {
    if (_typedExtras is EqualUnmodifiableListView) return _typedExtras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typedExtras);
  }

  final List<Stock> _initialStocks;
  @override
  @JsonKey()
  List<Stock> get initialStocks {
    if (_initialStocks is EqualUnmodifiableListView) return _initialStocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_initialStocks);
  }

  final List<int> _selectedIndexes;
  @override
  @JsonKey()
  List<int> get selectedIndexes {
    if (_selectedIndexes is EqualUnmodifiableListView) return _selectedIndexes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedIndexes);
  }

  @override
  @JsonKey()
  final int stockCount;
  @override
  final ProductData? productData;
  @override
  final Stock? selectedStock;

  @override
  String toString() {
    return 'ProductsState(isLoading: $isLoading, typedExtras: $typedExtras, initialStocks: $initialStocks, selectedIndexes: $selectedIndexes, stockCount: $stockCount, productData: $productData, selectedStock: $selectedStock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._typedExtras, _typedExtras) &&
            const DeepCollectionEquality()
                .equals(other._initialStocks, _initialStocks) &&
            const DeepCollectionEquality()
                .equals(other._selectedIndexes, _selectedIndexes) &&
            (identical(other.stockCount, stockCount) ||
                other.stockCount == stockCount) &&
            (identical(other.productData, productData) ||
                other.productData == productData) &&
            (identical(other.selectedStock, selectedStock) ||
                other.selectedStock == selectedStock));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_typedExtras),
      const DeepCollectionEquality().hash(_initialStocks),
      const DeepCollectionEquality().hash(_selectedIndexes),
      stockCount,
      productData,
      selectedStock);

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductsStateImplCopyWith<_$ProductsStateImpl> get copyWith =>
      __$$ProductsStateImplCopyWithImpl<_$ProductsStateImpl>(this, _$identity);
}

abstract class _ProductsState extends ProductsState {
  const factory _ProductsState(
      {final bool isLoading,
      final List<TypedExtra> typedExtras,
      final List<Stock> initialStocks,
      final List<int> selectedIndexes,
      final int stockCount,
      final ProductData? productData,
      final Stock? selectedStock}) = _$ProductsStateImpl;
  const _ProductsState._() : super._();

  @override
  bool get isLoading;
  @override
  List<TypedExtra> get typedExtras;
  @override
  List<Stock> get initialStocks;
  @override
  List<int> get selectedIndexes;
  @override
  int get stockCount;
  @override
  ProductData? get productData;
  @override
  Stock? get selectedStock;

  /// Create a copy of ProductsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductsStateImplCopyWith<_$ProductsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
