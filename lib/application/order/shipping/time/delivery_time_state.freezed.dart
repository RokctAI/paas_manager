// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_time_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeliveryTimeState {
  String get deliveryDate => throw _privateConstructorUsedError;

  /// Create a copy of DeliveryTimeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryTimeStateCopyWith<DeliveryTimeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryTimeStateCopyWith<$Res> {
  factory $DeliveryTimeStateCopyWith(
          DeliveryTimeState value, $Res Function(DeliveryTimeState) then) =
      _$DeliveryTimeStateCopyWithImpl<$Res, DeliveryTimeState>;
  @useResult
  $Res call({String deliveryDate});
}

/// @nodoc
class _$DeliveryTimeStateCopyWithImpl<$Res, $Val extends DeliveryTimeState>
    implements $DeliveryTimeStateCopyWith<$Res> {
  _$DeliveryTimeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryTimeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deliveryDate = null,
  }) {
    return _then(_value.copyWith(
      deliveryDate: null == deliveryDate
          ? _value.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeliveryTimeStateImplCopyWith<$Res>
    implements $DeliveryTimeStateCopyWith<$Res> {
  factory _$$DeliveryTimeStateImplCopyWith(_$DeliveryTimeStateImpl value,
          $Res Function(_$DeliveryTimeStateImpl) then) =
      __$$DeliveryTimeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String deliveryDate});
}

/// @nodoc
class __$$DeliveryTimeStateImplCopyWithImpl<$Res>
    extends _$DeliveryTimeStateCopyWithImpl<$Res, _$DeliveryTimeStateImpl>
    implements _$$DeliveryTimeStateImplCopyWith<$Res> {
  __$$DeliveryTimeStateImplCopyWithImpl(_$DeliveryTimeStateImpl _value,
      $Res Function(_$DeliveryTimeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliveryTimeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deliveryDate = null,
  }) {
    return _then(_$DeliveryTimeStateImpl(
      deliveryDate: null == deliveryDate
          ? _value.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeliveryTimeStateImpl extends _DeliveryTimeState {
  const _$DeliveryTimeStateImpl({this.deliveryDate = ''}) : super._();

  @override
  @JsonKey()
  final String deliveryDate;

  @override
  String toString() {
    return 'DeliveryTimeState(deliveryDate: $deliveryDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryTimeStateImpl &&
            (identical(other.deliveryDate, deliveryDate) ||
                other.deliveryDate == deliveryDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, deliveryDate);

  /// Create a copy of DeliveryTimeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryTimeStateImplCopyWith<_$DeliveryTimeStateImpl> get copyWith =>
      __$$DeliveryTimeStateImplCopyWithImpl<_$DeliveryTimeStateImpl>(
          this, _$identity);
}

abstract class _DeliveryTimeState extends DeliveryTimeState {
  const factory _DeliveryTimeState({final String deliveryDate}) =
      _$DeliveryTimeStateImpl;
  const _DeliveryTimeState._() : super._();

  @override
  String get deliveryDate;

  /// Create a copy of DeliveryTimeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryTimeStateImplCopyWith<_$DeliveryTimeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
