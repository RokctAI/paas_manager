// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_extras_group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeleteExtrasGroupState {
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of DeleteExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteExtrasGroupStateCopyWith<DeleteExtrasGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteExtrasGroupStateCopyWith<$Res> {
  factory $DeleteExtrasGroupStateCopyWith(DeleteExtrasGroupState value,
          $Res Function(DeleteExtrasGroupState) then) =
      _$DeleteExtrasGroupStateCopyWithImpl<$Res, DeleteExtrasGroupState>;
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class _$DeleteExtrasGroupStateCopyWithImpl<$Res,
        $Val extends DeleteExtrasGroupState>
    implements $DeleteExtrasGroupStateCopyWith<$Res> {
  _$DeleteExtrasGroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteExtrasGroupState
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
abstract class _$$DeleteExtrasGroupStateImplCopyWith<$Res>
    implements $DeleteExtrasGroupStateCopyWith<$Res> {
  factory _$$DeleteExtrasGroupStateImplCopyWith(
          _$DeleteExtrasGroupStateImpl value,
          $Res Function(_$DeleteExtrasGroupStateImpl) then) =
      __$$DeleteExtrasGroupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class __$$DeleteExtrasGroupStateImplCopyWithImpl<$Res>
    extends _$DeleteExtrasGroupStateCopyWithImpl<$Res,
        _$DeleteExtrasGroupStateImpl>
    implements _$$DeleteExtrasGroupStateImplCopyWith<$Res> {
  __$$DeleteExtrasGroupStateImplCopyWithImpl(
      _$DeleteExtrasGroupStateImpl _value,
      $Res Function(_$DeleteExtrasGroupStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeleteExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_$DeleteExtrasGroupStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DeleteExtrasGroupStateImpl extends _DeleteExtrasGroupState {
  const _$DeleteExtrasGroupStateImpl({this.isLoading = false}) : super._();

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'DeleteExtrasGroupState(isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteExtrasGroupStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  /// Create a copy of DeleteExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteExtrasGroupStateImplCopyWith<_$DeleteExtrasGroupStateImpl>
      get copyWith => __$$DeleteExtrasGroupStateImplCopyWithImpl<
          _$DeleteExtrasGroupStateImpl>(this, _$identity);
}

abstract class _DeleteExtrasGroupState extends DeleteExtrasGroupState {
  const factory _DeleteExtrasGroupState({final bool isLoading}) =
      _$DeleteExtrasGroupStateImpl;
  const _DeleteExtrasGroupState._() : super._();

  @override
  bool get isLoading;

  /// Create a copy of DeleteExtrasGroupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteExtrasGroupStateImplCopyWith<_$DeleteExtrasGroupStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
