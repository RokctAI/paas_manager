// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'working_days_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkingDaysState {

 bool get isLoading; int get currentIndex; List<ShopWorkingDays> get workingDays;
/// Create a copy of WorkingDaysState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkingDaysStateCopyWith<WorkingDaysState> get copyWith => _$WorkingDaysStateCopyWithImpl<WorkingDaysState>(this as WorkingDaysState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkingDaysState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other.workingDays, workingDays));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,currentIndex,const DeepCollectionEquality().hash(workingDays));

@override
String toString() {
  return 'WorkingDaysState(isLoading: $isLoading, currentIndex: $currentIndex, workingDays: $workingDays)';
}


}

/// @nodoc
abstract mixin class $WorkingDaysStateCopyWith<$Res>  {
  factory $WorkingDaysStateCopyWith(WorkingDaysState value, $Res Function(WorkingDaysState) _then) = _$WorkingDaysStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, int currentIndex, List<ShopWorkingDays> workingDays
});




}
/// @nodoc
class _$WorkingDaysStateCopyWithImpl<$Res>
    implements $WorkingDaysStateCopyWith<$Res> {
  _$WorkingDaysStateCopyWithImpl(this._self, this._then);

  final WorkingDaysState _self;
  final $Res Function(WorkingDaysState) _then;

/// Create a copy of WorkingDaysState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? currentIndex = null,Object? workingDays = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,workingDays: null == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as List<ShopWorkingDays>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkingDaysState].
extension WorkingDaysStatePatterns on WorkingDaysState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkingDaysState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkingDaysState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkingDaysState value)  $default,){
final _that = this;
switch (_that) {
case _WorkingDaysState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkingDaysState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkingDaysState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  int currentIndex,  List<ShopWorkingDays> workingDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkingDaysState() when $default != null:
return $default(_that.isLoading,_that.currentIndex,_that.workingDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  int currentIndex,  List<ShopWorkingDays> workingDays)  $default,) {final _that = this;
switch (_that) {
case _WorkingDaysState():
return $default(_that.isLoading,_that.currentIndex,_that.workingDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  int currentIndex,  List<ShopWorkingDays> workingDays)?  $default,) {final _that = this;
switch (_that) {
case _WorkingDaysState() when $default != null:
return $default(_that.isLoading,_that.currentIndex,_that.workingDays);case _:
  return null;

}
}

}

/// @nodoc


class _WorkingDaysState extends WorkingDaysState {
  const _WorkingDaysState({this.isLoading = false, this.currentIndex = 0, final  List<ShopWorkingDays> workingDays = const []}): _workingDays = workingDays,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  int currentIndex;
 final  List<ShopWorkingDays> _workingDays;
@override@JsonKey() List<ShopWorkingDays> get workingDays {
  if (_workingDays is EqualUnmodifiableListView) return _workingDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workingDays);
}


/// Create a copy of WorkingDaysState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkingDaysStateCopyWith<_WorkingDaysState> get copyWith => __$WorkingDaysStateCopyWithImpl<_WorkingDaysState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkingDaysState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other._workingDays, _workingDays));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,currentIndex,const DeepCollectionEquality().hash(_workingDays));

@override
String toString() {
  return 'WorkingDaysState(isLoading: $isLoading, currentIndex: $currentIndex, workingDays: $workingDays)';
}


}

/// @nodoc
abstract mixin class _$WorkingDaysStateCopyWith<$Res> implements $WorkingDaysStateCopyWith<$Res> {
  factory _$WorkingDaysStateCopyWith(_WorkingDaysState value, $Res Function(_WorkingDaysState) _then) = __$WorkingDaysStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, int currentIndex, List<ShopWorkingDays> workingDays
});




}
/// @nodoc
class __$WorkingDaysStateCopyWithImpl<$Res>
    implements _$WorkingDaysStateCopyWith<$Res> {
  __$WorkingDaysStateCopyWithImpl(this._self, this._then);

  final _WorkingDaysState _self;
  final $Res Function(_WorkingDaysState) _then;

/// Create a copy of WorkingDaysState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? currentIndex = null,Object? workingDays = null,}) {
  return _then(_WorkingDaysState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,workingDays: null == workingDays ? _self._workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as List<ShopWorkingDays>,
  ));
}


}

// dart format on
