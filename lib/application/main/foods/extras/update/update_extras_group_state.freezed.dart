// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_extras_group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateExtrasGroupState {
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of UpdateExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateExtrasGroupStateCopyWith<UpdateExtrasGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateExtrasGroupStateCopyWith<$Res> {
  factory $UpdateExtrasGroupStateCopyWith(UpdateExtrasGroupState value,
          $Res Function(UpdateExtrasGroupState) then) =
      _$UpdateExtrasGroupStateCopyWithImpl<$Res, UpdateExtrasGroupState>;
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class _$UpdateExtrasGroupStateCopyWithImpl<$Res,
        $Val extends UpdateExtrasGroupState>
    implements $UpdateExtrasGroupStateCopyWith<$Res> {
  _$UpdateExtrasGroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateExtrasGroupStateImplCopyWith<$Res>
    implements $UpdateExtrasGroupStateCopyWith<$Res> {
  factory _$$UpdateExtrasGroupStateImplCopyWith(
          _$UpdateExtrasGroupStateImpl value,
          $Res Function(_$UpdateExtrasGroupStateImpl) then) =
      __$$UpdateExtrasGroupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class __$$UpdateExtrasGroupStateImplCopyWithImpl<$Res>
    extends _$UpdateExtrasGroupStateCopyWithImpl<$Res,
        _$UpdateExtrasGroupStateImpl>
    implements _$$UpdateExtrasGroupStateImplCopyWith<$Res> {
  __$$UpdateExtrasGroupStateImplCopyWithImpl(
      _$UpdateExtrasGroupStateImpl _value,
      $Res Function(_$UpdateExtrasGroupStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_$UpdateExtrasGroupStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UpdateExtrasGroupStateImpl extends _UpdateExtrasGroupState {
  const _$UpdateExtrasGroupStateImpl({this.isLoading = false}) : super._();

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'UpdateExtrasGroupState(isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateExtrasGroupStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  /// Create a copy of UpdateExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateExtrasGroupStateImplCopyWith<_$UpdateExtrasGroupStateImpl>
      get copyWith => __$$UpdateExtrasGroupStateImplCopyWithImpl<
          _$UpdateExtrasGroupStateImpl>(this, _$identity);
}

abstract class _UpdateExtrasGroupState extends UpdateExtrasGroupState {
  const factory _UpdateExtrasGroupState({final bool isLoading}) =
      _$UpdateExtrasGroupStateImpl;
  const _UpdateExtrasGroupState._() : super._();

  @override
  bool get isLoading;

  /// Create a copy of UpdateExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateExtrasGroupStateImplCopyWith<_$UpdateExtrasGroupStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
