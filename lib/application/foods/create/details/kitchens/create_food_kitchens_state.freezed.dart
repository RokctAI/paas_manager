// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_food_kitchens_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateFoodKitchensState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<KitchenModel> get kitchens => throw _privateConstructorUsedError;
  int get activeIndex => throw _privateConstructorUsedError;
  TextEditingController? get kitchenController =>
      throw _privateConstructorUsedError;

  /// Create a copy of CreateFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateFoodKitchensStateCopyWith<CreateFoodKitchensState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateFoodKitchensStateCopyWith<$Res> {
  factory $CreateFoodKitchensStateCopyWith(CreateFoodKitchensState value,
          $Res Function(CreateFoodKitchensState) then) =
      _$CreateFoodKitchensStateCopyWithImpl<$Res, CreateFoodKitchensState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<KitchenModel> kitchens,
      int activeIndex,
      TextEditingController? kitchenController});
}

/// @nodoc
class _$CreateFoodKitchensStateCopyWithImpl<$Res,
        $Val extends CreateFoodKitchensState>
    implements $CreateFoodKitchensStateCopyWith<$Res> {
  _$CreateFoodKitchensStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? kitchens = null,
    Object? activeIndex = null,
    Object? kitchenController = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      kitchens: null == kitchens
          ? _value.kitchens
          : kitchens // ignore: cast_nullable_to_non_nullable
              as List<KitchenModel>,
      activeIndex: null == activeIndex
          ? _value.activeIndex
          : activeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      kitchenController: freezed == kitchenController
          ? _value.kitchenController
          : kitchenController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateFoodKitchensStateImplCopyWith<$Res>
    implements $CreateFoodKitchensStateCopyWith<$Res> {
  factory _$$CreateFoodKitchensStateImplCopyWith(
          _$CreateFoodKitchensStateImpl value,
          $Res Function(_$CreateFoodKitchensStateImpl) then) =
      __$$CreateFoodKitchensStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<KitchenModel> kitchens,
      int activeIndex,
      TextEditingController? kitchenController});
}

/// @nodoc
class __$$CreateFoodKitchensStateImplCopyWithImpl<$Res>
    extends _$CreateFoodKitchensStateCopyWithImpl<$Res,
        _$CreateFoodKitchensStateImpl>
    implements _$$CreateFoodKitchensStateImplCopyWith<$Res> {
  __$$CreateFoodKitchensStateImplCopyWithImpl(
      _$CreateFoodKitchensStateImpl _value,
      $Res Function(_$CreateFoodKitchensStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? kitchens = null,
    Object? activeIndex = null,
    Object? kitchenController = freezed,
  }) {
    return _then(_$CreateFoodKitchensStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      kitchens: null == kitchens
          ? _value._kitchens
          : kitchens // ignore: cast_nullable_to_non_nullable
              as List<KitchenModel>,
      activeIndex: null == activeIndex
          ? _value.activeIndex
          : activeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      kitchenController: freezed == kitchenController
          ? _value.kitchenController
          : kitchenController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ));
  }
}

/// @nodoc

class _$CreateFoodKitchensStateImpl extends _CreateFoodKitchensState {
  const _$CreateFoodKitchensStateImpl(
      {this.isLoading = false,
      final List<KitchenModel> kitchens = const [],
      this.activeIndex = 0,
      this.kitchenController})
      : _kitchens = kitchens,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<KitchenModel> _kitchens;
  @override
  @JsonKey()
  List<KitchenModel> get kitchens {
    if (_kitchens is EqualUnmodifiableListView) return _kitchens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kitchens);
  }

  @override
  @JsonKey()
  final int activeIndex;
  @override
  final TextEditingController? kitchenController;

  @override
  String toString() {
    return 'CreateFoodKitchensState(isLoading: $isLoading, kitchens: $kitchens, activeIndex: $activeIndex, kitchenController: $kitchenController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateFoodKitchensStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._kitchens, _kitchens) &&
            (identical(other.activeIndex, activeIndex) ||
                other.activeIndex == activeIndex) &&
            (identical(other.kitchenController, kitchenController) ||
                other.kitchenController == kitchenController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_kitchens),
      activeIndex,
      kitchenController);

  /// Create a copy of CreateFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateFoodKitchensStateImplCopyWith<_$CreateFoodKitchensStateImpl>
      get copyWith => __$$CreateFoodKitchensStateImplCopyWithImpl<
          _$CreateFoodKitchensStateImpl>(this, _$identity);
}

abstract class _CreateFoodKitchensState extends CreateFoodKitchensState {
  const factory _CreateFoodKitchensState(
          {final bool isLoading,
          final List<KitchenModel> kitchens,
          final int activeIndex,
          final TextEditingController? kitchenController}) =
      _$CreateFoodKitchensStateImpl;
  const _CreateFoodKitchensState._() : super._();

  @override
  bool get isLoading;
  @override
  List<KitchenModel> get kitchens;
  @override
  int get activeIndex;
  @override
  TextEditingController? get kitchenController;

  /// Create a copy of CreateFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateFoodKitchensStateImplCopyWith<_$CreateFoodKitchensStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
