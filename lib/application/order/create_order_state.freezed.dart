// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateOrderState {
  bool get isCreating => throw _privateConstructorUsedError;

  /// Create a copy of CreateOrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateOrderStateCopyWith<CreateOrderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateOrderStateCopyWith<$Res> {
  factory $CreateOrderStateCopyWith(
          CreateOrderState value, $Res Function(CreateOrderState) then) =
      _$CreateOrderStateCopyWithImpl<$Res, CreateOrderState>;
  @useResult
  $Res call({bool isCreating});
}

/// @nodoc
class _$CreateOrderStateCopyWithImpl<$Res, $Val extends CreateOrderState>
    implements $CreateOrderStateCopyWith<$Res> {
  _$CreateOrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateOrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCreating = null,
  }) {
    return _then(_value.copyWith(
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateOrderStateImplCopyWith<$Res>
    implements $CreateOrderStateCopyWith<$Res> {
  factory _$$CreateOrderStateImplCopyWith(_$CreateOrderStateImpl value,
          $Res Function(_$CreateOrderStateImpl) then) =
      __$$CreateOrderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isCreating});
}

/// @nodoc
class __$$CreateOrderStateImplCopyWithImpl<$Res>
    extends _$CreateOrderStateCopyWithImpl<$Res, _$CreateOrderStateImpl>
    implements _$$CreateOrderStateImplCopyWith<$Res> {
  __$$CreateOrderStateImplCopyWithImpl(_$CreateOrderStateImpl _value,
      $Res Function(_$CreateOrderStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateOrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCreating = null,
  }) {
    return _then(_$CreateOrderStateImpl(
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreateOrderStateImpl extends _CreateOrderState {
  const _$CreateOrderStateImpl({this.isCreating = false}) : super._();

  @override
  @JsonKey()
  final bool isCreating;

  @override
  String toString() {
    return 'CreateOrderState(isCreating: $isCreating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateOrderStateImpl &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCreating);

  /// Create a copy of CreateOrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateOrderStateImplCopyWith<_$CreateOrderStateImpl> get copyWith =>
      __$$CreateOrderStateImplCopyWithImpl<_$CreateOrderStateImpl>(
          this, _$identity);
}

abstract class _CreateOrderState extends CreateOrderState {
  const factory _CreateOrderState({final bool isCreating}) =
      _$CreateOrderStateImpl;
  const _CreateOrderState._() : super._();

  @override
  bool get isCreating;

  /// Create a copy of CreateOrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateOrderStateImplCopyWith<_$CreateOrderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
