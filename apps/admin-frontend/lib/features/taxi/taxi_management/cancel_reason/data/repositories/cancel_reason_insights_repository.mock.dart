import 'dart:math';

import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/graphql/cancel_reason_insights.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/repositories/cancel_reason_insights_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CancelReasonInsightsRepository)
class CancelReasonInsightsRepositoryMock
    implements CancelReasonInsightsRepository {
  @override
  Future<ApiResponse<Query$cancelReasonInsights>>
  getCancelReasonInsights() async {
    return ApiResponse.loaded(
      Query$cancelReasonInsights(
        cancelReasonPopularityByName: mockCancelReasonPopularityByNames,
        cancelReasonPopularityByUserType: mockCancelReasonPopularityByUserTypes,
      ),
    );
  }
}

final mockCancelReasonPopularityByNames = mockCancelReasonTaxi
    .map(
      (e) => Fragment$nameCount(
        name: e.title,
        count: Random().nextInt(1000) + 500,
      ),
    )
    .toList();

final mockCancelReasonPopularityByUserTypes =
    [Enum$AnnouncementUserType.Rider, Enum$AnnouncementUserType.Driver]
        .map(
          (e) => Fragment$userTypeCount(
            userType: e,
            count: Random().nextInt(1000) + 500,
          ),
        )
        .toList();
