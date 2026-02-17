// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsState {

 bool get isLoading; List<TypedExtra> get typedExtras; List<Stock> get initialStocks; List<int> get selectedIndexes; int get stockCount; ProductData? get productData; Stock? get selectedStock;
/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsStateCopyWith<ProductsState> get copyWith => _$ProductsStateCopyWithImpl<ProductsState>(this as ProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.typedExtras, typedExtras)&&const DeepCollectionEquality().equals(other.initialStocks, initialStocks)&&const DeepCollectionEquality().equals(other.selectedIndexes, selectedIndexes)&&(identical(other.stockCount, stockCount) || other.stockCount == stockCount)&&(identical(other.productData, productData) || other.productData == productData)&&(identical(other.selectedStock, selectedStock) || other.selectedStock == selectedStock));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(typedExtras),const DeepCollectionEquality().hash(initialStocks),const DeepCollectionEquality().hash(selectedIndexes),stockCount,productData,selectedStock);

@override
String toString() {
  return 'ProductsState(isLoading: $isLoading, typedExtras: $typedExtras, initialStocks: $initialStocks, selectedIndexes: $selectedIndexes, stockCount: $stockCount, productData: $productData, selectedStock: $selectedStock)';
}


}

/// @nodoc
abstract mixin class $ProductsStateCopyWith<$Res>  {
  factory $ProductsStateCopyWith(ProductsState value, $Res Function(ProductsState) _then) = _$ProductsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TypedExtra> typedExtras, List<Stock> initialStocks, List<int> selectedIndexes, int stockCount, ProductData? productData, Stock? selectedStock
});




}
/// @nodoc
class _$ProductsStateCopyWithImpl<$Res>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._self, this._then);

  final ProductsState _self;
  final $Res Function(ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? typedExtras = null,Object? initialStocks = null,Object? selectedIndexes = null,Object? stockCount = null,Object? productData = freezed,Object? selectedStock = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,typedExtras: null == typedExtras ? _self.typedExtras : typedExtras // ignore: cast_nullable_to_non_nullable
as List<TypedExtra>,initialStocks: null == initialStocks ? _self.initialStocks : initialStocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,selectedIndexes: null == selectedIndexes ? _self.selectedIndexes : selectedIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,stockCount: null == stockCount ? _self.stockCount : stockCount // ignore: cast_nullable_to_non_nullable
as int,productData: freezed == productData ? _self.productData : productData // ignore: cast_nullable_to_non_nullable
as ProductData?,selectedStock: freezed == selectedStock ? _self.selectedStock : selectedStock // ignore: cast_nullable_to_non_nullable
as Stock?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductsState].
extension ProductsStatePatterns on ProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductsState value)  $default,){
final _that = this;
switch (_that) {
case _ProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TypedExtra> typedExtras,  List<Stock> initialStocks,  List<int> selectedIndexes,  int stockCount,  ProductData? productData,  Stock? selectedStock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.isLoading,_that.typedExtras,_that.initialStocks,_that.selectedIndexes,_that.stockCount,_that.productData,_that.selectedStock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TypedExtra> typedExtras,  List<Stock> initialStocks,  List<int> selectedIndexes,  int stockCount,  ProductData? productData,  Stock? selectedStock)  $default,) {final _that = this;
switch (_that) {
case _ProductsState():
return $default(_that.isLoading,_that.typedExtras,_that.initialStocks,_that.selectedIndexes,_that.stockCount,_that.productData,_that.selectedStock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TypedExtra> typedExtras,  List<Stock> initialStocks,  List<int> selectedIndexes,  int stockCount,  ProductData? productData,  Stock? selectedStock)?  $default,) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.isLoading,_that.typedExtras,_that.initialStocks,_that.selectedIndexes,_that.stockCount,_that.productData,_that.selectedStock);case _:
  return null;

}
}

}

/// @nodoc


class _ProductsState extends ProductsState {
  const _ProductsState({this.isLoading = false, final  List<TypedExtra> typedExtras = const [], final  List<Stock> initialStocks = const [], final  List<int> selectedIndexes = const [], this.stockCount = 0, this.productData, this.selectedStock}): _typedExtras = typedExtras,_initialStocks = initialStocks,_selectedIndexes = selectedIndexes,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<TypedExtra> _typedExtras;
@override@JsonKey() List<TypedExtra> get typedExtras {
  if (_typedExtras is EqualUnmodifiableListView) return _typedExtras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_typedExtras);
}

 final  List<Stock> _initialStocks;
@override@JsonKey() List<Stock> get initialStocks {
  if (_initialStocks is EqualUnmodifiableListView) return _initialStocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_initialStocks);
}

 final  List<int> _selectedIndexes;
@override@JsonKey() List<int> get selectedIndexes {
  if (_selectedIndexes is EqualUnmodifiableListView) return _selectedIndexes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedIndexes);
}

@override@JsonKey() final  int stockCount;
@override final  ProductData? productData;
@override final  Stock? selectedStock;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductsStateCopyWith<_ProductsState> get copyWith => __$ProductsStateCopyWithImpl<_ProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._typedExtras, _typedExtras)&&const DeepCollectionEquality().equals(other._initialStocks, _initialStocks)&&const DeepCollectionEquality().equals(other._selectedIndexes, _selectedIndexes)&&(identical(other.stockCount, stockCount) || other.stockCount == stockCount)&&(identical(other.productData, productData) || other.productData == productData)&&(identical(other.selectedStock, selectedStock) || other.selectedStock == selectedStock));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_typedExtras),const DeepCollectionEquality().hash(_initialStocks),const DeepCollectionEquality().hash(_selectedIndexes),stockCount,productData,selectedStock);

@override
String toString() {
  return 'ProductsState(isLoading: $isLoading, typedExtras: $typedExtras, initialStocks: $initialStocks, selectedIndexes: $selectedIndexes, stockCount: $stockCount, productData: $productData, selectedStock: $selectedStock)';
}


}

/// @nodoc
abstract mixin class _$ProductsStateCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$ProductsStateCopyWith(_ProductsState value, $Res Function(_ProductsState) _then) = __$ProductsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TypedExtra> typedExtras, List<Stock> initialStocks, List<int> selectedIndexes, int stockCount, ProductData? productData, Stock? selectedStock
});




}
/// @nodoc
class __$ProductsStateCopyWithImpl<$Res>
    implements _$ProductsStateCopyWith<$Res> {
  __$ProductsStateCopyWithImpl(this._self, this._then);

  final _ProductsState _self;
  final $Res Function(_ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? typedExtras = null,Object? initialStocks = null,Object? selectedIndexes = null,Object? stockCount = null,Object? productData = freezed,Object? selectedStock = freezed,}) {
  return _then(_ProductsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,typedExtras: null == typedExtras ? _self._typedExtras : typedExtras // ignore: cast_nullable_to_non_nullable
as List<TypedExtra>,initialStocks: null == initialStocks ? _self._initialStocks : initialStocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,selectedIndexes: null == selectedIndexes ? _self._selectedIndexes : selectedIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,stockCount: null == stockCount ? _self.stockCount : stockCount // ignore: cast_nullable_to_non_nullable
as int,productData: freezed == productData ? _self.productData : productData // ignore: cast_nullable_to_non_nullable
as ProductData?,selectedStock: freezed == selectedStock ? _self.selectedStock : selectedStock // ignore: cast_nullable_to_non_nullable
as Stock?,
  ));
}


}

// dart format on
