part of 'config.bloc.dart';

@freezed
sealed class ConfigEvent with _$ConfigEvent {
  const factory ConfigEvent.started() = ConfigEventStarted;
}
