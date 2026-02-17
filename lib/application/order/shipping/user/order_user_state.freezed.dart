// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderUserState {

 List<UserData> get users; int get selectedIndex; bool get isLoading; UserData? get selectedUser; TextEditingController? get userTextController;
/// Create a copy of OrderUserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderUserStateCopyWith<OrderUserState> get copyWith => _$OrderUserStateCopyWithImpl<OrderUserState>(this as OrderUserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderUserState&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedUser, selectedUser) || other.selectedUser == selectedUser)&&(identical(other.userTextController, userTextController) || other.userTextController == userTextController));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(users),selectedIndex,isLoading,selectedUser,userTextController);

@override
String toString() {
  return 'OrderUserState(users: $users, selectedIndex: $selectedIndex, isLoading: $isLoading, selectedUser: $selectedUser, userTextController: $userTextController)';
}


}

/// @nodoc
abstract mixin class $OrderUserStateCopyWith<$Res>  {
  factory $OrderUserStateCopyWith(OrderUserState value, $Res Function(OrderUserState) _then) = _$OrderUserStateCopyWithImpl;
@useResult
$Res call({
 List<UserData> users, int selectedIndex, bool isLoading, UserData? selectedUser, TextEditingController? userTextController
});




}
/// @nodoc
class _$OrderUserStateCopyWithImpl<$Res>
    implements $OrderUserStateCopyWith<$Res> {
  _$OrderUserStateCopyWithImpl(this._self, this._then);

  final OrderUserState _self;
  final $Res Function(OrderUserState) _then;

/// Create a copy of OrderUserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? users = null,Object? selectedIndex = null,Object? isLoading = null,Object? selectedUser = freezed,Object? userTextController = freezed,}) {
  return _then(_self.copyWith(
users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<UserData>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedUser: freezed == selectedUser ? _self.selectedUser : selectedUser // ignore: cast_nullable_to_non_nullable
as UserData?,userTextController: freezed == userTextController ? _self.userTextController : userTextController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderUserState].
extension OrderUserStatePatterns on OrderUserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderUserState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderUserState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderUserState value)  $default,){
final _that = this;
switch (_that) {
case _OrderUserState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderUserState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderUserState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserData> users,  int selectedIndex,  bool isLoading,  UserData? selectedUser,  TextEditingController? userTextController)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderUserState() when $default != null:
return $default(_that.users,_that.selectedIndex,_that.isLoading,_that.selectedUser,_that.userTextController);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserData> users,  int selectedIndex,  bool isLoading,  UserData? selectedUser,  TextEditingController? userTextController)  $default,) {final _that = this;
switch (_that) {
case _OrderUserState():
return $default(_that.users,_that.selectedIndex,_that.isLoading,_that.selectedUser,_that.userTextController);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserData> users,  int selectedIndex,  bool isLoading,  UserData? selectedUser,  TextEditingController? userTextController)?  $default,) {final _that = this;
switch (_that) {
case _OrderUserState() when $default != null:
return $default(_that.users,_that.selectedIndex,_that.isLoading,_that.selectedUser,_that.userTextController);case _:
  return null;

}
}

}

/// @nodoc


class _OrderUserState extends OrderUserState {
  const _OrderUserState({final  List<UserData> users = const [], this.selectedIndex = 0, this.isLoading = false, this.selectedUser, this.userTextController}): _users = users,super._();
  

 final  List<UserData> _users;
@override@JsonKey() List<UserData> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override@JsonKey() final  int selectedIndex;
@override@JsonKey() final  bool isLoading;
@override final  UserData? selectedUser;
@override final  TextEditingController? userTextController;

/// Create a copy of OrderUserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderUserStateCopyWith<_OrderUserState> get copyWith => __$OrderUserStateCopyWithImpl<_OrderUserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderUserState&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedUser, selectedUser) || other.selectedUser == selectedUser)&&(identical(other.userTextController, userTextController) || other.userTextController == userTextController));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users),selectedIndex,isLoading,selectedUser,userTextController);

@override
String toString() {
  return 'OrderUserState(users: $users, selectedIndex: $selectedIndex, isLoading: $isLoading, selectedUser: $selectedUser, userTextController: $userTextController)';
}


}

/// @nodoc
abstract mixin class _$OrderUserStateCopyWith<$Res> implements $OrderUserStateCopyWith<$Res> {
  factory _$OrderUserStateCopyWith(_OrderUserState value, $Res Function(_OrderUserState) _then) = __$OrderUserStateCopyWithImpl;
@override @useResult
$Res call({
 List<UserData> users, int selectedIndex, bool isLoading, UserData? selectedUser, TextEditingController? userTextController
});




}
/// @nodoc
class __$OrderUserStateCopyWithImpl<$Res>
    implements _$OrderUserStateCopyWith<$Res> {
  __$OrderUserStateCopyWithImpl(this._self, this._then);

  final _OrderUserState _self;
  final $Res Function(_OrderUserState) _then;

/// Create a copy of OrderUserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? users = null,Object? selectedIndex = null,Object? isLoading = null,Object? selectedUser = freezed,Object? userTextController = freezed,}) {
  return _then(_OrderUserState(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<UserData>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedUser: freezed == selectedUser ? _self.selectedUser : selectedUser // ignore: cast_nullable_to_non_nullable
as UserData?,userTextController: freezed == userTextController ? _self.userTextController : userTextController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}


}

// dart format on
