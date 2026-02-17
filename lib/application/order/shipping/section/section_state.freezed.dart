// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SectionState {
  List<ShopSection> get sections => throw _privateConstructorUsedError;
  int get selectedIndex => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  ShopSection? get selectSection => throw _privateConstructorUsedError;
  TextEditingController? get textController =>
      throw _privateConstructorUsedError;

  /// Create a copy of SectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectionStateCopyWith<SectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionStateCopyWith<$Res> {
  factory $SectionStateCopyWith(
          SectionState value, $Res Function(SectionState) then) =
      _$SectionStateCopyWithImpl<$Res, SectionState>;
  @useResult
  $Res call(
      {List<ShopSection> sections,
      int selectedIndex,
      bool isLoading,
      ShopSection? selectSection,
      TextEditingController? textController});
}

/// @nodoc
class _$SectionStateCopyWithImpl<$Res, $Val extends SectionState>
    implements $SectionStateCopyWith<$Res> {
  _$SectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
    Object? selectedIndex = null,
    Object? isLoading = null,
    Object? selectSection = freezed,
    Object? textController = freezed,
  }) {
    return _then(_value.copyWith(
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<ShopSection>,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectSection: freezed == selectSection
          ? _value.selectSection
          : selectSection // ignore: cast_nullable_to_non_nullable
              as ShopSection?,
      textController: freezed == textController
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionStateImplCopyWith<$Res>
    implements $SectionStateCopyWith<$Res> {
  factory _$$SectionStateImplCopyWith(
          _$SectionStateImpl value, $Res Function(_$SectionStateImpl) then) =
      __$$SectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ShopSection> sections,
      int selectedIndex,
      bool isLoading,
      ShopSection? selectSection,
      TextEditingController? textController});
}

/// @nodoc
class __$$SectionStateImplCopyWithImpl<$Res>
    extends _$SectionStateCopyWithImpl<$Res, _$SectionStateImpl>
    implements _$$SectionStateImplCopyWith<$Res> {
  __$$SectionStateImplCopyWithImpl(
      _$SectionStateImpl _value, $Res Function(_$SectionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sections = null,
    Object? selectedIndex = null,
    Object? isLoading = null,
    Object? selectSection = freezed,
    Object? textController = freezed,
  }) {
    return _then(_$SectionStateImpl(
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<ShopSection>,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectSection: freezed == selectSection
          ? _value.selectSection
          : selectSection // ignore: cast_nullable_to_non_nullable
              as ShopSection?,
      textController: freezed == textController
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ));
  }
}

/// @nodoc

class _$SectionStateImpl extends _SectionState {
  const _$SectionStateImpl(
      {final List<ShopSection> sections = const [],
      this.selectedIndex = 0,
      this.isLoading = false,
      this.selectSection,
      this.textController})
      : _sections = sections,
        super._();

  final List<ShopSection> _sections;
  @override
  @JsonKey()
  List<ShopSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  @JsonKey()
  final int selectedIndex;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final ShopSection? selectSection;
  @override
  final TextEditingController? textController;

  @override
  String toString() {
    return 'SectionState(sections: $sections, selectedIndex: $selectedIndex, isLoading: $isLoading, selectSection: $selectSection, textController: $textController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionStateImpl &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.selectSection, selectSection) ||
                other.selectSection == selectSection) &&
            (identical(other.textController, textController) ||
                other.textController == textController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sections),
      selectedIndex,
      isLoading,
      selectSection,
      textController);

  /// Create a copy of SectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionStateImplCopyWith<_$SectionStateImpl> get copyWith =>
      __$$SectionStateImplCopyWithImpl<_$SectionStateImpl>(this, _$identity);
}

abstract class _SectionState extends SectionState {
  const factory _SectionState(
      {final List<ShopSection> sections,
      final int selectedIndex,
      final bool isLoading,
      final ShopSection? selectSection,
      final TextEditingController? textController}) = _$SectionStateImpl;
  const _SectionState._() : super._();

  @override
  List<ShopSection> get sections;
  @override
  int get selectedIndex;
  @override
  bool get isLoading;
  @override
  ShopSection? get selectSection;
  @override
  TextEditingController? get textController;

  /// Create a copy of SectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectionStateImplCopyWith<_$SectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
