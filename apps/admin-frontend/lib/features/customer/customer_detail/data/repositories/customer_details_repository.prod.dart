import 'package:admin_frontend/core/graphql/fragments/customer_note.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_details.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_details_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomerDetailsRepository)
class CustomerDetailsRepositoryImpl implements CustomerDetailsRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomerDetailsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$customerDetails>> getCustomerDetails(
    String id,
  ) async {
    final result = await graphQLDatasource.query(
      Options$Query$customerDetailsRoot(
        variables: Variables$Query$customerDetailsRoot(id: id),
      ),
    );
    return result.mapData((r) => r.rider);
  }

  @override
  Future<ApiResponse<Fragment$customerDetails>> updateCustomerDetails(
    Input$UpdateOneRiderInput input,
  ) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateCustomerDetails(
        variables: Variables$Mutation$updateCustomerDetails(input: input),
      ),
    );
    return result.mapData((r) => r.updateOneRider);
  }

  @override
  Future<ApiResponse<Fragment$customerNote>> addCustomerNote({
    required String note,
    required String customerId,
  }) async {
    final noteResult = await graphQLDatasource.mutate(
      Options$Mutation$createCustomerNote(
        variables: Variables$Mutation$createCustomerNote(
          input: Input$CreateOneCustomerNoteInput(
            customerNote: Input$CreateCustomerNoteInput(
              customerId: customerId,
              note: note,
            ),
          ),
        ),
      ),
    );
    return noteResult.mapData((r) => r.createOneCustomerNote);
  }

  @override
  Future<ApiResponse<List<Fragment$customerNote>>> getCustomerNotes({
    required String customerId,
  }) async {
    final notesResult = await graphQLDatasource.query(
      Options$Query$customerNotes(
        variables: Variables$Query$customerNotes(customerId: customerId),
      ),
    );
    return notesResult.mapData((r) => r.customerNotes);
  }

  @override
  Future<ApiResponse<void>> deleteUser({required String customerId}) {
    return graphQLDatasource.mutate(
      Options$Mutation$deleteCustomer(
        variables: Variables$Mutation$deleteCustomer(customerId: customerId),
      ),
    );
  }
}
