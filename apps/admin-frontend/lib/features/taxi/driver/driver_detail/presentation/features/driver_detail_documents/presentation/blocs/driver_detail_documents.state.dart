part of 'driver_detail_documents.bloc.dart';

@freezed
sealed class DriverDetailDocumentsState with _$DriverDetailDocumentsState {
  const factory DriverDetailDocumentsState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverDocuments> driverDocumentsState,
    String? driverId,
  }) = _DriverDetailDocumentsState;
}
