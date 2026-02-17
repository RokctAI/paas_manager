// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'foods_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoodsState {

 bool get isLoading; List<ProductData> get foods; String get productType;
/// Create a copy of FoodsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodsStateCopyWith<FoodsState> get copyWith => _$FoodsStateCopyWithImpl<FoodsState>(this as FoodsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.foods, foods)&&(identical(other.productType, productType) || other.productType == productType));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(foods),productType);

@override
String toString() {
  return 'FoodsState(isLoading: $isLoading, foods: $foods, productType: $productType)';
}


}

/// @nodoc
abstract mixin class $FoodsStateCopyWith<$Res>  {
  factory $FoodsStateCopyWith(FoodsState value, $Res Function(FoodsState) _then) = _$FoodsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ProductData> foods, String productType
});




}
/// @nodoc
class _$FoodsStateCopyWithImpl<$Res>
    implements $FoodsStateCopyWith<$Res> {
  _$FoodsStateCopyWithImpl(this._self, this._then);

  final FoodsState _self;
  final $Res Function(FoodsState) _then;

/// Create a copy of FoodsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? foods = null,Object? productType = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,foods: null == foods ? _self.foods : foods // ignore: cast_nullable_to_non_nullable
as List<ProductData>,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodsState].
extension FoodsStatePatterns on FoodsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodsState value)  $default,){
final _that = this;
switch (_that) {
case _FoodsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodsState value)?  $default,){
final _that = this;
switch (_that) {
case _FoodsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ProductData> foods,  String productType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodsState() when $default != null:
return $default(_that.isLoading,_that.foods,_that.productType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ProductData> foods,  String productType)  $default,) {final _that = this;
switch (_that) {
case _FoodsState():
return $default(_that.isLoading,_that.foods,_that.productType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ProductData> foods,  String productType)?  $default,) {final _that = this;
switch (_that) {
case _FoodsState() when $default != null:
return $default(_that.isLoading,_that.foods,_that.productType);case _:
  return null;

}
}

}

/// @nodoc


class _FoodsState extends FoodsState {
  const _FoodsState({this.isLoading = false, final  List<ProductData> foods = const [], this.productType = 'single'}): _foods = foods,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<ProductData> _foods;
@override@JsonKey() List<ProductData> get foods {
  if (_foods is EqualUnmodifiableListView) return _foods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_foods);
}

@override@JsonKey() final  String productType;

/// Create a copy of FoodsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodsStateCopyWith<_FoodsState> get copyWith => __$FoodsStateCopyWithImpl<_FoodsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._foods, _foods)&&(identical(other.productType, productType) || other.productType == productType));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_foods),productType);

@override
String toString() {
  return 'FoodsState(isLoading: $isLoading, foods: $foods, productType: $productType)';
}


}

/// @nodoc
abstract mixin class _$FoodsStateCopyWith<$Res> implements $FoodsStateCopyWith<$Res> {
  factory _$FoodsStateCopyWith(_FoodsState value, $Res Function(_FoodsState) _then) = __$FoodsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ProductData> foods, String productType
});




}
/// @nodoc
class __$FoodsStateCopyWithImpl<$Res>
    implements _$FoodsStateCopyWith<$Res> {
  __$FoodsStateCopyWithImpl(this._self, this._then);

  final _FoodsState _self;
  final $Res Function(_FoodsState) _then;

/// Create a copy of FoodsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? foods = null,Object? productType = null,}) {
  return _then(_FoodsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,foods: null == foods ? _self._foods : foods // ignore: cast_nullable_to_non_nullable
as List<ProductData>,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
