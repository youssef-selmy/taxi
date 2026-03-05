import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/provider_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/data/graphql/taxi_order_detail_transactions.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/data/repositories/taxi_order_detail_transactions_repository.dart';

part 'taxi_order_detail_transactions.state.dart';
part 'taxi_order_detail_transactions.cubit.freezed.dart';

class TaxiOrderDetailTransactionsBloc
    extends Cubit<TaxiOrderDetailTransactionsState> {
  final TaxiOrderDetailTransactionsRepository
  _taxiOrderDetailTransactionRepository =
      locator<TaxiOrderDetailTransactionsRepository>();

  TaxiOrderDetailTransactionsBloc()
    // ignore: prefer_const_constructors
    : super(TaxiOrderDetailTransactionsState());

  void onStarted(String taxiOrderId) {
    _fetchTaxiOrderTransactions(taxiOrderId);
  }

  Future<void> _fetchTaxiOrderTransactions(String taxiOrderId) async {
    emit(
      state.copyWith(taxiOrderTransactionsState: const ApiResponse.loading()),
    );

    final taxiOrderTransactionOrError =
        await _taxiOrderDetailTransactionRepository.getTaxiOrderTransactions(
          orderId: taxiOrderId,
        );

    emit(
      state.copyWith(taxiOrderTransactionsState: taxiOrderTransactionOrError),
    );
  }
}
