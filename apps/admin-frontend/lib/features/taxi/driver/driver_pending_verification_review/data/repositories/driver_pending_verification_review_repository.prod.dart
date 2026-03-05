import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/data/graphql/driver_pending_verification_review.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/data/repositories/driver_pending_verification_review_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverPendingVerificationReviewRepository)
class DriverPendingVerificationReviewRepositoryImpl
    implements DriverPendingVerificationReviewRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverPendingVerificationReviewRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverReview>> getDriverReview({
    required String driverId,
  }) async {
    var getDriverReviewOrError = graphQLDatasource.query(
      Options$Query$driverReview(
        variables: Variables$Query$driverReview(id: driverId),
      ),
    );
    return getDriverReviewOrError;
  }

  @override
  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments({
    required String driverId,
  }) async {
    final getdriverDocumentsOrError = await graphQLDatasource.query(
      Options$Query$driverDocuments(
        variables: Variables$Query$driverDocuments(driverId: driverId),
      ),
    );
    return getdriverDocumentsOrError;
  }

  @override
  Future<ApiResponse<Query$services>> getServices() async {
    final getServiceCategoriesOrError = await graphQLDatasource.query(
      Options$Query$services(),
    );
    return getServiceCategoriesOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverRejection>> driverRejection({
    required Input$UpdateOneDriverInput inputUpdate,
    required Input$CreateOneDriverNoteInput inputCreate,
  }) async {
    final driverRejectionOrError = await graphQLDatasource.mutate(
      Options$Mutation$driverRejection(
        variables: Variables$Mutation$driverRejection(
          inputUpdate: inputUpdate,
          inputCreate: inputCreate,
        ),
      ),
    );
    return driverRejectionOrError;
  }

  @override
  Future<ApiResponse<Mutation$driverApprove>> driverApprove({
    required Input$UpdateOneDriverInput input,
  }) async {
    final driverApproveOrError = await graphQLDatasource.mutate(
      Options$Mutation$driverApprove(
        variables: Variables$Mutation$driverApprove(input: input),
      ),
    );
    return driverApproveOrError;
  }

  @override
  Future<ApiResponse<Mutation$updateDriverDocument>> updateDriverDocument({
    required Input$UpdateOneDriverToDriverDocumentInput input,
  }) async {
    final updateDriverDocumentOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateDriverDocument(
        variables: Variables$Mutation$updateDriverDocument(input: input),
      ),
    );
    return updateDriverDocumentOrError;
  }

  @override
  Future<ApiResponse<Mutation$setEnabledServices>> setEnabledServices({
    required Input$SetActiveServicesOnDriverInput input,
  }) async {
    final setEnabledServicesOrError = await graphQLDatasource.mutate(
      Options$Mutation$setEnabledServices(
        variables: Variables$Mutation$setEnabledServices(input: input),
      ),
    );
    return setEnabledServicesOrError;
  }
}
