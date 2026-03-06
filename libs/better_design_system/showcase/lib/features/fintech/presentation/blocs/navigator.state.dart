part of 'navigator.cubit.dart';

@freezed
sealed class AppNavigatorState with _$AppNavigatorState {
  const factory AppNavigatorState({
    required PageRouteInfo<dynamic> selectedRoute,
  }) = _NavigatorState;

  factory AppNavigatorState.initial() =>
      const AppNavigatorState(selectedRoute: FintechHomeRoute());

  const AppNavigatorState._();
}
