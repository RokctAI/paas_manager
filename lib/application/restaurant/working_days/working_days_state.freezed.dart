// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'working_days_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkingDaysState {
  bool get isLoading => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  List<ShopWorkingDays> get workingDays => throw _privateConstructorUsedError;

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkingDaysStateCopyWith<WorkingDaysState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkingDaysStateCopyWith<$Res> {
  factory $WorkingDaysStateCopyWith(
          WorkingDaysState value, $Res Function(WorkingDaysState) then) =
      _$WorkingDaysStateCopyWithImpl<$Res, WorkingDaysState>;
  @useResult
  $Res call(
      {bool isLoading, int currentIndex, List<ShopWorkingDays> workingDays});
}

/// @nodoc
class _$WorkingDaysStateCopyWithImpl<$Res, $Val extends WorkingDaysState>
    implements $WorkingDaysStateCopyWith<$Res> {
  _$WorkingDaysStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentIndex = null,
    Object? workingDays = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      workingDays: null == workingDays
          ? _value.workingDays
          : workingDays // ignore: cast_nullable_to_non_nullable
              as List<ShopWorkingDays>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkingDaysStateImplCopyWith<$Res>
    implements $WorkingDaysStateCopyWith<$Res> {
  factory _$$WorkingDaysStateImplCopyWith(_$WorkingDaysStateImpl value,
          $Res Function(_$WorkingDaysStateImpl) then) =
      __$$WorkingDaysStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading, int currentIndex, List<ShopWorkingDays> workingDays});
}

/// @nodoc
class __$$WorkingDaysStateImplCopyWithImpl<$Res>
    extends _$WorkingDaysStateCopyWithImpl<$Res, _$WorkingDaysStateImpl>
    implements _$$WorkingDaysStateImplCopyWith<$Res> {
  __$$WorkingDaysStateImplCopyWithImpl(_$WorkingDaysStateImpl _value,
      $Res Function(_$WorkingDaysStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentIndex = null,
    Object? workingDays = null,
  }) {
    return _then(_$WorkingDaysStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      workingDays: null == workingDays
          ? _value._workingDays
          : workingDays // ignore: cast_nullable_to_non_nullable
              as List<ShopWorkingDays>,
    ));
  }
}

/// @nodoc

class _$WorkingDaysStateImpl extends _WorkingDaysState {
  const _$WorkingDaysStateImpl(
      {this.isLoading = false,
      this.currentIndex = 0,
      final List<ShopWorkingDays> workingDays = const []})
      : _workingDays = workingDays,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final int currentIndex;
  final List<ShopWorkingDays> _workingDays;
  @override
  @JsonKey()
  List<ShopWorkingDays> get workingDays {
    if (_workingDays is EqualUnmodifiableListView) return _workingDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workingDays);
  }

  @override
  String toString() {
    return 'WorkingDaysState(isLoading: $isLoading, currentIndex: $currentIndex, workingDays: $workingDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkingDaysStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            const DeepCollectionEquality()
                .equals(other._workingDays, _workingDays));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, currentIndex,
      const DeepCollectionEquality().hash(_workingDays));

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkingDaysStateImplCopyWith<_$WorkingDaysStateImpl> get copyWith =>
      __$$WorkingDaysStateImplCopyWithImpl<_$WorkingDaysStateImpl>(
          this, _$identity);
}

abstract class _WorkingDaysState extends WorkingDaysState {
  const factory _WorkingDaysState(
      {final bool isLoading,
      final int currentIndex,
      final List<ShopWorkingDays> workingDays}) = _$WorkingDaysStateImpl;
  const _WorkingDaysState._() : super._();

  @override
  bool get isLoading;
  @override
  int get currentIndex;
  @override
  List<ShopWorkingDays> get workingDays;

  /// Create a copy of WorkingDaysState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkingDaysStateImplCopyWith<_$WorkingDaysStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
