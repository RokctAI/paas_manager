// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_food_stocks_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateFoodStocksState {

 bool get isLoading; bool get isSaving; bool get isFetchingGroups; List<Group> get groups; List<Stock> get stocks; List<Extras> get activeGroupExtras; Map<String, List<Extras?>> get selectGroups;
/// Create a copy of CreateFoodStocksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFoodStocksStateCopyWith<CreateFoodStocksState> get copyWith => _$CreateFoodStocksStateCopyWithImpl<CreateFoodStocksState>(this as CreateFoodStocksState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFoodStocksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isFetchingGroups, isFetchingGroups) || other.isFetchingGroups == isFetchingGroups)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.stocks, stocks)&&const DeepCollectionEquality().equals(other.activeGroupExtras, activeGroupExtras)&&const DeepCollectionEquality().equals(other.selectGroups, selectGroups));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,isFetchingGroups,const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(stocks),const DeepCollectionEquality().hash(activeGroupExtras),const DeepCollectionEquality().hash(selectGroups));

@override
String toString() {
  return 'CreateFoodStocksState(isLoading: $isLoading, isSaving: $isSaving, isFetchingGroups: $isFetchingGroups, groups: $groups, stocks: $stocks, activeGroupExtras: $activeGroupExtras, selectGroups: $selectGroups)';
}


}

/// @nodoc
abstract mixin class $CreateFoodStocksStateCopyWith<$Res>  {
  factory $CreateFoodStocksStateCopyWith(CreateFoodStocksState value, $Res Function(CreateFoodStocksState) _then) = _$CreateFoodStocksStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSaving, bool isFetchingGroups, List<Group> groups, List<Stock> stocks, List<Extras> activeGroupExtras, Map<String, List<Extras?>> selectGroups
});




}
/// @nodoc
class _$CreateFoodStocksStateCopyWithImpl<$Res>
    implements $CreateFoodStocksStateCopyWith<$Res> {
  _$CreateFoodStocksStateCopyWithImpl(this._self, this._then);

  final CreateFoodStocksState _self;
  final $Res Function(CreateFoodStocksState) _then;

/// Create a copy of CreateFoodStocksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSaving = null,Object? isFetchingGroups = null,Object? groups = null,Object? stocks = null,Object? activeGroupExtras = null,Object? selectGroups = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isFetchingGroups: null == isFetchingGroups ? _self.isFetchingGroups : isFetchingGroups // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,stocks: null == stocks ? _self.stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,activeGroupExtras: null == activeGroupExtras ? _self.activeGroupExtras : activeGroupExtras // ignore: cast_nullable_to_non_nullable
as List<Extras>,selectGroups: null == selectGroups ? _self.selectGroups : selectGroups // ignore: cast_nullable_to_non_nullable
as Map<String, List<Extras?>>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateFoodStocksState].
extension CreateFoodStocksStatePatterns on CreateFoodStocksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateFoodStocksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateFoodStocksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateFoodStocksState value)  $default,){
final _that = this;
switch (_that) {
case _CreateFoodStocksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateFoodStocksState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateFoodStocksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  bool isFetchingGroups,  List<Group> groups,  List<Stock> stocks,  List<Extras> activeGroupExtras,  Map<String, List<Extras?>> selectGroups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateFoodStocksState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.isFetchingGroups,_that.groups,_that.stocks,_that.activeGroupExtras,_that.selectGroups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  bool isFetchingGroups,  List<Group> groups,  List<Stock> stocks,  List<Extras> activeGroupExtras,  Map<String, List<Extras?>> selectGroups)  $default,) {final _that = this;
switch (_that) {
case _CreateFoodStocksState():
return $default(_that.isLoading,_that.isSaving,_that.isFetchingGroups,_that.groups,_that.stocks,_that.activeGroupExtras,_that.selectGroups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSaving,  bool isFetchingGroups,  List<Group> groups,  List<Stock> stocks,  List<Extras> activeGroupExtras,  Map<String, List<Extras?>> selectGroups)?  $default,) {final _that = this;
switch (_that) {
case _CreateFoodStocksState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.isFetchingGroups,_that.groups,_that.stocks,_that.activeGroupExtras,_that.selectGroups);case _:
  return null;

}
}

}

/// @nodoc


class _CreateFoodStocksState extends CreateFoodStocksState {
  const _CreateFoodStocksState({this.isLoading = false, this.isSaving = false, this.isFetchingGroups = false, final  List<Group> groups = const [], final  List<Stock> stocks = const [], final  List<Extras> activeGroupExtras = const [], final  Map<String, List<Extras?>> selectGroups = const {}}): _groups = groups,_stocks = stocks,_activeGroupExtras = activeGroupExtras,_selectGroups = selectGroups,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isFetchingGroups;
 final  List<Group> _groups;
@override@JsonKey() List<Group> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  List<Stock> _stocks;
@override@JsonKey() List<Stock> get stocks {
  if (_stocks is EqualUnmodifiableListView) return _stocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stocks);
}

 final  List<Extras> _activeGroupExtras;
@override@JsonKey() List<Extras> get activeGroupExtras {
  if (_activeGroupExtras is EqualUnmodifiableListView) return _activeGroupExtras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeGroupExtras);
}

 final  Map<String, List<Extras?>> _selectGroups;
@override@JsonKey() Map<String, List<Extras?>> get selectGroups {
  if (_selectGroups is EqualUnmodifiableMapView) return _selectGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectGroups);
}


/// Create a copy of CreateFoodStocksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateFoodStocksStateCopyWith<_CreateFoodStocksState> get copyWith => __$CreateFoodStocksStateCopyWithImpl<_CreateFoodStocksState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateFoodStocksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isFetchingGroups, isFetchingGroups) || other.isFetchingGroups == isFetchingGroups)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._stocks, _stocks)&&const DeepCollectionEquality().equals(other._activeGroupExtras, _activeGroupExtras)&&const DeepCollectionEquality().equals(other._selectGroups, _selectGroups));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,isFetchingGroups,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_stocks),const DeepCollectionEquality().hash(_activeGroupExtras),const DeepCollectionEquality().hash(_selectGroups));

@override
String toString() {
  return 'CreateFoodStocksState(isLoading: $isLoading, isSaving: $isSaving, isFetchingGroups: $isFetchingGroups, groups: $groups, stocks: $stocks, activeGroupExtras: $activeGroupExtras, selectGroups: $selectGroups)';
}


}

/// @nodoc
abstract mixin class _$CreateFoodStocksStateCopyWith<$Res> implements $CreateFoodStocksStateCopyWith<$Res> {
  factory _$CreateFoodStocksStateCopyWith(_CreateFoodStocksState value, $Res Function(_CreateFoodStocksState) _then) = __$CreateFoodStocksStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSaving, bool isFetchingGroups, List<Group> groups, List<Stock> stocks, List<Extras> activeGroupExtras, Map<String, List<Extras?>> selectGroups
});




}
/// @nodoc
class __$CreateFoodStocksStateCopyWithImpl<$Res>
    implements _$CreateFoodStocksStateCopyWith<$Res> {
  __$CreateFoodStocksStateCopyWithImpl(this._self, this._then);

  final _CreateFoodStocksState _self;
  final $Res Function(_CreateFoodStocksState) _then;

/// Create a copy of CreateFoodStocksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSaving = null,Object? isFetchingGroups = null,Object? groups = null,Object? stocks = null,Object? activeGroupExtras = null,Object? selectGroups = null,}) {
  return _then(_CreateFoodStocksState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isFetchingGroups: null == isFetchingGroups ? _self.isFetchingGroups : isFetchingGroups // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,stocks: null == stocks ? _self._stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,activeGroupExtras: null == activeGroupExtras ? _self._activeGroupExtras : activeGroupExtras // ignore: cast_nullable_to_non_nullable
as List<Extras>,selectGroups: null == selectGroups ? _self._selectGroups : selectGroups // ignore: cast_nullable_to_non_nullable
as Map<String, List<Extras?>>,
  ));
}


}

// dart format on
