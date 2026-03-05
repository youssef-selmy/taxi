import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/address.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/address.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/address_repository.dart';

@dev
@LazySingleton(as: AddressRepository)
class AddressRepositoryMock implements AddressRepository {
  @override
  Future<ApiResponse<Query$customerAddresses>> getCustomerAddresses(
    String customerId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$customerAddresses(
        addresses: Query$customerAddresses$addresses(
          nodes: mockAddresses,
          pageInfo: mockPageInfo,
          totalCount: mockAddresses.length,
        ),
      ),
    );
  }
}
