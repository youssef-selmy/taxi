import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway.graphql.mock.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/graphql/payment_gateway.graphql.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/repositories/payment_gateway_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: PaymentGatewayRepository)
class PaymentGatewayRepositoryMock implements PaymentGatewayRepository {
  @override
  Future<ApiResponse<Fragment$paymentGatewayDetails>> create({
    required Input$CreatePaymentGatewayInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockPaymentGatewayDetails);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Query$paymentGateways>> getAll({
    required Input$OffsetPaging? paging,
    required Input$PaymentGatewayFilter filter,
    required List<Input$PaymentGatewaySort> sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$paymentGateways(
        paymentGateways: Query$paymentGateways$paymentGateways(
          nodes: mockPaymentGatewayList,
          pageInfo: mockPageInfo,
          totalCount: mockPaymentGatewayList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$paymentGatewayDetails>> getOne({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockPaymentGatewayDetails);
  }

  @override
  Future<ApiResponse<Fragment$paymentGatewayDetails>> update({
    required String id,
    required Input$UpdatePaymentGatewayInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockPaymentGatewayDetails);
  }
}
