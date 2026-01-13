// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_food_units_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateFoodUnitsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<UnitData> get units => throw _privateConstructorUsedError;
  int get activeIndex => throw _privateConstructorUsedError;
  TextEditingController? get unitController =>
      throw _privateConstructorUsedError;

  /// Create a copy of CreateFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateFoodUnitsStateCopyWith<CreateFoodUnitsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateFoodUnitsStateCopyWith<$Res> {
  factory $CreateFoodUnitsStateCopyWith(CreateFoodUnitsState value,
          $Res Function(CreateFoodUnitsState) then) =
      _$CreateFoodUnitsStateCopyWithImpl<$Res, CreateFoodUnitsState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<UnitData> units,
      int activeIndex,
      TextEditingController? unitController});
}

/// @nodoc
class _$CreateFoodUnitsStateCopyWithImpl<$Res,
        $Val extends CreateFoodUnitsState>
    implements $CreateFoodUnitsStateCopyWith<$Res> {
  _$CreateFoodUnitsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? units = null,
    Object? activeIndex = null,
    Object? unitController = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateFoodUnitsStateImplCopyWith<$Res>
    implements $CreateFoodUnitsStateCopyWith<$Res> {
  factory _$$CreateFoodUnitsStateImplCopyWith(_$CreateFoodUnitsStateImpl value,
          $Res Function(_$CreateFoodUnitsStateImpl) then) =
      __$$CreateFoodUnitsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<UnitData> units,
      int activeIndex,
      TextEditingController? unitController});
}

/// @nodoc
class __$$CreateFoodUnitsStateImplCopyWithImpl<$Res>
    extends _$CreateFoodUnitsStateCopyWithImpl<$Res, _$CreateFoodUnitsStateImpl>
    implements _$$CreateFoodUnitsStateImplCopyWith<$Res> {
  __$$CreateFoodUnitsStateImplCopyWithImpl(_$CreateFoodUnitsStateImpl _value,
      $Res Function(_$CreateFoodUnitsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? units = null,
    Object? activeIndex = null,
    Object? unitController = freezed,
  }) {
    return _then(_$CreateFoodUnitsStateImpl(
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
    ));
  }
}

/// @nodoc

class _$CreateFoodUnitsStateImpl extends _CreateFoodUnitsState {
  const _$CreateFoodUnitsStateImpl(
      {this.isLoading = false,
      final List<UnitData> units = const [],
      this.activeIndex = 0,
      this.unitController})
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
  String toString() {
    return 'CreateFoodUnitsState(isLoading: $isLoading, units: $units, activeIndex: $activeIndex, unitController: $unitController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateFoodUnitsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._units, _units) &&
            (identical(other.activeIndex, activeIndex) ||
                other.activeIndex == activeIndex) &&
            (identical(other.unitController, unitController) ||
                other.unitController == unitController));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_units), activeIndex, unitController);

  /// Create a copy of CreateFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateFoodUnitsStateImplCopyWith<_$CreateFoodUnitsStateImpl>
      get copyWith =>
          __$$CreateFoodUnitsStateImplCopyWithImpl<_$CreateFoodUnitsStateImpl>(
              this, _$identity);
}

abstract class _CreateFoodUnitsState extends CreateFoodUnitsState {
  const factory _CreateFoodUnitsState(
          {final bool isLoading,
          final List<UnitData> units,
          final int activeIndex,
          final TextEditingController? unitController}) =
      _$CreateFoodUnitsStateImpl;
  const _CreateFoodUnitsState._() : super._();

  @override
  bool get isLoading;
  @override
  List<UnitData> get units;
  @override
  int get activeIndex;
  @override
  TextEditingController? get unitController;

  /// Create a copy of CreateFoodUnitsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateFoodUnitsStateImplCopyWith<_$CreateFoodUnitsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
