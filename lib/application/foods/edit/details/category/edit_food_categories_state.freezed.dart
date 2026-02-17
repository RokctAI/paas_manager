// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditFoodCategoriesState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<CategoryData> get categories => throw _privateConstructorUsedError;
  int get activeIndex => throw _privateConstructorUsedError;
  TextEditingController? get categoriesController =>
      throw _privateConstructorUsedError;
  CategoryData? get foodCategory => throw _privateConstructorUsedError;

  /// Create a copy of EditFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditFoodCategoriesStateCopyWith<EditFoodCategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditFoodCategoriesStateCopyWith<$Res> {
  factory $EditFoodCategoriesStateCopyWith(EditFoodCategoriesState value,
          $Res Function(EditFoodCategoriesState) then) =
      _$EditFoodCategoriesStateCopyWithImpl<$Res, EditFoodCategoriesState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<CategoryData> categories,
      int activeIndex,
      TextEditingController? categoriesController,
      CategoryData? foodCategory});
}

/// @nodoc
class _$EditFoodCategoriesStateCopyWithImpl<$Res,
        $Val extends EditFoodCategoriesState>
    implements $EditFoodCategoriesStateCopyWith<$Res> {
  _$EditFoodCategoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? categories = null,
    Object? activeIndex = null,
    Object? categoriesController = freezed,
    Object? foodCategory = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      activeIndex: null == activeIndex
          ? _value.activeIndex
          : activeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      categoriesController: freezed == categoriesController
          ? _value.categoriesController
          : categoriesController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      foodCategory: freezed == foodCategory
          ? _value.foodCategory
          : foodCategory // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditFoodCategoriesStateImplCopyWith<$Res>
    implements $EditFoodCategoriesStateCopyWith<$Res> {
  factory _$$EditFoodCategoriesStateImplCopyWith(
          _$EditFoodCategoriesStateImpl value,
          $Res Function(_$EditFoodCategoriesStateImpl) then) =
      __$$EditFoodCategoriesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<CategoryData> categories,
      int activeIndex,
      TextEditingController? categoriesController,
      CategoryData? foodCategory});
}

/// @nodoc
class __$$EditFoodCategoriesStateImplCopyWithImpl<$Res>
    extends _$EditFoodCategoriesStateCopyWithImpl<$Res,
        _$EditFoodCategoriesStateImpl>
    implements _$$EditFoodCategoriesStateImplCopyWith<$Res> {
  __$$EditFoodCategoriesStateImplCopyWithImpl(
      _$EditFoodCategoriesStateImpl _value,
      $Res Function(_$EditFoodCategoriesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? categories = null,
    Object? activeIndex = null,
    Object? categoriesController = freezed,
    Object? foodCategory = freezed,
  }) {
    return _then(_$EditFoodCategoriesStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      activeIndex: null == activeIndex
          ? _value.activeIndex
          : activeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      categoriesController: freezed == categoriesController
          ? _value.categoriesController
          : categoriesController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      foodCategory: freezed == foodCategory
          ? _value.foodCategory
          : foodCategory // ignore: cast_nullable_to_non_nullable
              as CategoryData?,
    ));
  }
}

/// @nodoc

class _$EditFoodCategoriesStateImpl extends _EditFoodCategoriesState {
  const _$EditFoodCategoriesStateImpl(
      {this.isLoading = false,
      final List<CategoryData> categories = const [],
      this.activeIndex = 0,
      this.categoriesController,
      this.foodCategory})
      : _categories = categories,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<CategoryData> _categories;
  @override
  @JsonKey()
  List<CategoryData> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final int activeIndex;
  @override
  final TextEditingController? categoriesController;
  @override
  final CategoryData? foodCategory;

  @override
  String toString() {
    return 'EditFoodCategoriesState(isLoading: $isLoading, categories: $categories, activeIndex: $activeIndex, categoriesController: $categoriesController, foodCategory: $foodCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditFoodCategoriesStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.activeIndex, activeIndex) ||
                other.activeIndex == activeIndex) &&
            (identical(other.categoriesController, categoriesController) ||
                other.categoriesController == categoriesController) &&
            (identical(other.foodCategory, foodCategory) ||
                other.foodCategory == foodCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_categories),
      activeIndex,
      categoriesController,
      foodCategory);

  /// Create a copy of EditFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditFoodCategoriesStateImplCopyWith<_$EditFoodCategoriesStateImpl>
      get copyWith => __$$EditFoodCategoriesStateImplCopyWithImpl<
          _$EditFoodCategoriesStateImpl>(this, _$identity);
}

abstract class _EditFoodCategoriesState extends EditFoodCategoriesState {
  const factory _EditFoodCategoriesState(
      {final bool isLoading,
      final List<CategoryData> categories,
      final int activeIndex,
      final TextEditingController? categoriesController,
      final CategoryData? foodCategory}) = _$EditFoodCategoriesStateImpl;
  const _EditFoodCategoriesState._() : super._();

  @override
  bool get isLoading;
  @override
  List<CategoryData> get categories;
  @override
  int get activeIndex;
  @override
  TextEditingController? get categoriesController;
  @override
  CategoryData? get foodCategory;

  /// Create a copy of EditFoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditFoodCategoriesStateImplCopyWith<_$EditFoodCategoriesStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
