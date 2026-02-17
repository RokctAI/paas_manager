// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_addon_units_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditAddonUnitsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<UnitData> get units => throw _privateConstructorUsedError;
  int get activeIndex => throw _privateConstructorUsedError;
  TextEditingController? get unitController =>
      throw _privateConstructorUsedError;
  UnitData? get foodUnit => throw _privateConstructorUsedError;

  /// Create a copy of EditAddonUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditAddonUnitsStateCopyWith<EditAddonUnitsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditAddonUnitsStateCopyWith<$Res> {
  factory $EditAddonUnitsStateCopyWith(
          EditAddonUnitsState value, $Res Function(EditAddonUnitsState) then) =
      _$EditAddonUnitsStateCopyWithImpl<$Res, EditAddonUnitsState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<UnitData> units,
      int activeIndex,
      TextEditingController? unitController,
      UnitData? foodUnit});
}

/// @nodoc
class _$EditAddonUnitsStateCopyWithImpl<$Res, $Val extends EditAddonUnitsState>
    implements $EditAddonUnitsStateCopyWith<$Res> {
  _$EditAddonUnitsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditAddonUnitsState
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
abstract class _$$EditAddonUnitsStateImplCopyWith<$Res>
    implements $EditAddonUnitsStateCopyWith<$Res> {
  factory _$$EditAddonUnitsStateImplCopyWith(_$EditAddonUnitsStateImpl value,
          $Res Function(_$EditAddonUnitsStateImpl) then) =
      __$$EditAddonUnitsStateImplCopyWithImpl<$Res>;
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
class __$$EditAddonUnitsStateImplCopyWithImpl<$Res>
    extends _$EditAddonUnitsStateCopyWithImpl<$Res, _$EditAddonUnitsStateImpl>
    implements _$$EditAddonUnitsStateImplCopyWith<$Res> {
  __$$EditAddonUnitsStateImplCopyWithImpl(_$EditAddonUnitsStateImpl _value,
      $Res Function(_$EditAddonUnitsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditAddonUnitsState
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
    return _then(_$EditAddonUnitsStateImpl(
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

class _$EditAddonUnitsStateImpl extends _EditAddonUnitsState {
  const _$EditAddonUnitsStateImpl(
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
    return 'EditAddonUnitsState(isLoading: $isLoading, units: $units, activeIndex: $activeIndex, unitController: $unitController, foodUnit: $foodUnit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditAddonUnitsStateImpl &&
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

  /// Create a copy of EditAddonUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditAddonUnitsStateImplCopyWith<_$EditAddonUnitsStateImpl> get copyWith =>
      __$$EditAddonUnitsStateImplCopyWithImpl<_$EditAddonUnitsStateImpl>(
          this, _$identity);
}

abstract class _EditAddonUnitsState extends EditAddonUnitsState {
  const factory _EditAddonUnitsState(
      {final bool isLoading,
      final List<UnitData> units,
      final int activeIndex,
      final TextEditingController? unitController,
      final UnitData? foodUnit}) = _$EditAddonUnitsStateImpl;
  const _EditAddonUnitsState._() : super._();

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

  /// Create a copy of EditAddonUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditAddonUnitsStateImplCopyWith<_$EditAddonUnitsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
