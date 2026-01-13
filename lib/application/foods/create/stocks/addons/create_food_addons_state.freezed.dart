// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_food_addons_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateFoodAddonsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<ProductData> get addons => throw _privateConstructorUsedError;

  /// Create a copy of CreateFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateFoodAddonsStateCopyWith<CreateFoodAddonsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateFoodAddonsStateCopyWith<$Res> {
  factory $CreateFoodAddonsStateCopyWith(CreateFoodAddonsState value,
          $Res Function(CreateFoodAddonsState) then) =
      _$CreateFoodAddonsStateCopyWithImpl<$Res, CreateFoodAddonsState>;
  @useResult
  $Res call({bool isLoading, List<ProductData> addons});
}

/// @nodoc
class _$CreateFoodAddonsStateCopyWithImpl<$Res,
        $Val extends CreateFoodAddonsState>
    implements $CreateFoodAddonsStateCopyWith<$Res> {
  _$CreateFoodAddonsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addons = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      addons: null == addons
          ? _value.addons
          : addons // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateFoodAddonsStateImplCopyWith<$Res>
    implements $CreateFoodAddonsStateCopyWith<$Res> {
  factory _$$CreateFoodAddonsStateImplCopyWith(
          _$CreateFoodAddonsStateImpl value,
          $Res Function(_$CreateFoodAddonsStateImpl) then) =
      __$$CreateFoodAddonsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<ProductData> addons});
}

/// @nodoc
class __$$CreateFoodAddonsStateImplCopyWithImpl<$Res>
    extends _$CreateFoodAddonsStateCopyWithImpl<$Res,
        _$CreateFoodAddonsStateImpl>
    implements _$$CreateFoodAddonsStateImplCopyWith<$Res> {
  __$$CreateFoodAddonsStateImplCopyWithImpl(_$CreateFoodAddonsStateImpl _value,
      $Res Function(_$CreateFoodAddonsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addons = null,
  }) {
    return _then(_$CreateFoodAddonsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      addons: null == addons
          ? _value._addons
          : addons // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ));
  }
}

/// @nodoc

class _$CreateFoodAddonsStateImpl extends _CreateFoodAddonsState {
  const _$CreateFoodAddonsStateImpl(
      {this.isLoading = false, final List<ProductData> addons = const []})
      : _addons = addons,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<ProductData> _addons;
  @override
  @JsonKey()
  List<ProductData> get addons {
    if (_addons is EqualUnmodifiableListView) return _addons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addons);
  }

  @override
  String toString() {
    return 'CreateFoodAddonsState(isLoading: $isLoading, addons: $addons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateFoodAddonsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._addons, _addons));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_addons));

  /// Create a copy of CreateFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateFoodAddonsStateImplCopyWith<_$CreateFoodAddonsStateImpl>
      get copyWith => __$$CreateFoodAddonsStateImplCopyWithImpl<
          _$CreateFoodAddonsStateImpl>(this, _$identity);
}

abstract class _CreateFoodAddonsState extends CreateFoodAddonsState {
  const factory _CreateFoodAddonsState(
      {final bool isLoading,
      final List<ProductData> addons}) = _$CreateFoodAddonsStateImpl;
  const _CreateFoodAddonsState._() : super._();

  @override
  bool get isLoading;
  @override
  List<ProductData> get addons;

  /// Create a copy of CreateFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateFoodAddonsStateImplCopyWith<_$CreateFoodAddonsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
