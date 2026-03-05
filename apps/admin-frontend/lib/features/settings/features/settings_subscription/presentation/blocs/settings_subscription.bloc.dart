import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_subscription.state.dart';
part 'settings_subscription.bloc.freezed.dart';

class SettingsSubscriptionBloc extends Cubit<SettingsSubscriptionState> {
  // final SettingsSubscriptionRepository _settingsSubscriptionRepository =
  //     locator<SettingsSubscriptionRepository>();

  SettingsSubscriptionBloc() : super(const SettingsSubscriptionState());

  void onStarted() {}
}
