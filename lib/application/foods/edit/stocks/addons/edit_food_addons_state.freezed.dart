// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_addons_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditFoodAddonsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<ProductData> get addons => throw _privateConstructorUsedError;

  /// Create a copy of EditFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditFoodAddonsStateCopyWith<EditFoodAddonsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditFoodAddonsStateCopyWith<$Res> {
  factory $EditFoodAddonsStateCopyWith(
          EditFoodAddonsState value, $Res Function(EditFoodAddonsState) then) =
      _$EditFoodAddonsStateCopyWithImpl<$Res, EditFoodAddonsState>;
  @useResult
  $Res call({bool isLoading, List<ProductData> addons});
}

/// @nodoc
class _$EditFoodAddonsStateCopyWithImpl<$Res, $Val extends EditFoodAddonsState>
    implements $EditFoodAddonsStateCopyWith<$Res> {
  _$EditFoodAddonsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditFoodAddonsState
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
abstract class _$$EditFoodAddonsStateImplCopyWith<$Res>
    implements $EditFoodAddonsStateCopyWith<$Res> {
  factory _$$EditFoodAddonsStateImplCopyWith(_$EditFoodAddonsStateImpl value,
          $Res Function(_$EditFoodAddonsStateImpl) then) =
      __$$EditFoodAddonsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<ProductData> addons});
}

/// @nodoc
class __$$EditFoodAddonsStateImplCopyWithImpl<$Res>
    extends _$EditFoodAddonsStateCopyWithImpl<$Res, _$EditFoodAddonsStateImpl>
    implements _$$EditFoodAddonsStateImplCopyWith<$Res> {
  __$$EditFoodAddonsStateImplCopyWithImpl(_$EditFoodAddonsStateImpl _value,
      $Res Function(_$EditFoodAddonsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addons = null,
  }) {
    return _then(_$EditFoodAddonsStateImpl(
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

class _$EditFoodAddonsStateImpl extends _EditFoodAddonsState {
  const _$EditFoodAddonsStateImpl(
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
    return 'EditFoodAddonsState(isLoading: $isLoading, addons: $addons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditFoodAddonsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._addons, _addons));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_addons));

  /// Create a copy of EditFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditFoodAddonsStateImplCopyWith<_$EditFoodAddonsStateImpl> get copyWith =>
      __$$EditFoodAddonsStateImplCopyWithImpl<_$EditFoodAddonsStateImpl>(
          this, _$identity);
}

abstract class _EditFoodAddonsState extends EditFoodAddonsState {
  const factory _EditFoodAddonsState(
      {final bool isLoading,
      final List<ProductData> addons}) = _$EditFoodAddonsStateImpl;
  const _EditFoodAddonsState._() : super._();

  @override
  bool get isLoading;
  @override
  List<ProductData> get addons;

  /// Create a copy of EditFoodAddonsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditFoodAddonsStateImplCopyWith<_$EditFoodAddonsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
