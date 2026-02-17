// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_address_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderAddressState {
  TextEditingController? get textController =>
      throw _privateConstructorUsedError;
  LocationData? get location => throw _privateConstructorUsedError;
  String get entrance => throw _privateConstructorUsedError;
  String get floor => throw _privateConstructorUsedError;
  String get house => throw _privateConstructorUsedError;

  /// Create a copy of OrderAddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderAddressStateCopyWith<OrderAddressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderAddressStateCopyWith<$Res> {
  factory $OrderAddressStateCopyWith(
          OrderAddressState value, $Res Function(OrderAddressState) then) =
      _$OrderAddressStateCopyWithImpl<$Res, OrderAddressState>;
  @useResult
  $Res call(
      {TextEditingController? textController,
      LocationData? location,
      String entrance,
      String floor,
      String house});
}

/// @nodoc
class _$OrderAddressStateCopyWithImpl<$Res, $Val extends OrderAddressState>
    implements $OrderAddressStateCopyWith<$Res> {
  _$OrderAddressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderAddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textController = freezed,
    Object? location = freezed,
    Object? entrance = null,
    Object? floor = null,
    Object? house = null,
  }) {
    return _then(_value.copyWith(
      textController: freezed == textController
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationData?,
      entrance: null == entrance
          ? _value.entrance
          : entrance // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      house: null == house
          ? _value.house
          : house // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderAddressStateImplCopyWith<$Res>
    implements $OrderAddressStateCopyWith<$Res> {
  factory _$$OrderAddressStateImplCopyWith(_$OrderAddressStateImpl value,
          $Res Function(_$OrderAddressStateImpl) then) =
      __$$OrderAddressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController? textController,
      LocationData? location,
      String entrance,
      String floor,
      String house});
}

/// @nodoc
class __$$OrderAddressStateImplCopyWithImpl<$Res>
    extends _$OrderAddressStateCopyWithImpl<$Res, _$OrderAddressStateImpl>
    implements _$$OrderAddressStateImplCopyWith<$Res> {
  __$$OrderAddressStateImplCopyWithImpl(_$OrderAddressStateImpl _value,
      $Res Function(_$OrderAddressStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderAddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textController = freezed,
    Object? location = freezed,
    Object? entrance = null,
    Object? floor = null,
    Object? house = null,
  }) {
    return _then(_$OrderAddressStateImpl(
      textController: freezed == textController
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationData?,
      entrance: null == entrance
          ? _value.entrance
          : entrance // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      house: null == house
          ? _value.house
          : house // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OrderAddressStateImpl extends _OrderAddressState {
  const _$OrderAddressStateImpl(
      {this.textController,
      this.location,
      this.entrance = '',
      this.floor = '',
      this.house = ''})
      : super._();

  @override
  final TextEditingController? textController;
  @override
  final LocationData? location;
  @override
  @JsonKey()
  final String entrance;
  @override
  @JsonKey()
  final String floor;
  @override
  @JsonKey()
  final String house;

  @override
  String toString() {
    return 'OrderAddressState(textController: $textController, location: $location, entrance: $entrance, floor: $floor, house: $house)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderAddressStateImpl &&
            (identical(other.textController, textController) ||
                other.textController == textController) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.entrance, entrance) ||
                other.entrance == entrance) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.house, house) || other.house == house));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, textController, location, entrance, floor, house);

  /// Create a copy of OrderAddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderAddressStateImplCopyWith<_$OrderAddressStateImpl> get copyWith =>
      __$$OrderAddressStateImplCopyWithImpl<_$OrderAddressStateImpl>(
          this, _$identity);
}

abstract class _OrderAddressState extends OrderAddressState {
  const factory _OrderAddressState(
      {final TextEditingController? textController,
      final LocationData? location,
      final String entrance,
      final String floor,
      final String house}) = _$OrderAddressStateImpl;
  const _OrderAddressState._() : super._();

  @override
  TextEditingController? get textController;
  @override
  LocationData? get location;
  @override
  String get entrance;
  @override
  String get floor;
  @override
  String get house;

  /// Create a copy of OrderAddressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderAddressStateImplCopyWith<_$OrderAddressStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
