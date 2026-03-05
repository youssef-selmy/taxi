import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_note.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_note.graphql.extensions.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_details_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomerDetailsRepository)
class CustomerDetailsRepositoryMock implements CustomerDetailsRepository {
  @override
  Future<ApiResponse<Fragment$customerDetails>> getCustomerDetails(
    String id,
  ) async {
    return ApiResponse.loaded(mockCustomerDetail);
  }

  @override
  Future<ApiResponse<Fragment$customerDetails>> updateCustomerDetails(
    Input$UpdateOneRiderInput input,
  ) async {
    return ApiResponse.loaded(
      mockCustomerDetail.copyWith(
        firstName: input.update.firstName ?? mockCustomerDetail.firstName,
        lastName: input.update.lastName ?? mockCustomerDetail.lastName,
        email: input.update.email ?? mockCustomerDetail.email,
        status: input.update.status ?? mockCustomerDetail.status,
        mobileNumber:
            input.update.mobileNumber ?? mockCustomerDetail.mobileNumber,
        gender: input.update.gender ?? mockCustomerDetail.gender,
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$customerNote>> addCustomerNote({
    required String note,
    required String customerId,
  }) async {
    return ApiResponse.loaded(
      mockCustomerNote1.copyWith(
        note: note,
        createdBy: mockCustomerNote1.createdBy.copyWith(id: customerId),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$customerNote>>> getCustomerNotes({
    required String customerId,
  }) async {
    return ApiResponse.loaded([
      mockCustomerNote1,
      mockCustomerNote2,
      mockCustomerNote3,
    ]);
  }

  @override
  Future<ApiResponse<void>> deleteUser({required String customerId}) async {
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.loaded(null);
  }
}
