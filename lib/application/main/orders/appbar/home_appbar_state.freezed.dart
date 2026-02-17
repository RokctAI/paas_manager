// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_appbar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeAppbarState {

 String get title; int get totalCount; int get index;
/// Create a copy of HomeAppbarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeAppbarStateCopyWith<HomeAppbarState> get copyWith => _$HomeAppbarStateCopyWithImpl<HomeAppbarState>(this as HomeAppbarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeAppbarState&&(identical(other.title, title) || other.title == title)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,title,totalCount,index);

@override
String toString() {
  return 'HomeAppbarState(title: $title, totalCount: $totalCount, index: $index)';
}


}

/// @nodoc
abstract mixin class $HomeAppbarStateCopyWith<$Res>  {
  factory $HomeAppbarStateCopyWith(HomeAppbarState value, $Res Function(HomeAppbarState) _then) = _$HomeAppbarStateCopyWithImpl;
@useResult
$Res call({
 String title, int totalCount, int index
});




}
/// @nodoc
class _$HomeAppbarStateCopyWithImpl<$Res>
    implements $HomeAppbarStateCopyWith<$Res> {
  _$HomeAppbarStateCopyWithImpl(this._self, this._then);

  final HomeAppbarState _self;
  final $Res Function(HomeAppbarState) _then;

/// Create a copy of HomeAppbarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? totalCount = null,Object? index = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeAppbarState].
extension HomeAppbarStatePatterns on HomeAppbarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeAppbarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeAppbarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeAppbarState value)  $default,){
final _that = this;
switch (_that) {
case _HomeAppbarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeAppbarState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeAppbarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int totalCount,  int index)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeAppbarState() when $default != null:
return $default(_that.title,_that.totalCount,_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int totalCount,  int index)  $default,) {final _that = this;
switch (_that) {
case _HomeAppbarState():
return $default(_that.title,_that.totalCount,_that.index);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int totalCount,  int index)?  $default,) {final _that = this;
switch (_that) {
case _HomeAppbarState() when $default != null:
return $default(_that.title,_that.totalCount,_that.index);case _:
  return null;

}
}

}

/// @nodoc


class _HomeAppbarState extends HomeAppbarState {
  const _HomeAppbarState({this.title = '', this.totalCount = 0, this.index = 0}): super._();
  

@override@JsonKey() final  String title;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int index;

/// Create a copy of HomeAppbarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeAppbarStateCopyWith<_HomeAppbarState> get copyWith => __$HomeAppbarStateCopyWithImpl<_HomeAppbarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeAppbarState&&(identical(other.title, title) || other.title == title)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,title,totalCount,index);

@override
String toString() {
  return 'HomeAppbarState(title: $title, totalCount: $totalCount, index: $index)';
}


}

/// @nodoc
abstract mixin class _$HomeAppbarStateCopyWith<$Res> implements $HomeAppbarStateCopyWith<$Res> {
  factory _$HomeAppbarStateCopyWith(_HomeAppbarState value, $Res Function(_HomeAppbarState) _then) = __$HomeAppbarStateCopyWithImpl;
@override @useResult
$Res call({
 String title, int totalCount, int index
});




}
/// @nodoc
class __$HomeAppbarStateCopyWithImpl<$Res>
    implements _$HomeAppbarStateCopyWith<$Res> {
  __$HomeAppbarStateCopyWithImpl(this._self, this._then);

  final _HomeAppbarState _self;
  final $Res Function(_HomeAppbarState) _then;

/// Create a copy of HomeAppbarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? totalCount = null,Object? index = null,}) {
  return _then(_HomeAppbarState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
