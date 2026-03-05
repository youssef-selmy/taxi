import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/data/graphql/parking_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/data/repositories/parking_order_detail_transactions_repository.dart';

part 'parking_order_detail_transactions.state.dart';
part 'parking_order_detail_transactions.cubit.freezed.dart';

class ParkingOrderDetailTransactionsBloc
    extends Cubit<ParkingOrderDetailTransactionsState> {
  final ParkingOrderDetailTransactionsRepository
  _parkingOrderDetailTransactionRepository =
      locator<ParkingOrderDetailTransactionsRepository>();

  ParkingOrderDetailTransactionsBloc()
    // ignore: prefer_const_constructors
    : super(ParkingOrderDetailTransactionsState());

  void onStarted(String parkingOrderId) {
    _fetchParkingOrderDetailTransaction(parkingOrderId);
  }

  Future<void> _fetchParkingOrderDetailTransaction(
    String parkingOrderId,
  ) async {
    emit(
      state.copyWith(
        parkingOrderTransactionsState: const ApiResponse.loading(),
      ),
    );

    final parkingOrderTransactionsOrError =
        await _parkingOrderDetailTransactionRepository
            .getParkingOrderDetailTransactions(parkingOrderId: parkingOrderId);

    emit(
      state.copyWith(
        parkingOrderTransactionsState: parkingOrderTransactionsOrError,
      ),
    );
  }
}
