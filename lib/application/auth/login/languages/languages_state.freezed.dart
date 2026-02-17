// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'languages_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LanguagesState {

 List<LanguageData> get languages; int get index; bool get isLoading; bool get isSelectLanguage;
/// Create a copy of LanguagesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguagesStateCopyWith<LanguagesState> get copyWith => _$LanguagesStateCopyWithImpl<LanguagesState>(this as LanguagesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguagesState&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.index, index) || other.index == index)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSelectLanguage, isSelectLanguage) || other.isSelectLanguage == isSelectLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(languages),index,isLoading,isSelectLanguage);

@override
String toString() {
  return 'LanguagesState(languages: $languages, index: $index, isLoading: $isLoading, isSelectLanguage: $isSelectLanguage)';
}


}

/// @nodoc
abstract mixin class $LanguagesStateCopyWith<$Res>  {
  factory $LanguagesStateCopyWith(LanguagesState value, $Res Function(LanguagesState) _then) = _$LanguagesStateCopyWithImpl;
@useResult
$Res call({
 List<LanguageData> languages, int index, bool isLoading, bool isSelectLanguage
});




}
/// @nodoc
class _$LanguagesStateCopyWithImpl<$Res>
    implements $LanguagesStateCopyWith<$Res> {
  _$LanguagesStateCopyWithImpl(this._self, this._then);

  final LanguagesState _self;
  final $Res Function(LanguagesState) _then;

/// Create a copy of LanguagesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languages = null,Object? index = null,Object? isLoading = null,Object? isSelectLanguage = null,}) {
  return _then(_self.copyWith(
languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<LanguageData>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSelectLanguage: null == isSelectLanguage ? _self.isSelectLanguage : isSelectLanguage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguagesState].
extension LanguagesStatePatterns on LanguagesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanguagesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanguagesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanguagesState value)  $default,){
final _that = this;
switch (_that) {
case _LanguagesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanguagesState value)?  $default,){
final _that = this;
switch (_that) {
case _LanguagesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LanguageData> languages,  int index,  bool isLoading,  bool isSelectLanguage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanguagesState() when $default != null:
return $default(_that.languages,_that.index,_that.isLoading,_that.isSelectLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LanguageData> languages,  int index,  bool isLoading,  bool isSelectLanguage)  $default,) {final _that = this;
switch (_that) {
case _LanguagesState():
return $default(_that.languages,_that.index,_that.isLoading,_that.isSelectLanguage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LanguageData> languages,  int index,  bool isLoading,  bool isSelectLanguage)?  $default,) {final _that = this;
switch (_that) {
case _LanguagesState() when $default != null:
return $default(_that.languages,_that.index,_that.isLoading,_that.isSelectLanguage);case _:
  return null;

}
}

}

/// @nodoc


class _LanguagesState extends LanguagesState {
  const _LanguagesState({final  List<LanguageData> languages = const [], this.index = 0, this.isLoading = true, this.isSelectLanguage = true}): _languages = languages,super._();
  

 final  List<LanguageData> _languages;
@override@JsonKey() List<LanguageData> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

@override@JsonKey() final  int index;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSelectLanguage;

/// Create a copy of LanguagesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguagesStateCopyWith<_LanguagesState> get copyWith => __$LanguagesStateCopyWithImpl<_LanguagesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguagesState&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.index, index) || other.index == index)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSelectLanguage, isSelectLanguage) || other.isSelectLanguage == isSelectLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_languages),index,isLoading,isSelectLanguage);

@override
String toString() {
  return 'LanguagesState(languages: $languages, index: $index, isLoading: $isLoading, isSelectLanguage: $isSelectLanguage)';
}


}

/// @nodoc
abstract mixin class _$LanguagesStateCopyWith<$Res> implements $LanguagesStateCopyWith<$Res> {
  factory _$LanguagesStateCopyWith(_LanguagesState value, $Res Function(_LanguagesState) _then) = __$LanguagesStateCopyWithImpl;
@override @useResult
$Res call({
 List<LanguageData> languages, int index, bool isLoading, bool isSelectLanguage
});




}
/// @nodoc
class __$LanguagesStateCopyWithImpl<$Res>
    implements _$LanguagesStateCopyWith<$Res> {
  __$LanguagesStateCopyWithImpl(this._self, this._then);

  final _LanguagesState _self;
  final $Res Function(_LanguagesState) _then;

/// Create a copy of LanguagesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languages = null,Object? index = null,Object? isLoading = null,Object? isSelectLanguage = null,}) {
  return _then(_LanguagesState(
languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<LanguageData>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSelectLanguage: null == isSelectLanguage ? _self.isSelectLanguage : isSelectLanguage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
