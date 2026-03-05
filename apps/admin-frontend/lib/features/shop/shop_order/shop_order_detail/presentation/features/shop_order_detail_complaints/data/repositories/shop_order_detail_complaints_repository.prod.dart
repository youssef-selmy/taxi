import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/data/graphql/shop_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/data/repositories/shop_order_detail_complaints_repository.dart';

@prod
@LazySingleton(as: ShopOrderDetailComplaintsRepository)
class ShopOrderDetailComplaintsRepositoryImpl
    implements ShopOrderDetailComplaintsRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopOrderDetailComplaintsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$getShopOrderComplaints>>
  getShopOrderDetailComplaints({required String orderId}) async {
    final getShopOrderDetailComplaints = await graphQLDatasource.query(
      Options$Query$getShopOrderComplaints(
        variables: Variables$Query$getShopOrderComplaints(orderId: orderId),
      ),
    );
    return getShopOrderDetailComplaints;
  }
}
