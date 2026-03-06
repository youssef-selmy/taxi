import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigator.state.dart';
part 'navigator.cubit.freezed.dart';

class NavigatorCubit extends Cubit<AppNavigatorState> {
  NavigatorCubit() : super(AppNavigatorState.initial());

  void onNavigationItemTapped(PageRouteInfo route) {
    emit(state.copyWith(selectedRoute: route));
  }
}
