import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/documents/select_customer.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/repositories/customers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomersRepository)
class CustomerRepositoryMock implements CustomersRepository {
  @override
  Future<ApiResponse<Query$Customers>> getCustomers({
    required Input$OffsetPaging? paging,
    required String? query,
  }) async {
    // query the list of customers based on query
    final customers = query != null
        ? mockCustomerCompacts
              .where((element) => element.mobileNumber.contains(query))
              .toList()
        : mockCustomerCompacts;
    return ApiResponse.loaded(
      Query$Customers(
        riders: Query$Customers$riders(
          nodes: customers,
          pageInfo: mockPageInfo,
          totalCount: customers.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$Address>>> getCustomerAddresses({
    required String customerId,
  }) async {
    return ApiResponse.loaded([
      Fragment$Address(
        id: "1",
        title: "Home",
        type: Enum$RiderAddressType.Home,
        details: mockPlace1.address,
        location: mockPlace1.point,
      ),
      Fragment$Address(
        id: "2",
        title: "Work",
        type: Enum$RiderAddressType.Work,
        details: mockPlace2.address,
        location: mockPlace2.point,
      ),
      Fragment$Address(
        id: "3",
        title: "Gym",
        details: mockPlace3.address,
        type: Enum$RiderAddressType.Gym,
        location: mockPlace3.point,
      ),
    ]);
  }
}
