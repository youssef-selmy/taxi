import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/graphql/payment_gateway.graphql.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/repositories/payment_gateway_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'payment_gateway_list.state.dart';
part 'payment_gateway_list.cubit.freezed.dart';

class PaymentGatewayListBloc extends Cubit<PaymentGatewayListState> {
  final PaymentGatewayRepository _paymentGatewayListRepository =
      locator<PaymentGatewayRepository>();

  PaymentGatewayListBloc() : super(PaymentGatewayListState.initial());

  void onStarted() {
    _getPaymentGateways();
  }

  Future<void> _getPaymentGateways() async {
    emit(state.copyWith(paymentGateways: const ApiResponse.loading()));
    final paymentGateways = await _paymentGatewayListRepository.getAll(
      paging: state.paging,
      filter: Input$PaymentGatewayFilter(
        title: state.search == null
            ? null
            : Input$StringFieldComparison(eq: state.search),
      ),
      sort: state.sort,
    );
    emit(state.copyWith(paymentGateways: paymentGateways));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _getPaymentGateways();
  }

  void refresh() {
    _getPaymentGateways();
  }
}
