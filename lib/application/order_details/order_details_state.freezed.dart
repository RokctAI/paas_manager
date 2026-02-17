// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderDetailsState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isUpdating => throw _privateConstructorUsedError;
  OrderData? get order => throw _privateConstructorUsedError;

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDetailsStateCopyWith<OrderDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsStateCopyWith(
          OrderDetailsState value, $Res Function(OrderDetailsState) then) =
      _$OrderDetailsStateCopyWithImpl<$Res, OrderDetailsState>;
  @useResult
  $Res call({bool isLoading, bool isUpdating, OrderData? order});
}

/// @nodoc
class _$OrderDetailsStateCopyWithImpl<$Res, $Val extends OrderDetailsState>
    implements $OrderDetailsStateCopyWith<$Res> {
  _$OrderDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isUpdating = null,
    Object? order = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpdating: null == isUpdating
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderDetailsStateImplCopyWith<$Res>
    implements $OrderDetailsStateCopyWith<$Res> {
  factory _$$OrderDetailsStateImplCopyWith(_$OrderDetailsStateImpl value,
          $Res Function(_$OrderDetailsStateImpl) then) =
      __$$OrderDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool isUpdating, OrderData? order});
}

/// @nodoc
class __$$OrderDetailsStateImplCopyWithImpl<$Res>
    extends _$OrderDetailsStateCopyWithImpl<$Res, _$OrderDetailsStateImpl>
    implements _$$OrderDetailsStateImplCopyWith<$Res> {
  __$$OrderDetailsStateImplCopyWithImpl(_$OrderDetailsStateImpl _value,
      $Res Function(_$OrderDetailsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isUpdating = null,
    Object? order = freezed,
  }) {
    return _then(_$OrderDetailsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpdating: null == isUpdating
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderData?,
    ));
  }
}

/// @nodoc

class _$OrderDetailsStateImpl extends _OrderDetailsState {
  const _$OrderDetailsStateImpl(
      {this.isLoading = false, this.isUpdating = false, this.order})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isUpdating;
  @override
  final OrderData? order;

  @override
  String toString() {
    return 'OrderDetailsState(isLoading: $isLoading, isUpdating: $isUpdating, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUpdating, isUpdating) ||
                other.isUpdating == isUpdating) &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isUpdating, order);

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDetailsStateImplCopyWith<_$OrderDetailsStateImpl> get copyWith =>
      __$$OrderDetailsStateImplCopyWithImpl<_$OrderDetailsStateImpl>(
          this, _$identity);
}

abstract class _OrderDetailsState extends OrderDetailsState {
  const factory _OrderDetailsState(
      {final bool isLoading,
      final bool isUpdating,
      final OrderData? order}) = _$OrderDetailsStateImpl;
  const _OrderDetailsState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isUpdating;
  @override
  OrderData? get order;

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDetailsStateImplCopyWith<_$OrderDetailsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
