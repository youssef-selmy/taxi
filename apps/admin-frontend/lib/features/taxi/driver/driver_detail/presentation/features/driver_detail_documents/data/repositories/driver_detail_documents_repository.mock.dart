import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_document.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/data/graphql/driver_detail_documents.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/data/repositories/driver_detail_documents_repository.dart';

@dev
@LazySingleton(as: DriverDetailDocumentsRepository)
class DriverDetailDocumentsRepositoryMock
    implements DriverDetailDocumentsRepository {
  @override
  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return ApiResponse.loaded(
      Query$driverDocuments(
        driverToDriverDocuments: Query$driverDocuments$driverToDriverDocuments(
          edges: mockDriverToDriverDocuments
              .map(
                (e) => Query$driverDocuments$driverToDriverDocuments$edges(
                  node: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
