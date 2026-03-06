// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigator.cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppNavigatorState {

 PageRouteInfo<dynamic> get selectedRoute;
/// Create a copy of AppNavigatorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNavigatorStateCopyWith<AppNavigatorState> get copyWith => _$AppNavigatorStateCopyWithImpl<AppNavigatorState>(this as AppNavigatorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNavigatorState&&(identical(other.selectedRoute, selectedRoute) || other.selectedRoute == selectedRoute));
}


@override
int get hashCode => Object.hash(runtimeType,selectedRoute);

@override
String toString() {
  return 'AppNavigatorState(selectedRoute: $selectedRoute)';
}


}

/// @nodoc
abstract mixin class $AppNavigatorStateCopyWith<$Res>  {
  factory $AppNavigatorStateCopyWith(AppNavigatorState value, $Res Function(AppNavigatorState) _then) = _$AppNavigatorStateCopyWithImpl;
@useResult
$Res call({
 PageRouteInfo<dynamic> selectedRoute
});




}
/// @nodoc
class _$AppNavigatorStateCopyWithImpl<$Res>
    implements $AppNavigatorStateCopyWith<$Res> {
  _$AppNavigatorStateCopyWithImpl(this._self, this._then);

  final AppNavigatorState _self;
  final $Res Function(AppNavigatorState) _then;

/// Create a copy of AppNavigatorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedRoute = null,}) {
  return _then(_self.copyWith(
selectedRoute: null == selectedRoute ? _self.selectedRoute : selectedRoute // ignore: cast_nullable_to_non_nullable
as PageRouteInfo<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppNavigatorState].
extension AppNavigatorStatePatterns on AppNavigatorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigatorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigatorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigatorState value)  $default,){
final _that = this;
switch (_that) {
case _NavigatorState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigatorState value)?  $default,){
final _that = this;
switch (_that) {
case _NavigatorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageRouteInfo<dynamic> selectedRoute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigatorState() when $default != null:
return $default(_that.selectedRoute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageRouteInfo<dynamic> selectedRoute)  $default,) {final _that = this;
switch (_that) {
case _NavigatorState():
return $default(_that.selectedRoute);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageRouteInfo<dynamic> selectedRoute)?  $default,) {final _that = this;
switch (_that) {
case _NavigatorState() when $default != null:
return $default(_that.selectedRoute);case _:
  return null;

}
}

}

/// @nodoc


class _NavigatorState extends AppNavigatorState {
  const _NavigatorState({required this.selectedRoute}): super._();
  

@override final  PageRouteInfo<dynamic> selectedRoute;

/// Create a copy of AppNavigatorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigatorStateCopyWith<_NavigatorState> get copyWith => __$NavigatorStateCopyWithImpl<_NavigatorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigatorState&&(identical(other.selectedRoute, selectedRoute) || other.selectedRoute == selectedRoute));
}


@override
int get hashCode => Object.hash(runtimeType,selectedRoute);

@override
String toString() {
  return 'AppNavigatorState(selectedRoute: $selectedRoute)';
}


}

/// @nodoc
abstract mixin class _$NavigatorStateCopyWith<$Res> implements $AppNavigatorStateCopyWith<$Res> {
  factory _$NavigatorStateCopyWith(_NavigatorState value, $Res Function(_NavigatorState) _then) = __$NavigatorStateCopyWithImpl;
@override @useResult
$Res call({
 PageRouteInfo<dynamic> selectedRoute
});




}
/// @nodoc
class __$NavigatorStateCopyWithImpl<$Res>
    implements _$NavigatorStateCopyWith<$Res> {
  __$NavigatorStateCopyWithImpl(this._self, this._then);

  final _NavigatorState _self;
  final $Res Function(_NavigatorState) _then;

/// Create a copy of AppNavigatorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedRoute = null,}) {
  return _then(_NavigatorState(
selectedRoute: null == selectedRoute ? _self.selectedRoute : selectedRoute // ignore: cast_nullable_to_non_nullable
as PageRouteInfo<dynamic>,
  ));
}


}

// dart format on
