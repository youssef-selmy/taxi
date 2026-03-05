import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/data/graphql/taxi_order_detail_chat_histories.graphql.dart';

abstract class TaxiOrderDetailChatHistoriesRepository {
  Future<ApiResponse<Query$getTaxiOrderDetailChatHistories>>
  getTaxiOrderDetailChatHistories({required String id});
}
