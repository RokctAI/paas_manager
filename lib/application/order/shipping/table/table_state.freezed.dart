// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TableState {
  List<TableData> get tables => throw _privateConstructorUsedError;
  int get selectedIndex => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  TableData? get selectTable => throw _privateConstructorUsedError;
  TextEditingController? get textController =>
      throw _privateConstructorUsedError;

  /// Create a copy of TableState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableStateCopyWith<TableState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableStateCopyWith<$Res> {
  factory $TableStateCopyWith(
          TableState value, $Res Function(TableState) then) =
      _$TableStateCopyWithImpl<$Res, TableState>;
  @useResult
  $Res call(
      {List<TableData> tables,
      int selectedIndex,
      bool isLoading,
      TableData? selectTable,
      TextEditingController? textController});
}

/// @nodoc
class _$TableStateCopyWithImpl<$Res, $Val extends TableState>
    implements $TableStateCopyWith<$Res> {
  _$TableStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tables = null,
    Object? selectedIndex = null,
    Object? isLoading = null,
    Object? selectTable = freezed,
    Object? textController = freezed,
  }) {
    return _then(_value.copyWith(
      tables: null == tables
          ? _value.tables
          : tables // ignore: cast_nullable_to_non_nullable
              as List<TableData>,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectTable: freezed == selectTable
          ? _value.selectTable
          : selectTable // ignore: cast_nullable_to_non_nullable
              as TableData?,
      textController: freezed == textController
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TableStateImplCopyWith<$Res>
    implements $TableStateCopyWith<$Res> {
  factory _$$TableStateImplCopyWith(
          _$TableStateImpl value, $Res Function(_$TableStateImpl) then) =
      __$$TableStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TableData> tables,
      int selectedIndex,
      bool isLoading,
      TableData? selectTable,
      TextEditingController? textController});
}

/// @nodoc
class __$$TableStateImplCopyWithImpl<$Res>
    extends _$TableStateCopyWithImpl<$Res, _$TableStateImpl>
    implements _$$TableStateImplCopyWith<$Res> {
  __$$TableStateImplCopyWithImpl(
      _$TableStateImpl _value, $Res Function(_$TableStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TableState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tables = null,
    Object? selectedIndex = null,
    Object? isLoading = null,
    Object? selectTable = freezed,
    Object? textController = freezed,
  }) {
    return _then(_$TableStateImpl(
      tables: null == tables
          ? _value._tables
          : tables // ignore: cast_nullable_to_non_nullable
              as List<TableData>,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      selectTable: freezed == selectTable
          ? _value.selectTable
          : selectTable // ignore: cast_nullable_to_non_nullable
              as TableData?,
      textController: freezed == textController
          ? _value.textController
          : textController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
    ));
  }
}

/// @nodoc

class _$TableStateImpl extends _TableState {
  const _$TableStateImpl(
      {final List<TableData> tables = const [],
      this.selectedIndex = 0,
      this.isLoading = false,
      this.selectTable,
      this.textController})
      : _tables = tables,
        super._();

  final List<TableData> _tables;
  @override
  @JsonKey()
  List<TableData> get tables {
    if (_tables is EqualUnmodifiableListView) return _tables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tables);
  }

  @override
  @JsonKey()
  final int selectedIndex;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final TableData? selectTable;
  @override
  final TextEditingController? textController;

  @override
  String toString() {
    return 'TableState(tables: $tables, selectedIndex: $selectedIndex, isLoading: $isLoading, selectTable: $selectTable, textController: $textController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableStateImpl &&
            const DeepCollectionEquality().equals(other._tables, _tables) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.selectTable, selectTable) ||
                other.selectTable == selectTable) &&
            (identical(other.textController, textController) ||
                other.textController == textController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tables),
      selectedIndex,
      isLoading,
      selectTable,
      textController);

  /// Create a copy of TableState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableStateImplCopyWith<_$TableStateImpl> get copyWith =>
      __$$TableStateImplCopyWithImpl<_$TableStateImpl>(this, _$identity);
}

abstract class _TableState extends TableState {
  const factory _TableState(
      {final List<TableData> tables,
      final int selectedIndex,
      final bool isLoading,
      final TableData? selectTable,
      final TextEditingController? textController}) = _$TableStateImpl;
  const _TableState._() : super._();

  @override
  List<TableData> get tables;
  @override
  int get selectedIndex;
  @override
  bool get isLoading;
  @override
  TableData? get selectTable;
  @override
  TextEditingController? get textController;

  /// Create a copy of TableState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableStateImplCopyWith<_$TableStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
