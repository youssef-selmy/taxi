part of 'taxi_order_detail.bloc.dart';

@freezed
sealed class TaxiOrderDetailEvent with _$TaxiOrderDetailEvent {
  const factory TaxiOrderDetailEvent.onStarted({required String orderId}) =
      _OnStarted;
}
