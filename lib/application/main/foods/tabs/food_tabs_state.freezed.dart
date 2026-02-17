// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_tabs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FoodTabsState {
  int get selectedIndex => throw _privateConstructorUsedError;

  /// Create a copy of FoodTabsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodTabsStateCopyWith<FoodTabsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodTabsStateCopyWith<$Res> {
  factory $FoodTabsStateCopyWith(
          FoodTabsState value, $Res Function(FoodTabsState) then) =
      _$FoodTabsStateCopyWithImpl<$Res, FoodTabsState>;
  @useResult
  $Res call({int selectedIndex});
}

/// @nodoc
class _$FoodTabsStateCopyWithImpl<$Res, $Val extends FoodTabsState>
    implements $FoodTabsStateCopyWith<$Res> {
  _$FoodTabsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodTabsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
  }) {
    return _then(_value.copyWith(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodTabsStateImplCopyWith<$Res>
    implements $FoodTabsStateCopyWith<$Res> {
  factory _$$FoodTabsStateImplCopyWith(
          _$FoodTabsStateImpl value, $Res Function(_$FoodTabsStateImpl) then) =
      __$$FoodTabsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedIndex});
}

/// @nodoc
class __$$FoodTabsStateImplCopyWithImpl<$Res>
    extends _$FoodTabsStateCopyWithImpl<$Res, _$FoodTabsStateImpl>
    implements _$$FoodTabsStateImplCopyWith<$Res> {
  __$$FoodTabsStateImplCopyWithImpl(
      _$FoodTabsStateImpl _value, $Res Function(_$FoodTabsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodTabsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
  }) {
    return _then(_$FoodTabsStateImpl(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FoodTabsStateImpl extends _FoodTabsState {
  const _$FoodTabsStateImpl({this.selectedIndex = 0}) : super._();

  @override
  @JsonKey()
  final int selectedIndex;

  @override
  String toString() {
    return 'FoodTabsState(selectedIndex: $selectedIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodTabsStateImpl &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIndex);

  /// Create a copy of FoodTabsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodTabsStateImplCopyWith<_$FoodTabsStateImpl> get copyWith =>
      __$$FoodTabsStateImplCopyWithImpl<_$FoodTabsStateImpl>(this, _$identity);
}

abstract class _FoodTabsState extends FoodTabsState {
  const factory _FoodTabsState({final int selectedIndex}) = _$FoodTabsStateImpl;
  const _FoodTabsState._() : super._();

  @override
  int get selectedIndex;

  /// Create a copy of FoodTabsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodTabsStateImplCopyWith<_$FoodTabsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
