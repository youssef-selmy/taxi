import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/data/graphql/taxi_order_detail_chat_histories.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/data/repositories/taxi_order_detail_chat_histories_repository.dart';

@prod
@LazySingleton(as: TaxiOrderDetailChatHistoriesRepository)
class TaxiOrderDetailChatHistoriesRepositoryImpl
    implements TaxiOrderDetailChatHistoriesRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiOrderDetailChatHistoriesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$getTaxiOrderDetailChatHistories>>
  getTaxiOrderDetailChatHistories({required String id}) async {
    final getTaxiOrderConversations = await graphQLDatasource.query(
      Options$Query$getTaxiOrderDetailChatHistories(
        variables: Variables$Query$getTaxiOrderDetailChatHistories(orderId: id),
      ),
    );
    return getTaxiOrderConversations;
  }
}
