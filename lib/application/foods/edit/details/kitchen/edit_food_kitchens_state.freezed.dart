// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_kitchens_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditFoodKitchensState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<KitchenModel> get kitchens => throw _privateConstructorUsedError;
  int get activeIndex => throw _privateConstructorUsedError;
  TextEditingController? get kitchenController =>
      throw _privateConstructorUsedError;
  KitchenModel? get foodKitchen => throw _privateConstructorUsedError;

  /// Create a copy of EditFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditFoodKitchensStateCopyWith<EditFoodKitchensState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditFoodKitchensStateCopyWith<$Res> {
  factory $EditFoodKitchensStateCopyWith(EditFoodKitchensState value,
          $Res Function(EditFoodKitchensState) then) =
      _$EditFoodKitchensStateCopyWithImpl<$Res, EditFoodKitchensState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<KitchenModel> kitchens,
      int activeIndex,
      TextEditingController? kitchenController,
      KitchenModel? foodKitchen});
}

/// @nodoc
class _$EditFoodKitchensStateCopyWithImpl<$Res,
        $Val extends EditFoodKitchensState>
    implements $EditFoodKitchensStateCopyWith<$Res> {
  _$EditFoodKitchensStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? kitchens = null,
    Object? activeIndex = null,
    Object? kitchenController = freezed,
    Object? foodKitchen = freezed,
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
      foodKitchen: freezed == foodKitchen
          ? _value.foodKitchen
          : foodKitchen // ignore: cast_nullable_to_non_nullable
              as KitchenModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditFoodKitchensStateImplCopyWith<$Res>
    implements $EditFoodKitchensStateCopyWith<$Res> {
  factory _$$EditFoodKitchensStateImplCopyWith(
          _$EditFoodKitchensStateImpl value,
          $Res Function(_$EditFoodKitchensStateImpl) then) =
      __$$EditFoodKitchensStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<KitchenModel> kitchens,
      int activeIndex,
      TextEditingController? kitchenController,
      KitchenModel? foodKitchen});
}

/// @nodoc
class __$$EditFoodKitchensStateImplCopyWithImpl<$Res>
    extends _$EditFoodKitchensStateCopyWithImpl<$Res,
        _$EditFoodKitchensStateImpl>
    implements _$$EditFoodKitchensStateImplCopyWith<$Res> {
  __$$EditFoodKitchensStateImplCopyWithImpl(_$EditFoodKitchensStateImpl _value,
      $Res Function(_$EditFoodKitchensStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? kitchens = null,
    Object? activeIndex = null,
    Object? kitchenController = freezed,
    Object? foodKitchen = freezed,
  }) {
    return _then(_$EditFoodKitchensStateImpl(
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
      foodKitchen: freezed == foodKitchen
          ? _value.foodKitchen
          : foodKitchen // ignore: cast_nullable_to_non_nullable
              as KitchenModel?,
    ));
  }
}

/// @nodoc

class _$EditFoodKitchensStateImpl extends _EditFoodKitchensState {
  const _$EditFoodKitchensStateImpl(
      {this.isLoading = false,
      final List<KitchenModel> kitchens = const [],
      this.activeIndex = 0,
      this.kitchenController,
      this.foodKitchen})
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
  final KitchenModel? foodKitchen;

  @override
  String toString() {
    return 'EditFoodKitchensState(isLoading: $isLoading, kitchens: $kitchens, activeIndex: $activeIndex, kitchenController: $kitchenController, foodKitchen: $foodKitchen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditFoodKitchensStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._kitchens, _kitchens) &&
            (identical(other.activeIndex, activeIndex) ||
                other.activeIndex == activeIndex) &&
            (identical(other.kitchenController, kitchenController) ||
                other.kitchenController == kitchenController) &&
            (identical(other.foodKitchen, foodKitchen) ||
                other.foodKitchen == foodKitchen));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_kitchens),
      activeIndex,
      kitchenController,
      foodKitchen);

  /// Create a copy of EditFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditFoodKitchensStateImplCopyWith<_$EditFoodKitchensStateImpl>
      get copyWith => __$$EditFoodKitchensStateImplCopyWithImpl<
          _$EditFoodKitchensStateImpl>(this, _$identity);
}

abstract class _EditFoodKitchensState extends EditFoodKitchensState {
  const factory _EditFoodKitchensState(
      {final bool isLoading,
      final List<KitchenModel> kitchens,
      final int activeIndex,
      final TextEditingController? kitchenController,
      final KitchenModel? foodKitchen}) = _$EditFoodKitchensStateImpl;
  const _EditFoodKitchensState._() : super._();

  @override
  bool get isLoading;
  @override
  List<KitchenModel> get kitchens;
  @override
  int get activeIndex;
  @override
  TextEditingController? get kitchenController;
  @override
  KitchenModel? get foodKitchen;

  /// Create a copy of EditFoodKitchensState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditFoodKitchensStateImplCopyWith<_$EditFoodKitchensStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
