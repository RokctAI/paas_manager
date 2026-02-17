// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_units_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditFoodUnitsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<UnitData> get units => throw _privateConstructorUsedError;
  int get activeIndex => throw _privateConstructorUsedError;
  TextEditingController? get unitController =>
      throw _privateConstructorUsedError;
  UnitData? get foodUnit => throw _privateConstructorUsedError;

  /// Create a copy of EditFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditFoodUnitsStateCopyWith<EditFoodUnitsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditFoodUnitsStateCopyWith<$Res> {
  factory $EditFoodUnitsStateCopyWith(
          EditFoodUnitsState value, $Res Function(EditFoodUnitsState) then) =
      _$EditFoodUnitsStateCopyWithImpl<$Res, EditFoodUnitsState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<UnitData> units,
      int activeIndex,
      TextEditingController? unitController,
      UnitData? foodUnit});
}

/// @nodoc
class _$EditFoodUnitsStateCopyWithImpl<$Res, $Val extends EditFoodUnitsState>
    implements $EditFoodUnitsStateCopyWith<$Res> {
  _$EditFoodUnitsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? units = null,
    Object? activeIndex = null,
    Object? unitController = freezed,
    Object? foodUnit = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<UnitData>,
      activeIndex: null == activeIndex
          ? _value.activeIndex
          : activeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      unitController: freezed == unitController
          ? _value.unitController
          : unitController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      foodUnit: freezed == foodUnit
          ? _value.foodUnit
          : foodUnit // ignore: cast_nullable_to_non_nullable
              as UnitData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditFoodUnitsStateImplCopyWith<$Res>
    implements $EditFoodUnitsStateCopyWith<$Res> {
  factory _$$EditFoodUnitsStateImplCopyWith(_$EditFoodUnitsStateImpl value,
          $Res Function(_$EditFoodUnitsStateImpl) then) =
      __$$EditFoodUnitsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<UnitData> units,
      int activeIndex,
      TextEditingController? unitController,
      UnitData? foodUnit});
}

/// @nodoc
class __$$EditFoodUnitsStateImplCopyWithImpl<$Res>
    extends _$EditFoodUnitsStateCopyWithImpl<$Res, _$EditFoodUnitsStateImpl>
    implements _$$EditFoodUnitsStateImplCopyWith<$Res> {
  __$$EditFoodUnitsStateImplCopyWithImpl(_$EditFoodUnitsStateImpl _value,
      $Res Function(_$EditFoodUnitsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? units = null,
    Object? activeIndex = null,
    Object? unitController = freezed,
    Object? foodUnit = freezed,
  }) {
    return _then(_$EditFoodUnitsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      units: null == units
          ? _value._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<UnitData>,
      activeIndex: null == activeIndex
          ? _value.activeIndex
          : activeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      unitController: freezed == unitController
          ? _value.unitController
          : unitController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      foodUnit: freezed == foodUnit
          ? _value.foodUnit
          : foodUnit // ignore: cast_nullable_to_non_nullable
              as UnitData?,
    ));
  }
}

/// @nodoc

class _$EditFoodUnitsStateImpl extends _EditFoodUnitsState {
  const _$EditFoodUnitsStateImpl(
      {this.isLoading = false,
      final List<UnitData> units = const [],
      this.activeIndex = 0,
      this.unitController,
      this.foodUnit})
      : _units = units,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<UnitData> _units;
  @override
  @JsonKey()
  List<UnitData> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  @override
  @JsonKey()
  final int activeIndex;
  @override
  final TextEditingController? unitController;
  @override
  final UnitData? foodUnit;

  @override
  String toString() {
    return 'EditFoodUnitsState(isLoading: $isLoading, units: $units, activeIndex: $activeIndex, unitController: $unitController, foodUnit: $foodUnit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditFoodUnitsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._units, _units) &&
            (identical(other.activeIndex, activeIndex) ||
                other.activeIndex == activeIndex) &&
            (identical(other.unitController, unitController) ||
                other.unitController == unitController) &&
            (identical(other.foodUnit, foodUnit) ||
                other.foodUnit == foodUnit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_units),
      activeIndex,
      unitController,
      foodUnit);

  /// Create a copy of EditFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditFoodUnitsStateImplCopyWith<_$EditFoodUnitsStateImpl> get copyWith =>
      __$$EditFoodUnitsStateImplCopyWithImpl<_$EditFoodUnitsStateImpl>(
          this, _$identity);
}

abstract class _EditFoodUnitsState extends EditFoodUnitsState {
  const factory _EditFoodUnitsState(
      {final bool isLoading,
      final List<UnitData> units,
      final int activeIndex,
      final TextEditingController? unitController,
      final UnitData? foodUnit}) = _$EditFoodUnitsStateImpl;
  const _EditFoodUnitsState._() : super._();

  @override
  bool get isLoading;
  @override
  List<UnitData> get units;
  @override
  int get activeIndex;
  @override
  TextEditingController? get unitController;
  @override
  UnitData? get foodUnit;

  /// Create a copy of EditFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditFoodUnitsStateImplCopyWith<_$EditFoodUnitsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
