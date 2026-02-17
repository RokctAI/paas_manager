// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'foods_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoodsFilterState {

// @Default(null) FilterModel? filterModel,
 bool get checked; int get shopCount; double get endPrice; bool get isLoading; bool get isTagLoading; bool get isShopLoading; bool get isRestaurantLoading; RangeValues get rangeValues;// @Default([]) List<ShopData> shops,
 List<String> get tags; List<int> get prices;
/// Create a copy of FoodsFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodsFilterStateCopyWith<FoodsFilterState> get copyWith => _$FoodsFilterStateCopyWithImpl<FoodsFilterState>(this as FoodsFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodsFilterState&&(identical(other.checked, checked) || other.checked == checked)&&(identical(other.shopCount, shopCount) || other.shopCount == shopCount)&&(identical(other.endPrice, endPrice) || other.endPrice == endPrice)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isTagLoading, isTagLoading) || other.isTagLoading == isTagLoading)&&(identical(other.isShopLoading, isShopLoading) || other.isShopLoading == isShopLoading)&&(identical(other.isRestaurantLoading, isRestaurantLoading) || other.isRestaurantLoading == isRestaurantLoading)&&(identical(other.rangeValues, rangeValues) || other.rangeValues == rangeValues)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.prices, prices));
}


@override
int get hashCode => Object.hash(runtimeType,checked,shopCount,endPrice,isLoading,isTagLoading,isShopLoading,isRestaurantLoading,rangeValues,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(prices));

@override
String toString() {
  return 'FoodsFilterState(checked: $checked, shopCount: $shopCount, endPrice: $endPrice, isLoading: $isLoading, isTagLoading: $isTagLoading, isShopLoading: $isShopLoading, isRestaurantLoading: $isRestaurantLoading, rangeValues: $rangeValues, tags: $tags, prices: $prices)';
}


}

/// @nodoc
abstract mixin class $FoodsFilterStateCopyWith<$Res>  {
  factory $FoodsFilterStateCopyWith(FoodsFilterState value, $Res Function(FoodsFilterState) _then) = _$FoodsFilterStateCopyWithImpl;
@useResult
$Res call({
 bool checked, int shopCount, double endPrice, bool isLoading, bool isTagLoading, bool isShopLoading, bool isRestaurantLoading, RangeValues rangeValues, List<String> tags, List<int> prices
});




}
/// @nodoc
class _$FoodsFilterStateCopyWithImpl<$Res>
    implements $FoodsFilterStateCopyWith<$Res> {
  _$FoodsFilterStateCopyWithImpl(this._self, this._then);

  final FoodsFilterState _self;
  final $Res Function(FoodsFilterState) _then;

/// Create a copy of FoodsFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checked = null,Object? shopCount = null,Object? endPrice = null,Object? isLoading = null,Object? isTagLoading = null,Object? isShopLoading = null,Object? isRestaurantLoading = null,Object? rangeValues = null,Object? tags = null,Object? prices = null,}) {
  return _then(_self.copyWith(
checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as bool,shopCount: null == shopCount ? _self.shopCount : shopCount // ignore: cast_nullable_to_non_nullable
as int,endPrice: null == endPrice ? _self.endPrice : endPrice // ignore: cast_nullable_to_non_nullable
as double,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isTagLoading: null == isTagLoading ? _self.isTagLoading : isTagLoading // ignore: cast_nullable_to_non_nullable
as bool,isShopLoading: null == isShopLoading ? _self.isShopLoading : isShopLoading // ignore: cast_nullable_to_non_nullable
as bool,isRestaurantLoading: null == isRestaurantLoading ? _self.isRestaurantLoading : isRestaurantLoading // ignore: cast_nullable_to_non_nullable
as bool,rangeValues: null == rangeValues ? _self.rangeValues : rangeValues // ignore: cast_nullable_to_non_nullable
as RangeValues,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,prices: null == prices ? _self.prices : prices // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodsFilterState].
extension FoodsFilterStatePatterns on FoodsFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodsFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodsFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodsFilterState value)  $default,){
final _that = this;
switch (_that) {
case _FoodsFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodsFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _FoodsFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool checked,  int shopCount,  double endPrice,  bool isLoading,  bool isTagLoading,  bool isShopLoading,  bool isRestaurantLoading,  RangeValues rangeValues,  List<String> tags,  List<int> prices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodsFilterState() when $default != null:
return $default(_that.checked,_that.shopCount,_that.endPrice,_that.isLoading,_that.isTagLoading,_that.isShopLoading,_that.isRestaurantLoading,_that.rangeValues,_that.tags,_that.prices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool checked,  int shopCount,  double endPrice,  bool isLoading,  bool isTagLoading,  bool isShopLoading,  bool isRestaurantLoading,  RangeValues rangeValues,  List<String> tags,  List<int> prices)  $default,) {final _that = this;
switch (_that) {
case _FoodsFilterState():
return $default(_that.checked,_that.shopCount,_that.endPrice,_that.isLoading,_that.isTagLoading,_that.isShopLoading,_that.isRestaurantLoading,_that.rangeValues,_that.tags,_that.prices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool checked,  int shopCount,  double endPrice,  bool isLoading,  bool isTagLoading,  bool isShopLoading,  bool isRestaurantLoading,  RangeValues rangeValues,  List<String> tags,  List<int> prices)?  $default,) {final _that = this;
switch (_that) {
case _FoodsFilterState() when $default != null:
return $default(_that.checked,_that.shopCount,_that.endPrice,_that.isLoading,_that.isTagLoading,_that.isShopLoading,_that.isRestaurantLoading,_that.rangeValues,_that.tags,_that.prices);case _:
  return null;

}
}

}

/// @nodoc


class _FoodsFilterState extends FoodsFilterState {
  const _FoodsFilterState({this.checked = false, this.shopCount = 0, this.endPrice = 100, this.isLoading = false, this.isTagLoading = false, this.isShopLoading = true, this.isRestaurantLoading = true, this.rangeValues = const RangeValues(1, 100), final  List<String> tags = const [], final  List<int> prices = const []}): _tags = tags,_prices = prices,super._();
  

// @Default(null) FilterModel? filterModel,
@override@JsonKey() final  bool checked;
@override@JsonKey() final  int shopCount;
@override@JsonKey() final  double endPrice;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isTagLoading;
@override@JsonKey() final  bool isShopLoading;
@override@JsonKey() final  bool isRestaurantLoading;
@override@JsonKey() final  RangeValues rangeValues;
// @Default([]) List<ShopData> shops,
 final  List<String> _tags;
// @Default([]) List<ShopData> shops,
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<int> _prices;
@override@JsonKey() List<int> get prices {
  if (_prices is EqualUnmodifiableListView) return _prices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prices);
}


/// Create a copy of FoodsFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodsFilterStateCopyWith<_FoodsFilterState> get copyWith => __$FoodsFilterStateCopyWithImpl<_FoodsFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodsFilterState&&(identical(other.checked, checked) || other.checked == checked)&&(identical(other.shopCount, shopCount) || other.shopCount == shopCount)&&(identical(other.endPrice, endPrice) || other.endPrice == endPrice)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isTagLoading, isTagLoading) || other.isTagLoading == isTagLoading)&&(identical(other.isShopLoading, isShopLoading) || other.isShopLoading == isShopLoading)&&(identical(other.isRestaurantLoading, isRestaurantLoading) || other.isRestaurantLoading == isRestaurantLoading)&&(identical(other.rangeValues, rangeValues) || other.rangeValues == rangeValues)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._prices, _prices));
}


@override
int get hashCode => Object.hash(runtimeType,checked,shopCount,endPrice,isLoading,isTagLoading,isShopLoading,isRestaurantLoading,rangeValues,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_prices));

@override
String toString() {
  return 'FoodsFilterState(checked: $checked, shopCount: $shopCount, endPrice: $endPrice, isLoading: $isLoading, isTagLoading: $isTagLoading, isShopLoading: $isShopLoading, isRestaurantLoading: $isRestaurantLoading, rangeValues: $rangeValues, tags: $tags, prices: $prices)';
}


}

/// @nodoc
abstract mixin class _$FoodsFilterStateCopyWith<$Res> implements $FoodsFilterStateCopyWith<$Res> {
  factory _$FoodsFilterStateCopyWith(_FoodsFilterState value, $Res Function(_FoodsFilterState) _then) = __$FoodsFilterStateCopyWithImpl;
@override @useResult
$Res call({
 bool checked, int shopCount, double endPrice, bool isLoading, bool isTagLoading, bool isShopLoading, bool isRestaurantLoading, RangeValues rangeValues, List<String> tags, List<int> prices
});




}
/// @nodoc
class __$FoodsFilterStateCopyWithImpl<$Res>
    implements _$FoodsFilterStateCopyWith<$Res> {
  __$FoodsFilterStateCopyWithImpl(this._self, this._then);

  final _FoodsFilterState _self;
  final $Res Function(_FoodsFilterState) _then;

/// Create a copy of FoodsFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checked = null,Object? shopCount = null,Object? endPrice = null,Object? isLoading = null,Object? isTagLoading = null,Object? isShopLoading = null,Object? isRestaurantLoading = null,Object? rangeValues = null,Object? tags = null,Object? prices = null,}) {
  return _then(_FoodsFilterState(
checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as bool,shopCount: null == shopCount ? _self.shopCount : shopCount // ignore: cast_nullable_to_non_nullable
as int,endPrice: null == endPrice ? _self.endPrice : endPrice // ignore: cast_nullable_to_non_nullable
as double,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isTagLoading: null == isTagLoading ? _self.isTagLoading : isTagLoading // ignore: cast_nullable_to_non_nullable
as bool,isShopLoading: null == isShopLoading ? _self.isShopLoading : isShopLoading // ignore: cast_nullable_to_non_nullable
as bool,isRestaurantLoading: null == isRestaurantLoading ? _self.isRestaurantLoading : isRestaurantLoading // ignore: cast_nullable_to_non_nullable
as bool,rangeValues: null == rangeValues ? _self.rangeValues : rangeValues // ignore: cast_nullable_to_non_nullable
as RangeValues,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,prices: null == prices ? _self._prices : prices // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
