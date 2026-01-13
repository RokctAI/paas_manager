// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductCategoriesState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<CategoryData> get categories => throw _privateConstructorUsedError;
  int get activeIndex => throw _privateConstructorUsedError;

  /// Create a copy of ProductCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCategoriesStateCopyWith<ProductCategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCategoriesStateCopyWith<$Res> {
  factory $ProductCategoriesStateCopyWith(ProductCategoriesState value,
          $Res Function(ProductCategoriesState) then) =
      _$ProductCategoriesStateCopyWithImpl<$Res, ProductCategoriesState>;
  @useResult
  $Res call({bool isLoading, List<CategoryData> categories, int activeIndex});
}

/// @nodoc
class _$ProductCategoriesStateCopyWithImpl<$Res,
        $Val extends ProductCategoriesState>
    implements $ProductCategoriesStateCopyWith<$Res> {
  _$ProductCategoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? categories = null,
    Object? activeIndex = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductCategoriesStateImplCopyWith<$Res>
    implements $ProductCategoriesStateCopyWith<$Res> {
  factory _$$ProductCategoriesStateImplCopyWith(
          _$ProductCategoriesStateImpl value,
          $Res Function(_$ProductCategoriesStateImpl) then) =
      __$$ProductCategoriesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<CategoryData> categories, int activeIndex});
}

/// @nodoc
class __$$ProductCategoriesStateImplCopyWithImpl<$Res>
    extends _$ProductCategoriesStateCopyWithImpl<$Res,
        _$ProductCategoriesStateImpl>
    implements _$$ProductCategoriesStateImplCopyWith<$Res> {
  __$$ProductCategoriesStateImplCopyWithImpl(
      _$ProductCategoriesStateImpl _value,
      $Res Function(_$ProductCategoriesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? categories = null,
    Object? activeIndex = null,
  }) {
    return _then(_$ProductCategoriesStateImpl(
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
    ));
  }
}

/// @nodoc

class _$ProductCategoriesStateImpl extends _ProductCategoriesState {
  const _$ProductCategoriesStateImpl(
      {this.isLoading = false,
      final List<CategoryData> categories = const [],
      this.activeIndex = 1})
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
  String toString() {
    return 'ProductCategoriesState(isLoading: $isLoading, categories: $categories, activeIndex: $activeIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductCategoriesStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.activeIndex, activeIndex) ||
                other.activeIndex == activeIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_categories), activeIndex);

  /// Create a copy of ProductCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductCategoriesStateImplCopyWith<_$ProductCategoriesStateImpl>
      get copyWith => __$$ProductCategoriesStateImplCopyWithImpl<
          _$ProductCategoriesStateImpl>(this, _$identity);
}

abstract class _ProductCategoriesState extends ProductCategoriesState {
  const factory _ProductCategoriesState(
      {final bool isLoading,
      final List<CategoryData> categories,
      final int activeIndex}) = _$ProductCategoriesStateImpl;
  const _ProductCategoriesState._() : super._();

  @override
  bool get isLoading;
  @override
  List<CategoryData> get categories;
  @override
  int get activeIndex;

  /// Create a copy of ProductCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductCategoriesStateImplCopyWith<_$ProductCategoriesStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
