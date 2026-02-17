// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_addon_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditAddonState {
  bool get isLoading => throw _privateConstructorUsedError;
  Map<String, List<String>> get mapOfDesc => throw _privateConstructorUsedError;

  /// Create a copy of EditAddonState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditAddonStateCopyWith<EditAddonState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditAddonStateCopyWith<$Res> {
  factory $EditAddonStateCopyWith(
          EditAddonState value, $Res Function(EditAddonState) then) =
      _$EditAddonStateCopyWithImpl<$Res, EditAddonState>;
  @useResult
  $Res call({bool isLoading, Map<String, List<String>> mapOfDesc});
}

/// @nodoc
class _$EditAddonStateCopyWithImpl<$Res, $Val extends EditAddonState>
    implements $EditAddonStateCopyWith<$Res> {
  _$EditAddonStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditAddonState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? mapOfDesc = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      mapOfDesc: null == mapOfDesc
          ? _value.mapOfDesc
          : mapOfDesc // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditAddonStateImplCopyWith<$Res>
    implements $EditAddonStateCopyWith<$Res> {
  factory _$$EditAddonStateImplCopyWith(_$EditAddonStateImpl value,
          $Res Function(_$EditAddonStateImpl) then) =
      __$$EditAddonStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, Map<String, List<String>> mapOfDesc});
}

/// @nodoc
class __$$EditAddonStateImplCopyWithImpl<$Res>
    extends _$EditAddonStateCopyWithImpl<$Res, _$EditAddonStateImpl>
    implements _$$EditAddonStateImplCopyWith<$Res> {
  __$$EditAddonStateImplCopyWithImpl(
      _$EditAddonStateImpl _value, $Res Function(_$EditAddonStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditAddonState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? mapOfDesc = null,
  }) {
    return _then(_$EditAddonStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      mapOfDesc: null == mapOfDesc
          ? _value._mapOfDesc
          : mapOfDesc // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$EditAddonStateImpl extends _EditAddonState {
  const _$EditAddonStateImpl(
      {this.isLoading = false,
      final Map<String, List<String>> mapOfDesc = const {}})
      : _mapOfDesc = mapOfDesc,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final Map<String, List<String>> _mapOfDesc;
  @override
  @JsonKey()
  Map<String, List<String>> get mapOfDesc {
    if (_mapOfDesc is EqualUnmodifiableMapView) return _mapOfDesc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mapOfDesc);
  }

  @override
  String toString() {
    return 'EditAddonState(isLoading: $isLoading, mapOfDesc: $mapOfDesc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditAddonStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._mapOfDesc, _mapOfDesc));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_mapOfDesc));

  /// Create a copy of EditAddonState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditAddonStateImplCopyWith<_$EditAddonStateImpl> get copyWith =>
      __$$EditAddonStateImplCopyWithImpl<_$EditAddonStateImpl>(
          this, _$identity);
}

abstract class _EditAddonState extends EditAddonState {
  const factory _EditAddonState(
      {final bool isLoading,
      final Map<String, List<String>> mapOfDesc}) = _$EditAddonStateImpl;
  const _EditAddonState._() : super._();

  @override
  bool get isLoading;
  @override
  Map<String, List<String>> get mapOfDesc;

  /// Create a copy of EditAddonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditAddonStateImplCopyWith<_$EditAddonStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
