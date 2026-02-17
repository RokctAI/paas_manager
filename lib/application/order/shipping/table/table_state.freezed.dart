// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TableState {

 List<TableData> get tables; int get selectedIndex; bool get isLoading; TableData? get selectTable; TextEditingController? get textController;
/// Create a copy of TableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableStateCopyWith<TableState> get copyWith => _$TableStateCopyWithImpl<TableState>(this as TableState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableState&&const DeepCollectionEquality().equals(other.tables, tables)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectTable, selectTable) || other.selectTable == selectTable)&&(identical(other.textController, textController) || other.textController == textController));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tables),selectedIndex,isLoading,selectTable,textController);

@override
String toString() {
  return 'TableState(tables: $tables, selectedIndex: $selectedIndex, isLoading: $isLoading, selectTable: $selectTable, textController: $textController)';
}


}

/// @nodoc
abstract mixin class $TableStateCopyWith<$Res>  {
  factory $TableStateCopyWith(TableState value, $Res Function(TableState) _then) = _$TableStateCopyWithImpl;
@useResult
$Res call({
 List<TableData> tables, int selectedIndex, bool isLoading, TableData? selectTable, TextEditingController? textController
});




}
/// @nodoc
class _$TableStateCopyWithImpl<$Res>
    implements $TableStateCopyWith<$Res> {
  _$TableStateCopyWithImpl(this._self, this._then);

  final TableState _self;
  final $Res Function(TableState) _then;

/// Create a copy of TableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tables = null,Object? selectedIndex = null,Object? isLoading = null,Object? selectTable = freezed,Object? textController = freezed,}) {
  return _then(_self.copyWith(
tables: null == tables ? _self.tables : tables // ignore: cast_nullable_to_non_nullable
as List<TableData>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectTable: freezed == selectTable ? _self.selectTable : selectTable // ignore: cast_nullable_to_non_nullable
as TableData?,textController: freezed == textController ? _self.textController : textController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}

}


/// Adds pattern-matching-related methods to [TableState].
extension TableStatePatterns on TableState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TableState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TableState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TableState value)  $default,){
final _that = this;
switch (_that) {
case _TableState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TableState value)?  $default,){
final _that = this;
switch (_that) {
case _TableState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TableData> tables,  int selectedIndex,  bool isLoading,  TableData? selectTable,  TextEditingController? textController)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TableState() when $default != null:
return $default(_that.tables,_that.selectedIndex,_that.isLoading,_that.selectTable,_that.textController);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TableData> tables,  int selectedIndex,  bool isLoading,  TableData? selectTable,  TextEditingController? textController)  $default,) {final _that = this;
switch (_that) {
case _TableState():
return $default(_that.tables,_that.selectedIndex,_that.isLoading,_that.selectTable,_that.textController);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TableData> tables,  int selectedIndex,  bool isLoading,  TableData? selectTable,  TextEditingController? textController)?  $default,) {final _that = this;
switch (_that) {
case _TableState() when $default != null:
return $default(_that.tables,_that.selectedIndex,_that.isLoading,_that.selectTable,_that.textController);case _:
  return null;

}
}

}

/// @nodoc


class _TableState extends TableState {
  const _TableState({final  List<TableData> tables = const [], this.selectedIndex = 0, this.isLoading = false, this.selectTable, this.textController}): _tables = tables,super._();
  

 final  List<TableData> _tables;
@override@JsonKey() List<TableData> get tables {
  if (_tables is EqualUnmodifiableListView) return _tables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tables);
}

@override@JsonKey() final  int selectedIndex;
@override@JsonKey() final  bool isLoading;
@override final  TableData? selectTable;
@override final  TextEditingController? textController;

/// Create a copy of TableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableStateCopyWith<_TableState> get copyWith => __$TableStateCopyWithImpl<_TableState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TableState&&const DeepCollectionEquality().equals(other._tables, _tables)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectTable, selectTable) || other.selectTable == selectTable)&&(identical(other.textController, textController) || other.textController == textController));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tables),selectedIndex,isLoading,selectTable,textController);

@override
String toString() {
  return 'TableState(tables: $tables, selectedIndex: $selectedIndex, isLoading: $isLoading, selectTable: $selectTable, textController: $textController)';
}


}

/// @nodoc
abstract mixin class _$TableStateCopyWith<$Res> implements $TableStateCopyWith<$Res> {
  factory _$TableStateCopyWith(_TableState value, $Res Function(_TableState) _then) = __$TableStateCopyWithImpl;
@override @useResult
$Res call({
 List<TableData> tables, int selectedIndex, bool isLoading, TableData? selectTable, TextEditingController? textController
});




}
/// @nodoc
class __$TableStateCopyWithImpl<$Res>
    implements _$TableStateCopyWith<$Res> {
  __$TableStateCopyWithImpl(this._self, this._then);

  final _TableState _self;
  final $Res Function(_TableState) _then;

/// Create a copy of TableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tables = null,Object? selectedIndex = null,Object? isLoading = null,Object? selectTable = freezed,Object? textController = freezed,}) {
  return _then(_TableState(
tables: null == tables ? _self._tables : tables // ignore: cast_nullable_to_non_nullable
as List<TableData>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectTable: freezed == selectTable ? _self.selectTable : selectTable // ignore: cast_nullable_to_non_nullable
as TableData?,textController: freezed == textController ? _self.textController : textController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}


}

// dart format on
