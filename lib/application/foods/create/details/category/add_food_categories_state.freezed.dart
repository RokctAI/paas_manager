// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_food_categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddFoodCategoriesState {
  List<CategoryData> get categories => throw _privateConstructorUsedError;
  List<CategoryData> get categoriesSub => throw _privateConstructorUsedError;
  int get activeIndex => throw _privateConstructorUsedError;
  int get activeSubIndex => throw _privateConstructorUsedError;
  TextEditingController? get categoryController =>
      throw _privateConstructorUsedError;
  TextEditingController? get categorySubController =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddFoodCategoriesStateCopyWith<AddFoodCategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddFoodCategoriesStateCopyWith<$Res> {
  factory $AddFoodCategoriesStateCopyWith(AddFoodCategoriesState value,
          $Res Function(AddFoodCategoriesState) then) =
      _$AddFoodCategoriesStateCopyWithImpl<$Res, AddFoodCategoriesState>;
  @useResult
  $Res call(
      {List<CategoryData> categories,
      List<CategoryData> categoriesSub,
      int activeIndex,
      int activeSubIndex,
      TextEditingController? categoryController,
      TextEditingController? categorySubController});
}

/// @nodoc
class _$AddFoodCategoriesStateCopyWithImpl<$Res,
        $Val extends AddFoodCategoriesState>
    implements $AddFoodCategoriesStateCopyWith<$Res> {
  _$AddFoodCategoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? categoriesSub = null,
    Object? activeIndex = null,
    Object? activeSubIndex = null,
    Object? categoryController = freezed,
    Object? categorySubController = freezed,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      categoriesSub: null == categoriesSub
          ? _value.categoriesSub
          : categoriesSub // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      activeIndex: null == activeIndex
          ? _value.activeIndex
          : activeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      activeSubIndex: null == activeSubIndex
          ? _value.activeSubIndex
          : activeSubIndex // ignore: cast_nullable_to_non_nullable
              as int,
      categoryController: freezed == categoryController
          ? _value.categoryController
          : categoryController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      categorySubController: freezed == categorySubController
          ? _value.categorySubController
          : categorySubController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddFoodCategoriesStateImplCopyWith<$Res>
    implements $AddFoodCategoriesStateCopyWith<$Res> {
  factory _$$AddFoodCategoriesStateImplCopyWith(
          _$AddFoodCategoriesStateImpl value,
          $Res Function(_$AddFoodCategoriesStateImpl) then) =
      __$$AddFoodCategoriesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CategoryData> categories,
      List<CategoryData> categoriesSub,
      int activeIndex,
      int activeSubIndex,
      TextEditingController? categoryController,
      TextEditingController? categorySubController});
}

/// @nodoc
class __$$AddFoodCategoriesStateImplCopyWithImpl<$Res>
    extends _$AddFoodCategoriesStateCopyWithImpl<$Res,
        _$AddFoodCategoriesStateImpl>
    implements _$$AddFoodCategoriesStateImplCopyWith<$Res> {
  __$$AddFoodCategoriesStateImplCopyWithImpl(
      _$AddFoodCategoriesStateImpl _value,
      $Res Function(_$AddFoodCategoriesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? categoriesSub = null,
    Object? activeIndex = null,
    Object? activeSubIndex = null,
    Object? categoryController = freezed,
    Object? categorySubController = freezed,
  }) {
    return _then(_$AddFoodCategoriesStateImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      categoriesSub: null == categoriesSub
          ? _value._categoriesSub
          : categoriesSub // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      activeIndex: null == activeIndex
          ? _value.activeIndex
          : activeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      activeSubIndex: null == activeSubIndex
          ? _value.activeSubIndex
          : activeSubIndex // ignore: cast_nullable_to_non_nullable
              as int,
      categoryController: freezed == categoryController
          ? _value.categoryController
          : categoryController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      categorySubController: freezed == categorySubController
          ? _value.categorySubController
          : categorySubController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ));
  }
}

/// @nodoc

class _$AddFoodCategoriesStateImpl extends _AddFoodCategoriesState {
  const _$AddFoodCategoriesStateImpl(
      {final List<CategoryData> categories = const [],
      final List<CategoryData> categoriesSub = const [],
      this.activeIndex = 1,
      this.activeSubIndex = 1,
      this.categoryController,
      this.categorySubController})
      : _categories = categories,
        _categoriesSub = categoriesSub,
        super._();

  final List<CategoryData> _categories;
  @override
  @JsonKey()
  List<CategoryData> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<CategoryData> _categoriesSub;
  @override
  @JsonKey()
  List<CategoryData> get categoriesSub {
    if (_categoriesSub is EqualUnmodifiableListView) return _categoriesSub;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoriesSub);
  }

  @override
  @JsonKey()
  final int activeIndex;
  @override
  @JsonKey()
  final int activeSubIndex;
  @override
  final TextEditingController? categoryController;
  @override
  final TextEditingController? categorySubController;

  @override
  String toString() {
    return 'AddFoodCategoriesState(categories: $categories, categoriesSub: $categoriesSub, activeIndex: $activeIndex, activeSubIndex: $activeSubIndex, categoryController: $categoryController, categorySubController: $categorySubController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddFoodCategoriesStateImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._categoriesSub, _categoriesSub) &&
            (identical(other.activeIndex, activeIndex) ||
                other.activeIndex == activeIndex) &&
            (identical(other.activeSubIndex, activeSubIndex) ||
                other.activeSubIndex == activeSubIndex) &&
            (identical(other.categoryController, categoryController) ||
                other.categoryController == categoryController) &&
            (identical(other.categorySubController, categorySubController) ||
                other.categorySubController == categorySubController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_categoriesSub),
      activeIndex,
      activeSubIndex,
      categoryController,
      categorySubController);

  /// Create a copy of AddFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddFoodCategoriesStateImplCopyWith<_$AddFoodCategoriesStateImpl>
      get copyWith => __$$AddFoodCategoriesStateImplCopyWithImpl<
          _$AddFoodCategoriesStateImpl>(this, _$identity);
}

abstract class _AddFoodCategoriesState extends AddFoodCategoriesState {
  const factory _AddFoodCategoriesState(
          {final List<CategoryData> categories,
          final List<CategoryData> categoriesSub,
          final int activeIndex,
          final int activeSubIndex,
          final TextEditingController? categoryController,
          final TextEditingController? categorySubController}) =
      _$AddFoodCategoriesStateImpl;
  const _AddFoodCategoriesState._() : super._();

  @override
  List<CategoryData> get categories;
  @override
  List<CategoryData> get categoriesSub;
  @override
  int get activeIndex;
  @override
  int get activeSubIndex;
  @override
  TextEditingController? get categoryController;
  @override
  TextEditingController? get categorySubController;

  /// Create a copy of AddFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddFoodCategoriesStateImplCopyWith<_$AddFoodCategoriesStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
