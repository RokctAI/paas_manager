// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'foods_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FoodsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<ProductData> get foods => throw _privateConstructorUsedError;

  /// Create a copy of FoodsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodsStateCopyWith<FoodsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodsStateCopyWith<$Res> {
  factory $FoodsStateCopyWith(
          FoodsState value, $Res Function(FoodsState) then) =
      _$FoodsStateCopyWithImpl<$Res, FoodsState>;
  @useResult
  $Res call({bool isLoading, List<ProductData> foods});
}

/// @nodoc
class _$FoodsStateCopyWithImpl<$Res, $Val extends FoodsState>
    implements $FoodsStateCopyWith<$Res> {
  _$FoodsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? foods = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      foods: null == foods
          ? _value.foods
          : foods // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodsStateImplCopyWith<$Res>
    implements $FoodsStateCopyWith<$Res> {
  factory _$$FoodsStateImplCopyWith(
          _$FoodsStateImpl value, $Res Function(_$FoodsStateImpl) then) =
      __$$FoodsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<ProductData> foods});
}

/// @nodoc
class __$$FoodsStateImplCopyWithImpl<$Res>
    extends _$FoodsStateCopyWithImpl<$Res, _$FoodsStateImpl>
    implements _$$FoodsStateImplCopyWith<$Res> {
  __$$FoodsStateImplCopyWithImpl(
      _$FoodsStateImpl _value, $Res Function(_$FoodsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? foods = null,
  }) {
    return _then(_$FoodsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      foods: null == foods
          ? _value._foods
          : foods // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ));
  }
}

/// @nodoc

class _$FoodsStateImpl extends _FoodsState {
  const _$FoodsStateImpl(
      {this.isLoading = false, final List<ProductData> foods = const []})
      : _foods = foods,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<ProductData> _foods;
  @override
  @JsonKey()
  List<ProductData> get foods {
    if (_foods is EqualUnmodifiableListView) return _foods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foods);
  }

  @override
  String toString() {
    return 'FoodsState(isLoading: $isLoading, foods: $foods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._foods, _foods));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_foods));

  /// Create a copy of FoodsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodsStateImplCopyWith<_$FoodsStateImpl> get copyWith =>
      __$$FoodsStateImplCopyWithImpl<_$FoodsStateImpl>(this, _$identity);
}

abstract class _FoodsState extends FoodsState {
  const factory _FoodsState(
      {final bool isLoading, final List<ProductData> foods}) = _$FoodsStateImpl;
  const _FoodsState._() : super._();

  @override
  bool get isLoading;
  @override
  List<ProductData> get foods;

  /// Create a copy of FoodsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodsStateImplCopyWith<_$FoodsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
