// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RestaurantState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get backgroundImageFile => throw _privateConstructorUsedError;
  String? get logoImageFile => throw _privateConstructorUsedError;
  String? get orderPayment => throw _privateConstructorUsedError;
  ShopData? get shop => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantStateCopyWith<RestaurantState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantStateCopyWith<$Res> {
  factory $RestaurantStateCopyWith(
          RestaurantState value, $Res Function(RestaurantState) then) =
      _$RestaurantStateCopyWithImpl<$Res, RestaurantState>;
  @useResult
  $Res call(
      {bool isLoading,
      String? backgroundImageFile,
      String? logoImageFile,
      String? orderPayment,
      ShopData? shop});
}

/// @nodoc
class _$RestaurantStateCopyWithImpl<$Res, $Val extends RestaurantState>
    implements $RestaurantStateCopyWith<$Res> {
  _$RestaurantStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? backgroundImageFile = freezed,
    Object? logoImageFile = freezed,
    Object? orderPayment = freezed,
    Object? shop = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      backgroundImageFile: freezed == backgroundImageFile
          ? _value.backgroundImageFile
          : backgroundImageFile // ignore: cast_nullable_to_non_nullable
              as String?,
      logoImageFile: freezed == logoImageFile
          ? _value.logoImageFile
          : logoImageFile // ignore: cast_nullable_to_non_nullable
              as String?,
      orderPayment: freezed == orderPayment
          ? _value.orderPayment
          : orderPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      shop: freezed == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as ShopData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RestaurantStateImplCopyWith<$Res>
    implements $RestaurantStateCopyWith<$Res> {
  factory _$$RestaurantStateImplCopyWith(_$RestaurantStateImpl value,
          $Res Function(_$RestaurantStateImpl) then) =
      __$$RestaurantStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? backgroundImageFile,
      String? logoImageFile,
      String? orderPayment,
      ShopData? shop});
}

/// @nodoc
class __$$RestaurantStateImplCopyWithImpl<$Res>
    extends _$RestaurantStateCopyWithImpl<$Res, _$RestaurantStateImpl>
    implements _$$RestaurantStateImplCopyWith<$Res> {
  __$$RestaurantStateImplCopyWithImpl(
      _$RestaurantStateImpl _value, $Res Function(_$RestaurantStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RestaurantState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? backgroundImageFile = freezed,
    Object? logoImageFile = freezed,
    Object? orderPayment = freezed,
    Object? shop = freezed,
  }) {
    return _then(_$RestaurantStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      backgroundImageFile: freezed == backgroundImageFile
          ? _value.backgroundImageFile
          : backgroundImageFile // ignore: cast_nullable_to_non_nullable
              as String?,
      logoImageFile: freezed == logoImageFile
          ? _value.logoImageFile
          : logoImageFile // ignore: cast_nullable_to_non_nullable
              as String?,
      orderPayment: freezed == orderPayment
          ? _value.orderPayment
          : orderPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      shop: freezed == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as ShopData?,
    ));
  }
}

/// @nodoc

class _$RestaurantStateImpl extends _RestaurantState {
  const _$RestaurantStateImpl(
      {this.isLoading = false,
      this.backgroundImageFile,
      this.logoImageFile,
      this.orderPayment,
      this.shop})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? backgroundImageFile;
  @override
  final String? logoImageFile;
  @override
  final String? orderPayment;
  @override
  final ShopData? shop;

  @override
  String toString() {
    return 'RestaurantState(isLoading: $isLoading, backgroundImageFile: $backgroundImageFile, logoImageFile: $logoImageFile, orderPayment: $orderPayment, shop: $shop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.backgroundImageFile, backgroundImageFile) ||
                other.backgroundImageFile == backgroundImageFile) &&
            (identical(other.logoImageFile, logoImageFile) ||
                other.logoImageFile == logoImageFile) &&
            (identical(other.orderPayment, orderPayment) ||
                other.orderPayment == orderPayment) &&
            (identical(other.shop, shop) || other.shop == shop));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, backgroundImageFile,
      logoImageFile, orderPayment, shop);

  /// Create a copy of RestaurantState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantStateImplCopyWith<_$RestaurantStateImpl> get copyWith =>
      __$$RestaurantStateImplCopyWithImpl<_$RestaurantStateImpl>(
          this, _$identity);
}

abstract class _RestaurantState extends RestaurantState {
  const factory _RestaurantState(
      {final bool isLoading,
      final String? backgroundImageFile,
      final String? logoImageFile,
      final String? orderPayment,
      final ShopData? shop}) = _$RestaurantStateImpl;
  const _RestaurantState._() : super._();

  @override
  bool get isLoading;
  @override
  String? get backgroundImageFile;
  @override
  String? get logoImageFile;
  @override
  String? get orderPayment;
  @override
  ShopData? get shop;

  /// Create a copy of RestaurantState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantStateImplCopyWith<_$RestaurantStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
