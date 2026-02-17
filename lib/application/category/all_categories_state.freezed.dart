// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AllCategoriesState {

 List<CategoryData> get categories; List<CategoryData> get comboCategories; List<CategoryData> get categoriesSub; List<CategoryData> get comboCategoriesSub; int get activeIndex; int get activeSubIndex; int get activeComboIndex; int get activeComboSubIndex; TextEditingController? get categoryController; TextEditingController? get categorySubController; bool get isLoading;
/// Create a copy of AllCategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllCategoriesStateCopyWith<AllCategoriesState> get copyWith => _$AllCategoriesStateCopyWithImpl<AllCategoriesState>(this as AllCategoriesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllCategoriesState&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.comboCategories, comboCategories)&&const DeepCollectionEquality().equals(other.categoriesSub, categoriesSub)&&const DeepCollectionEquality().equals(other.comboCategoriesSub, comboCategoriesSub)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.activeSubIndex, activeSubIndex) || other.activeSubIndex == activeSubIndex)&&(identical(other.activeComboIndex, activeComboIndex) || other.activeComboIndex == activeComboIndex)&&(identical(other.activeComboSubIndex, activeComboSubIndex) || other.activeComboSubIndex == activeComboSubIndex)&&(identical(other.categoryController, categoryController) || other.categoryController == categoryController)&&(identical(other.categorySubController, categorySubController) || other.categorySubController == categorySubController)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(comboCategories),const DeepCollectionEquality().hash(categoriesSub),const DeepCollectionEquality().hash(comboCategoriesSub),activeIndex,activeSubIndex,activeComboIndex,activeComboSubIndex,categoryController,categorySubController,isLoading);

@override
String toString() {
  return 'AllCategoriesState(categories: $categories, comboCategories: $comboCategories, categoriesSub: $categoriesSub, comboCategoriesSub: $comboCategoriesSub, activeIndex: $activeIndex, activeSubIndex: $activeSubIndex, activeComboIndex: $activeComboIndex, activeComboSubIndex: $activeComboSubIndex, categoryController: $categoryController, categorySubController: $categorySubController, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $AllCategoriesStateCopyWith<$Res>  {
  factory $AllCategoriesStateCopyWith(AllCategoriesState value, $Res Function(AllCategoriesState) _then) = _$AllCategoriesStateCopyWithImpl;
@useResult
$Res call({
 List<CategoryData> categories, List<CategoryData> comboCategories, List<CategoryData> categoriesSub, List<CategoryData> comboCategoriesSub, int activeIndex, int activeSubIndex, int activeComboIndex, int activeComboSubIndex, TextEditingController? categoryController, TextEditingController? categorySubController, bool isLoading
});




}
/// @nodoc
class _$AllCategoriesStateCopyWithImpl<$Res>
    implements $AllCategoriesStateCopyWith<$Res> {
  _$AllCategoriesStateCopyWithImpl(this._self, this._then);

  final AllCategoriesState _self;
  final $Res Function(AllCategoriesState) _then;

/// Create a copy of AllCategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? comboCategories = null,Object? categoriesSub = null,Object? comboCategoriesSub = null,Object? activeIndex = null,Object? activeSubIndex = null,Object? activeComboIndex = null,Object? activeComboSubIndex = null,Object? categoryController = freezed,Object? categorySubController = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,comboCategories: null == comboCategories ? _self.comboCategories : comboCategories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,categoriesSub: null == categoriesSub ? _self.categoriesSub : categoriesSub // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,comboCategoriesSub: null == comboCategoriesSub ? _self.comboCategoriesSub : comboCategoriesSub // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,activeSubIndex: null == activeSubIndex ? _self.activeSubIndex : activeSubIndex // ignore: cast_nullable_to_non_nullable
as int,activeComboIndex: null == activeComboIndex ? _self.activeComboIndex : activeComboIndex // ignore: cast_nullable_to_non_nullable
as int,activeComboSubIndex: null == activeComboSubIndex ? _self.activeComboSubIndex : activeComboSubIndex // ignore: cast_nullable_to_non_nullable
as int,categoryController: freezed == categoryController ? _self.categoryController : categoryController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,categorySubController: freezed == categorySubController ? _self.categorySubController : categorySubController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AllCategoriesState].
extension AllCategoriesStatePatterns on AllCategoriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllCategoriesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllCategoriesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllCategoriesState value)  $default,){
final _that = this;
switch (_that) {
case _AllCategoriesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllCategoriesState value)?  $default,){
final _that = this;
switch (_that) {
case _AllCategoriesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CategoryData> categories,  List<CategoryData> comboCategories,  List<CategoryData> categoriesSub,  List<CategoryData> comboCategoriesSub,  int activeIndex,  int activeSubIndex,  int activeComboIndex,  int activeComboSubIndex,  TextEditingController? categoryController,  TextEditingController? categorySubController,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllCategoriesState() when $default != null:
return $default(_that.categories,_that.comboCategories,_that.categoriesSub,_that.comboCategoriesSub,_that.activeIndex,_that.activeSubIndex,_that.activeComboIndex,_that.activeComboSubIndex,_that.categoryController,_that.categorySubController,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CategoryData> categories,  List<CategoryData> comboCategories,  List<CategoryData> categoriesSub,  List<CategoryData> comboCategoriesSub,  int activeIndex,  int activeSubIndex,  int activeComboIndex,  int activeComboSubIndex,  TextEditingController? categoryController,  TextEditingController? categorySubController,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _AllCategoriesState():
return $default(_that.categories,_that.comboCategories,_that.categoriesSub,_that.comboCategoriesSub,_that.activeIndex,_that.activeSubIndex,_that.activeComboIndex,_that.activeComboSubIndex,_that.categoryController,_that.categorySubController,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CategoryData> categories,  List<CategoryData> comboCategories,  List<CategoryData> categoriesSub,  List<CategoryData> comboCategoriesSub,  int activeIndex,  int activeSubIndex,  int activeComboIndex,  int activeComboSubIndex,  TextEditingController? categoryController,  TextEditingController? categorySubController,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _AllCategoriesState() when $default != null:
return $default(_that.categories,_that.comboCategories,_that.categoriesSub,_that.comboCategoriesSub,_that.activeIndex,_that.activeSubIndex,_that.activeComboIndex,_that.activeComboSubIndex,_that.categoryController,_that.categorySubController,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _AllCategoriesState extends AllCategoriesState {
  const _AllCategoriesState({final  List<CategoryData> categories = const [], final  List<CategoryData> comboCategories = const [], final  List<CategoryData> categoriesSub = const [], final  List<CategoryData> comboCategoriesSub = const [], this.activeIndex = 1, this.activeSubIndex = 1, this.activeComboIndex = 1, this.activeComboSubIndex = 1, this.categoryController, this.categorySubController, this.isLoading = false}): _categories = categories,_comboCategories = comboCategories,_categoriesSub = categoriesSub,_comboCategoriesSub = comboCategoriesSub,super._();
  

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

 final  List<CategoryData> _categoriesSub;
@override@JsonKey() List<CategoryData> get categoriesSub {
  if (_categoriesSub is EqualUnmodifiableListView) return _categoriesSub;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoriesSub);
}

 final  List<CategoryData> _comboCategoriesSub;
@override@JsonKey() List<CategoryData> get comboCategoriesSub {
  if (_comboCategoriesSub is EqualUnmodifiableListView) return _comboCategoriesSub;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comboCategoriesSub);
}

@override@JsonKey() final  int activeIndex;
@override@JsonKey() final  int activeSubIndex;
@override@JsonKey() final  int activeComboIndex;
@override@JsonKey() final  int activeComboSubIndex;
@override final  TextEditingController? categoryController;
@override final  TextEditingController? categorySubController;
@override@JsonKey() final  bool isLoading;

/// Create a copy of AllCategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllCategoriesStateCopyWith<_AllCategoriesState> get copyWith => __$AllCategoriesStateCopyWithImpl<_AllCategoriesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllCategoriesState&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._comboCategories, _comboCategories)&&const DeepCollectionEquality().equals(other._categoriesSub, _categoriesSub)&&const DeepCollectionEquality().equals(other._comboCategoriesSub, _comboCategoriesSub)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.activeSubIndex, activeSubIndex) || other.activeSubIndex == activeSubIndex)&&(identical(other.activeComboIndex, activeComboIndex) || other.activeComboIndex == activeComboIndex)&&(identical(other.activeComboSubIndex, activeComboSubIndex) || other.activeComboSubIndex == activeComboSubIndex)&&(identical(other.categoryController, categoryController) || other.categoryController == categoryController)&&(identical(other.categorySubController, categorySubController) || other.categorySubController == categorySubController)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_comboCategories),const DeepCollectionEquality().hash(_categoriesSub),const DeepCollectionEquality().hash(_comboCategoriesSub),activeIndex,activeSubIndex,activeComboIndex,activeComboSubIndex,categoryController,categorySubController,isLoading);

@override
String toString() {
  return 'AllCategoriesState(categories: $categories, comboCategories: $comboCategories, categoriesSub: $categoriesSub, comboCategoriesSub: $comboCategoriesSub, activeIndex: $activeIndex, activeSubIndex: $activeSubIndex, activeComboIndex: $activeComboIndex, activeComboSubIndex: $activeComboSubIndex, categoryController: $categoryController, categorySubController: $categorySubController, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$AllCategoriesStateCopyWith<$Res> implements $AllCategoriesStateCopyWith<$Res> {
  factory _$AllCategoriesStateCopyWith(_AllCategoriesState value, $Res Function(_AllCategoriesState) _then) = __$AllCategoriesStateCopyWithImpl;
@override @useResult
$Res call({
 List<CategoryData> categories, List<CategoryData> comboCategories, List<CategoryData> categoriesSub, List<CategoryData> comboCategoriesSub, int activeIndex, int activeSubIndex, int activeComboIndex, int activeComboSubIndex, TextEditingController? categoryController, TextEditingController? categorySubController, bool isLoading
});




}
/// @nodoc
class __$AllCategoriesStateCopyWithImpl<$Res>
    implements _$AllCategoriesStateCopyWith<$Res> {
  __$AllCategoriesStateCopyWithImpl(this._self, this._then);

  final _AllCategoriesState _self;
  final $Res Function(_AllCategoriesState) _then;

/// Create a copy of AllCategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? comboCategories = null,Object? categoriesSub = null,Object? comboCategoriesSub = null,Object? activeIndex = null,Object? activeSubIndex = null,Object? activeComboIndex = null,Object? activeComboSubIndex = null,Object? categoryController = freezed,Object? categorySubController = freezed,Object? isLoading = null,}) {
  return _then(_AllCategoriesState(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,comboCategories: null == comboCategories ? _self._comboCategories : comboCategories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,categoriesSub: null == categoriesSub ? _self._categoriesSub : categoriesSub // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,comboCategoriesSub: null == comboCategoriesSub ? _self._comboCategoriesSub : comboCategoriesSub // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,activeSubIndex: null == activeSubIndex ? _self.activeSubIndex : activeSubIndex // ignore: cast_nullable_to_non_nullable
as int,activeComboIndex: null == activeComboIndex ? _self.activeComboIndex : activeComboIndex // ignore: cast_nullable_to_non_nullable
as int,activeComboSubIndex: null == activeComboSubIndex ? _self.activeComboSubIndex : activeComboSubIndex // ignore: cast_nullable_to_non_nullable
as int,categoryController: freezed == categoryController ? _self.categoryController : categoryController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,categorySubController: freezed == categorySubController ? _self.categorySubController : categorySubController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
