// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_extras_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditExtrasItemState {
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of EditExtrasItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditExtrasItemStateCopyWith<EditExtrasItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditExtrasItemStateCopyWith<$Res> {
  factory $EditExtrasItemStateCopyWith(
          EditExtrasItemState value, $Res Function(EditExtrasItemState) then) =
      _$EditExtrasItemStateCopyWithImpl<$Res, EditExtrasItemState>;
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class _$EditExtrasItemStateCopyWithImpl<$Res, $Val extends EditExtrasItemState>
    implements $EditExtrasItemStateCopyWith<$Res> {
  _$EditExtrasItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditExtrasItemState
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
abstract class _$$EditExtrasItemStateImplCopyWith<$Res>
    implements $EditExtrasItemStateCopyWith<$Res> {
  factory _$$EditExtrasItemStateImplCopyWith(_$EditExtrasItemStateImpl value,
          $Res Function(_$EditExtrasItemStateImpl) then) =
      __$$EditExtrasItemStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class __$$EditExtrasItemStateImplCopyWithImpl<$Res>
    extends _$EditExtrasItemStateCopyWithImpl<$Res, _$EditExtrasItemStateImpl>
    implements _$$EditExtrasItemStateImplCopyWith<$Res> {
  __$$EditExtrasItemStateImplCopyWithImpl(_$EditExtrasItemStateImpl _value,
      $Res Function(_$EditExtrasItemStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditExtrasItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_$EditExtrasItemStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EditExtrasItemStateImpl extends _EditExtrasItemState {
  const _$EditExtrasItemStateImpl({this.isLoading = false}) : super._();

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'EditExtrasItemState(isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditExtrasItemStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  /// Create a copy of EditExtrasItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditExtrasItemStateImplCopyWith<_$EditExtrasItemStateImpl> get copyWith =>
      __$$EditExtrasItemStateImplCopyWithImpl<_$EditExtrasItemStateImpl>(
          this, _$identity);
}

abstract class _EditExtrasItemState extends EditExtrasItemState {
  const factory _EditExtrasItemState({final bool isLoading}) =
      _$EditExtrasItemStateImpl;
  const _EditExtrasItemState._() : super._();

  @override
  bool get isLoading;

  /// Create a copy of EditExtrasItemState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditExtrasItemStateImplCopyWith<_$EditExtrasItemStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
