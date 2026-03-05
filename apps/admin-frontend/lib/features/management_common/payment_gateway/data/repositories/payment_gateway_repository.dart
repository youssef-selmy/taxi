import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/payment_gateway.graphql.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/graphql/payment_gateway.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class PaymentGatewayRepository {
  Future<ApiResponse<Query$paymentGateways>> getAll({
    required Input$OffsetPaging? paging,
    required Input$PaymentGatewayFilter filter,
    required List<Input$PaymentGatewaySort> sort,
  });

  Future<ApiResponse<Fragment$paymentGatewayDetails>> getOne({
    required String id,
  });

  Future<ApiResponse<Fragment$paymentGatewayDetails>> create({
    required Input$CreatePaymentGatewayInput input,
  });

  Future<ApiResponse<Fragment$paymentGatewayDetails>> update({
    required String id,
    required Input$UpdatePaymentGatewayInput input,
  });

  Future<ApiResponse<void>> delete({required String id});
}
