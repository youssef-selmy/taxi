import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway.graphql.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/graphql/payment_gateway.graphql.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/repositories/payment_gateway_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: PaymentGatewayRepository)
class PaymentGatewayRepositoryImpl implements PaymentGatewayRepository {
  final GraphqlDatasource graphQLDatasource;

  PaymentGatewayRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$paymentGatewayDetails>> create({
    required Input$CreatePaymentGatewayInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createPaymentGateway(
        variables: Variables$Mutation$createPaymentGateway(input: input),
      ),
    );
    return result.mapData((r) => r.createOnePaymentGateway);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deletePaymentGateway(
        variables: Variables$Mutation$deletePaymentGateway(id: id),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Query$paymentGateways>> getAll({
    required Input$OffsetPaging? paging,
    required Input$PaymentGatewayFilter filter,
    required List<Input$PaymentGatewaySort> sort,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$paymentGateways(
        variables: Variables$Query$paymentGateways(
          paging: paging,
          filter: filter,
          sorting: sort,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$paymentGatewayDetails>> getOne({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$paymentGateway(
        variables: Variables$Query$paymentGateway(id: id),
      ),
    );
    return result.mapData((r) => r.paymentGateway);
  }

  @override
  Future<ApiResponse<Fragment$paymentGatewayDetails>> update({
    required String id,
    required Input$UpdatePaymentGatewayInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updatePaymentGateway(
        variables: Variables$Mutation$updatePaymentGateway(
          id: id,
          input: input,
        ),
      ),
    );
    return result.mapData((r) => r.updateOnePaymentGateway);
  }
}
