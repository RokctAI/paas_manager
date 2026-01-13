// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extras_group_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExtrasGroupDetailsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Extras> get extras => throw _privateConstructorUsedError;

  /// Create a copy of ExtrasGroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExtrasGroupDetailsStateCopyWith<ExtrasGroupDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtrasGroupDetailsStateCopyWith<$Res> {
  factory $ExtrasGroupDetailsStateCopyWith(ExtrasGroupDetailsState value,
          $Res Function(ExtrasGroupDetailsState) then) =
      _$ExtrasGroupDetailsStateCopyWithImpl<$Res, ExtrasGroupDetailsState>;
  @useResult
  $Res call({bool isLoading, List<Extras> extras});
}

/// @nodoc
class _$ExtrasGroupDetailsStateCopyWithImpl<$Res,
        $Val extends ExtrasGroupDetailsState>
    implements $ExtrasGroupDetailsStateCopyWith<$Res> {
  _$ExtrasGroupDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtrasGroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? extras = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      extras: null == extras
          ? _value.extras
          : extras // ignore: cast_nullable_to_non_nullable
              as List<Extras>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtrasGroupDetailsStateImplCopyWith<$Res>
    implements $ExtrasGroupDetailsStateCopyWith<$Res> {
  factory _$$ExtrasGroupDetailsStateImplCopyWith(
          _$ExtrasGroupDetailsStateImpl value,
          $Res Function(_$ExtrasGroupDetailsStateImpl) then) =
      __$$ExtrasGroupDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<Extras> extras});
}

/// @nodoc
class __$$ExtrasGroupDetailsStateImplCopyWithImpl<$Res>
    extends _$ExtrasGroupDetailsStateCopyWithImpl<$Res,
        _$ExtrasGroupDetailsStateImpl>
    implements _$$ExtrasGroupDetailsStateImplCopyWith<$Res> {
  __$$ExtrasGroupDetailsStateImplCopyWithImpl(
      _$ExtrasGroupDetailsStateImpl _value,
      $Res Function(_$ExtrasGroupDetailsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtrasGroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? extras = null,
  }) {
    return _then(_$ExtrasGroupDetailsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      extras: null == extras
          ? _value._extras
          : extras // ignore: cast_nullable_to_non_nullable
              as List<Extras>,
    ));
  }
}

/// @nodoc

class _$ExtrasGroupDetailsStateImpl extends _ExtrasGroupDetailsState {
  const _$ExtrasGroupDetailsStateImpl(
      {this.isLoading = false, final List<Extras> extras = const []})
      : _extras = extras,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<Extras> _extras;
  @override
  @JsonKey()
  List<Extras> get extras {
    if (_extras is EqualUnmodifiableListView) return _extras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_extras);
  }

  @override
  String toString() {
    return 'ExtrasGroupDetailsState(isLoading: $isLoading, extras: $extras)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtrasGroupDetailsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._extras, _extras));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_extras));

  /// Create a copy of ExtrasGroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtrasGroupDetailsStateImplCopyWith<_$ExtrasGroupDetailsStateImpl>
      get copyWith => __$$ExtrasGroupDetailsStateImplCopyWithImpl<
          _$ExtrasGroupDetailsStateImpl>(this, _$identity);
}

abstract class _ExtrasGroupDetailsState extends ExtrasGroupDetailsState {
  const factory _ExtrasGroupDetailsState(
      {final bool isLoading,
      final List<Extras> extras}) = _$ExtrasGroupDetailsStateImpl;
  const _ExtrasGroupDetailsState._() : super._();

  @override
  bool get isLoading;
  @override
  List<Extras> get extras;

  /// Create a copy of ExtrasGroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtrasGroupDetailsStateImplCopyWith<_$ExtrasGroupDetailsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
