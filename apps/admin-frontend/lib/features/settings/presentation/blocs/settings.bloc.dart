import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.state.dart';
part 'settings.bloc.freezed.dart';

class SettingsBloc extends Cubit<SettingsState> {
  SettingsBloc() : super(const SettingsState());

  void goToRoute(PageRouteInfo? route) {
    emit(state.copyWith(selectedRoute: route));
  }
}
