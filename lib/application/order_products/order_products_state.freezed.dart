// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderProductsState {

 bool get isLoading; List<ProductData> get products; String get productType;
/// Create a copy of OrderProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderProductsStateCopyWith<OrderProductsState> get copyWith => _$OrderProductsStateCopyWithImpl<OrderProductsState>(this as OrderProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.productType, productType) || other.productType == productType));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(products),productType);

@override
String toString() {
  return 'OrderProductsState(isLoading: $isLoading, products: $products, productType: $productType)';
}


}

/// @nodoc
abstract mixin class $OrderProductsStateCopyWith<$Res>  {
  factory $OrderProductsStateCopyWith(OrderProductsState value, $Res Function(OrderProductsState) _then) = _$OrderProductsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ProductData> products, String productType
});




}
/// @nodoc
class _$OrderProductsStateCopyWithImpl<$Res>
    implements $OrderProductsStateCopyWith<$Res> {
  _$OrderProductsStateCopyWithImpl(this._self, this._then);

  final OrderProductsState _self;
  final $Res Function(OrderProductsState) _then;

/// Create a copy of OrderProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? products = null,Object? productType = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductData>,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderProductsState].
extension OrderProductsStatePatterns on OrderProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderProductsState value)  $default,){
final _that = this;
switch (_that) {
case _OrderProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ProductData> products,  String productType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderProductsState() when $default != null:
return $default(_that.isLoading,_that.products,_that.productType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ProductData> products,  String productType)  $default,) {final _that = this;
switch (_that) {
case _OrderProductsState():
return $default(_that.isLoading,_that.products,_that.productType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ProductData> products,  String productType)?  $default,) {final _that = this;
switch (_that) {
case _OrderProductsState() when $default != null:
return $default(_that.isLoading,_that.products,_that.productType);case _:
  return null;

}
}

}

/// @nodoc


class _OrderProductsState extends OrderProductsState {
  const _OrderProductsState({this.isLoading = false, final  List<ProductData> products = const [], this.productType = 'single'}): _products = products,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<ProductData> _products;
@override@JsonKey() List<ProductData> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey() final  String productType;

/// Create a copy of OrderProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderProductsStateCopyWith<_OrderProductsState> get copyWith => __$OrderProductsStateCopyWithImpl<_OrderProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.productType, productType) || other.productType == productType));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_products),productType);

@override
String toString() {
  return 'OrderProductsState(isLoading: $isLoading, products: $products, productType: $productType)';
}


}

/// @nodoc
abstract mixin class _$OrderProductsStateCopyWith<$Res> implements $OrderProductsStateCopyWith<$Res> {
  factory _$OrderProductsStateCopyWith(_OrderProductsState value, $Res Function(_OrderProductsState) _then) = __$OrderProductsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ProductData> products, String productType
});




}
/// @nodoc
class __$OrderProductsStateCopyWithImpl<$Res>
    implements _$OrderProductsStateCopyWith<$Res> {
  __$OrderProductsStateCopyWithImpl(this._self, this._then);

  final _OrderProductsState _self;
  final $Res Function(_OrderProductsState) _then;

/// Create a copy of OrderProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? products = null,Object? productType = null,}) {
  return _then(_OrderProductsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductData>,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
