import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'taxi_order_detail.event.dart';
part 'taxi_order_detail.state.dart';
part 'taxi_order_detail.bloc.freezed.dart';

@lazySingleton
class TaxiOrderDetailBloc
    extends Bloc<TaxiOrderDetailEvent, TaxiOrderDetailState> {
  final TaxiOrderRepository _taxiOrderDetailRepository =
      locator<TaxiOrderRepository>();

  TaxiOrderDetailBloc() : super(const TaxiOrderDetailState()) {
    on<TaxiOrderDetailEvent>((event, emit) async {
      switch (event) {
        case _OnStarted(:final orderId):
          final order = await _taxiOrderDetailRepository.getOne(
            orderId: orderId,
          );
          emit(TaxiOrderDetailState(orderDetailResponse: order));
          break;
      }
    });
  }

  void onStarted({required String orderId}) =>
      add(TaxiOrderDetailEvent.onStarted(orderId: orderId));
}
