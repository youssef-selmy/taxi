import 'package:admin_frontend/core/graphql/fragments/customer_note.graphql.dart';
import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomerDetailsRepository {
  Future<ApiResponse<Fragment$customerDetails>> getCustomerDetails(String id);

  Future<ApiResponse<Fragment$customerDetails>> updateCustomerDetails(
    Input$UpdateOneRiderInput input,
  );

  Future<ApiResponse<List<Fragment$customerNote>>> getCustomerNotes({
    required String customerId,
  });

  Future<ApiResponse<Fragment$customerNote>> addCustomerNote({
    required String note,
    required String customerId,
  });

  Future<ApiResponse<void>> deleteUser({required String customerId});
}
