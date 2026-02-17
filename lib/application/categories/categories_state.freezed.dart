// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoriesState {

 bool get isLoading; bool get isComboLoading; List<CategoryData> get categories; List<CategoryData> get comboCategories; int get activeIndex; int get activeComboIndex;
/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesStateCopyWith<CategoriesState> get copyWith => _$CategoriesStateCopyWithImpl<CategoriesState>(this as CategoriesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isComboLoading, isComboLoading) || other.isComboLoading == isComboLoading)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.comboCategories, comboCategories)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.activeComboIndex, activeComboIndex) || other.activeComboIndex == activeComboIndex));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isComboLoading,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(comboCategories),activeIndex,activeComboIndex);

@override
String toString() {
  return 'CategoriesState(isLoading: $isLoading, isComboLoading: $isComboLoading, categories: $categories, comboCategories: $comboCategories, activeIndex: $activeIndex, activeComboIndex: $activeComboIndex)';
}


}

/// @nodoc
abstract mixin class $CategoriesStateCopyWith<$Res>  {
  factory $CategoriesStateCopyWith(CategoriesState value, $Res Function(CategoriesState) _then) = _$CategoriesStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isComboLoading, List<CategoryData> categories, List<CategoryData> comboCategories, int activeIndex, int activeComboIndex
});




}
/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._self, this._then);

  final CategoriesState _self;
  final $Res Function(CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isComboLoading = null,Object? categories = null,Object? comboCategories = null,Object? activeIndex = null,Object? activeComboIndex = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isComboLoading: null == isComboLoading ? _self.isComboLoading : isComboLoading // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,comboCategories: null == comboCategories ? _self.comboCategories : comboCategories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,activeComboIndex: null == activeComboIndex ? _self.activeComboIndex : activeComboIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoriesState].
extension CategoriesStatePatterns on CategoriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoriesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoriesState value)  $default,){
final _that = this;
switch (_that) {
case _CategoriesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoriesState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isComboLoading,  List<CategoryData> categories,  List<CategoryData> comboCategories,  int activeIndex,  int activeComboIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.isLoading,_that.isComboLoading,_that.categories,_that.comboCategories,_that.activeIndex,_that.activeComboIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isComboLoading,  List<CategoryData> categories,  List<CategoryData> comboCategories,  int activeIndex,  int activeComboIndex)  $default,) {final _that = this;
switch (_that) {
case _CategoriesState():
return $default(_that.isLoading,_that.isComboLoading,_that.categories,_that.comboCategories,_that.activeIndex,_that.activeComboIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isComboLoading,  List<CategoryData> categories,  List<CategoryData> comboCategories,  int activeIndex,  int activeComboIndex)?  $default,) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.isLoading,_that.isComboLoading,_that.categories,_that.comboCategories,_that.activeIndex,_that.activeComboIndex);case _:
  return null;

}
}

}

/// @nodoc


class _CategoriesState extends CategoriesState {
  const _CategoriesState({this.isLoading = false, this.isComboLoading = false, final  List<CategoryData> categories = const [], final  List<CategoryData> comboCategories = const [], this.activeIndex = 1, this.activeComboIndex = 1}): _categories = categories,_comboCategories = comboCategories,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isComboLoading;
 final  List<CategoryData> _categories;
@override@JsonKey() List<CategoryData> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<CategoryData> _comboCategories;
@override@JsonKey() List<CategoryData> get comboCategories {
  if (_comboCategories is EqualUnmodifiableListView) return _comboCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comboCategories);
}

@override@JsonKey() final  int activeIndex;
@override@JsonKey() final  int activeComboIndex;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoriesStateCopyWith<_CategoriesState> get copyWith => __$CategoriesStateCopyWithImpl<_CategoriesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoriesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isComboLoading, isComboLoading) || other.isComboLoading == isComboLoading)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._comboCategories, _comboCategories)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.activeComboIndex, activeComboIndex) || other.activeComboIndex == activeComboIndex));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isComboLoading,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_comboCategories),activeIndex,activeComboIndex);

@override
String toString() {
  return 'CategoriesState(isLoading: $isLoading, isComboLoading: $isComboLoading, categories: $categories, comboCategories: $comboCategories, activeIndex: $activeIndex, activeComboIndex: $activeComboIndex)';
}


}

/// @nodoc
abstract mixin class _$CategoriesStateCopyWith<$Res> implements $CategoriesStateCopyWith<$Res> {
  factory _$CategoriesStateCopyWith(_CategoriesState value, $Res Function(_CategoriesState) _then) = __$CategoriesStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isComboLoading, List<CategoryData> categories, List<CategoryData> comboCategories, int activeIndex, int activeComboIndex
});




}
/// @nodoc
class __$CategoriesStateCopyWithImpl<$Res>
    implements _$CategoriesStateCopyWith<$Res> {
  __$CategoriesStateCopyWithImpl(this._self, this._then);

  final _CategoriesState _self;
  final $Res Function(_CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isComboLoading = null,Object? categories = null,Object? comboCategories = null,Object? activeIndex = null,Object? activeComboIndex = null,}) {
  return _then(_CategoriesState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isComboLoading: null == isComboLoading ? _self.isComboLoading : isComboLoading // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,comboCategories: null == comboCategories ? _self._comboCategories : comboCategories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,activeComboIndex: null == activeComboIndex ? _self.activeComboIndex : activeComboIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
