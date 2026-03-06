// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'docs.cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DocsState {

/// The currently selected documentation page
 String get selectedPage;/// The markdown content of the selected page
 String get content;/// Whether the content is currently loading
 bool get isLoading;/// Error message if content failed to load
 String? get error;/// List of headings extracted from the current page (for "On This Page" navigation)
 List<String> get headings;/// Currently active heading (for scroll highlighting)
 String? get activeHeading;
/// Create a copy of DocsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocsStateCopyWith<DocsState> get copyWith => _$DocsStateCopyWithImpl<DocsState>(this as DocsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocsState&&(identical(other.selectedPage, selectedPage) || other.selectedPage == selectedPage)&&(identical(other.content, content) || other.content == content)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.headings, headings)&&(identical(other.activeHeading, activeHeading) || other.activeHeading == activeHeading));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPage,content,isLoading,error,const DeepCollectionEquality().hash(headings),activeHeading);

@override
String toString() {
  return 'DocsState(selectedPage: $selectedPage, content: $content, isLoading: $isLoading, error: $error, headings: $headings, activeHeading: $activeHeading)';
}


}

/// @nodoc
abstract mixin class $DocsStateCopyWith<$Res>  {
  factory $DocsStateCopyWith(DocsState value, $Res Function(DocsState) _then) = _$DocsStateCopyWithImpl;
@useResult
$Res call({
 String selectedPage, String content, bool isLoading, String? error, List<String> headings, String? activeHeading
});




}
/// @nodoc
class _$DocsStateCopyWithImpl<$Res>
    implements $DocsStateCopyWith<$Res> {
  _$DocsStateCopyWithImpl(this._self, this._then);

  final DocsState _self;
  final $Res Function(DocsState) _then;

/// Create a copy of DocsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedPage = null,Object? content = null,Object? isLoading = null,Object? error = freezed,Object? headings = null,Object? activeHeading = freezed,}) {
  return _then(_self.copyWith(
selectedPage: null == selectedPage ? _self.selectedPage : selectedPage // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,headings: null == headings ? _self.headings : headings // ignore: cast_nullable_to_non_nullable
as List<String>,activeHeading: freezed == activeHeading ? _self.activeHeading : activeHeading // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocsState].
extension DocsStatePatterns on DocsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocsState value)  $default,){
final _that = this;
switch (_that) {
case _DocsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocsState value)?  $default,){
final _that = this;
switch (_that) {
case _DocsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String selectedPage,  String content,  bool isLoading,  String? error,  List<String> headings,  String? activeHeading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocsState() when $default != null:
return $default(_that.selectedPage,_that.content,_that.isLoading,_that.error,_that.headings,_that.activeHeading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String selectedPage,  String content,  bool isLoading,  String? error,  List<String> headings,  String? activeHeading)  $default,) {final _that = this;
switch (_that) {
case _DocsState():
return $default(_that.selectedPage,_that.content,_that.isLoading,_that.error,_that.headings,_that.activeHeading);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String selectedPage,  String content,  bool isLoading,  String? error,  List<String> headings,  String? activeHeading)?  $default,) {final _that = this;
switch (_that) {
case _DocsState() when $default != null:
return $default(_that.selectedPage,_that.content,_that.isLoading,_that.error,_that.headings,_that.activeHeading);case _:
  return null;

}
}

}

/// @nodoc


class _DocsState implements DocsState {
  const _DocsState({this.selectedPage = 'welcome', this.content = '', this.isLoading = false, this.error, final  List<String> headings = const [], this.activeHeading}): _headings = headings;
  

/// The currently selected documentation page
@override@JsonKey() final  String selectedPage;
/// The markdown content of the selected page
@override@JsonKey() final  String content;
/// Whether the content is currently loading
@override@JsonKey() final  bool isLoading;
/// Error message if content failed to load
@override final  String? error;
/// List of headings extracted from the current page (for "On This Page" navigation)
 final  List<String> _headings;
/// List of headings extracted from the current page (for "On This Page" navigation)
@override@JsonKey() List<String> get headings {
  if (_headings is EqualUnmodifiableListView) return _headings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_headings);
}

/// Currently active heading (for scroll highlighting)
@override final  String? activeHeading;

/// Create a copy of DocsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocsStateCopyWith<_DocsState> get copyWith => __$DocsStateCopyWithImpl<_DocsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocsState&&(identical(other.selectedPage, selectedPage) || other.selectedPage == selectedPage)&&(identical(other.content, content) || other.content == content)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._headings, _headings)&&(identical(other.activeHeading, activeHeading) || other.activeHeading == activeHeading));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPage,content,isLoading,error,const DeepCollectionEquality().hash(_headings),activeHeading);

@override
String toString() {
  return 'DocsState(selectedPage: $selectedPage, content: $content, isLoading: $isLoading, error: $error, headings: $headings, activeHeading: $activeHeading)';
}


}

/// @nodoc
abstract mixin class _$DocsStateCopyWith<$Res> implements $DocsStateCopyWith<$Res> {
  factory _$DocsStateCopyWith(_DocsState value, $Res Function(_DocsState) _then) = __$DocsStateCopyWithImpl;
@override @useResult
$Res call({
 String selectedPage, String content, bool isLoading, String? error, List<String> headings, String? activeHeading
});




}
/// @nodoc
class __$DocsStateCopyWithImpl<$Res>
    implements _$DocsStateCopyWith<$Res> {
  __$DocsStateCopyWithImpl(this._self, this._then);

  final _DocsState _self;
  final $Res Function(_DocsState) _then;

/// Create a copy of DocsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedPage = null,Object? content = null,Object? isLoading = null,Object? error = freezed,Object? headings = null,Object? activeHeading = freezed,}) {
  return _then(_DocsState(
selectedPage: null == selectedPage ? _self.selectedPage : selectedPage // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,headings: null == headings ? _self._headings : headings // ignore: cast_nullable_to_non_nullable
as List<String>,activeHeading: freezed == activeHeading ? _self.activeHeading : activeHeading // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
