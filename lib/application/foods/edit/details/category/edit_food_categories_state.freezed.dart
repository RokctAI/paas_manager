// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditFoodCategoriesState {

 bool get isLoading; List<CategoryData> get categories; int get activeIndex; TextEditingController? get categoriesController; CategoryData? get foodCategory;
/// Create a copy of EditFoodCategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditFoodCategoriesStateCopyWith<EditFoodCategoriesState> get copyWith => _$EditFoodCategoriesStateCopyWithImpl<EditFoodCategoriesState>(this as EditFoodCategoriesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditFoodCategoriesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.categoriesController, categoriesController) || other.categoriesController == categoriesController)&&(identical(other.foodCategory, foodCategory) || other.foodCategory == foodCategory));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(categories),activeIndex,categoriesController,foodCategory);

@override
String toString() {
  return 'EditFoodCategoriesState(isLoading: $isLoading, categories: $categories, activeIndex: $activeIndex, categoriesController: $categoriesController, foodCategory: $foodCategory)';
}


}

/// @nodoc
abstract mixin class $EditFoodCategoriesStateCopyWith<$Res>  {
  factory $EditFoodCategoriesStateCopyWith(EditFoodCategoriesState value, $Res Function(EditFoodCategoriesState) _then) = _$EditFoodCategoriesStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<CategoryData> categories, int activeIndex, TextEditingController? categoriesController, CategoryData? foodCategory
});




}
/// @nodoc
class _$EditFoodCategoriesStateCopyWithImpl<$Res>
    implements $EditFoodCategoriesStateCopyWith<$Res> {
  _$EditFoodCategoriesStateCopyWithImpl(this._self, this._then);

  final EditFoodCategoriesState _self;
  final $Res Function(EditFoodCategoriesState) _then;

/// Create a copy of EditFoodCategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? categories = null,Object? activeIndex = null,Object? categoriesController = freezed,Object? foodCategory = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,categoriesController: freezed == categoriesController ? _self.categoriesController : categoriesController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,foodCategory: freezed == foodCategory ? _self.foodCategory : foodCategory // ignore: cast_nullable_to_non_nullable
as CategoryData?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditFoodCategoriesState].
extension EditFoodCategoriesStatePatterns on EditFoodCategoriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditFoodCategoriesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditFoodCategoriesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditFoodCategoriesState value)  $default,){
final _that = this;
switch (_that) {
case _EditFoodCategoriesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditFoodCategoriesState value)?  $default,){
final _that = this;
switch (_that) {
case _EditFoodCategoriesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<CategoryData> categories,  int activeIndex,  TextEditingController? categoriesController,  CategoryData? foodCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditFoodCategoriesState() when $default != null:
return $default(_that.isLoading,_that.categories,_that.activeIndex,_that.categoriesController,_that.foodCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<CategoryData> categories,  int activeIndex,  TextEditingController? categoriesController,  CategoryData? foodCategory)  $default,) {final _that = this;
switch (_that) {
case _EditFoodCategoriesState():
return $default(_that.isLoading,_that.categories,_that.activeIndex,_that.categoriesController,_that.foodCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<CategoryData> categories,  int activeIndex,  TextEditingController? categoriesController,  CategoryData? foodCategory)?  $default,) {final _that = this;
switch (_that) {
case _EditFoodCategoriesState() when $default != null:
return $default(_that.isLoading,_that.categories,_that.activeIndex,_that.categoriesController,_that.foodCategory);case _:
  return null;

}
}

}

/// @nodoc


class _EditFoodCategoriesState extends EditFoodCategoriesState {
  const _EditFoodCategoriesState({this.isLoading = false, final  List<CategoryData> categories = const [], this.activeIndex = 0, this.categoriesController, this.foodCategory}): _categories = categories,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<CategoryData> _categories;
@override@JsonKey() List<CategoryData> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  int activeIndex;
@override final  TextEditingController? categoriesController;
@override final  CategoryData? foodCategory;

/// Create a copy of EditFoodCategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditFoodCategoriesStateCopyWith<_EditFoodCategoriesState> get copyWith => __$EditFoodCategoriesStateCopyWithImpl<_EditFoodCategoriesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditFoodCategoriesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.categoriesController, categoriesController) || other.categoriesController == categoriesController)&&(identical(other.foodCategory, foodCategory) || other.foodCategory == foodCategory));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_categories),activeIndex,categoriesController,foodCategory);

@override
String toString() {
  return 'EditFoodCategoriesState(isLoading: $isLoading, categories: $categories, activeIndex: $activeIndex, categoriesController: $categoriesController, foodCategory: $foodCategory)';
}


}

/// @nodoc
abstract mixin class _$EditFoodCategoriesStateCopyWith<$Res> implements $EditFoodCategoriesStateCopyWith<$Res> {
  factory _$EditFoodCategoriesStateCopyWith(_EditFoodCategoriesState value, $Res Function(_EditFoodCategoriesState) _then) = __$EditFoodCategoriesStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<CategoryData> categories, int activeIndex, TextEditingController? categoriesController, CategoryData? foodCategory
});




}
/// @nodoc
class __$EditFoodCategoriesStateCopyWithImpl<$Res>
    implements _$EditFoodCategoriesStateCopyWith<$Res> {
  __$EditFoodCategoriesStateCopyWithImpl(this._self, this._then);

  final _EditFoodCategoriesState _self;
  final $Res Function(_EditFoodCategoriesState) _then;

/// Create a copy of EditFoodCategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? categories = null,Object? activeIndex = null,Object? categoriesController = freezed,Object? foodCategory = freezed,}) {
  return _then(_EditFoodCategoriesState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryData>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,categoriesController: freezed == categoriesController ? _self.categoriesController : categoriesController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,foodCategory: freezed == foodCategory ? _self.foodCategory : foodCategory // ignore: cast_nullable_to_non_nullable
as CategoryData?,
  ));
}


}

// dart format on
