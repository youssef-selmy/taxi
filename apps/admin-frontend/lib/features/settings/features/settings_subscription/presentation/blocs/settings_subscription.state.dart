part of 'settings_subscription.bloc.dart';

@freezed
sealed class SettingsSubscriptionState with _$SettingsSubscriptionState {
  const factory SettingsSubscriptionState({String? placeholder}) =
      _SettingsSubscriptionState;
}
