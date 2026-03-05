import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/data/graphql/taxi_order_detail_chat_histories.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/data/repositories/taxi_order_detail_chat_histories_repository.dart';

@dev
@LazySingleton(as: TaxiOrderDetailChatHistoriesRepository)
class TaxiOrderDetailChatHistoriesRepositoryMock
    implements TaxiOrderDetailChatHistoriesRepository {
  @override
  Future<ApiResponse<Query$getTaxiOrderDetailChatHistories>>
  getTaxiOrderDetailChatHistories({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getTaxiOrderDetailChatHistories(
        order: Query$getTaxiOrderDetailChatHistories$order(
          rider: mockCustomerCompact1,
          driver: mockDriverName1,
          chatHistories: mockListConversations,
        ),
      ),
    );
  }
}
