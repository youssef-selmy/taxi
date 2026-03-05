import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/campaign.graphql.dart';
import 'package:admin_frontend/features/marketing/coupon/data/graphql/coupon.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CouponRepository {
  Future<ApiResponse<Query$campaigns>> getCampaigns({
    required Input$OffsetPaging? paging,
    required Input$CampaignFilter filter,
    required List<Input$CampaignSort> sorting,
  });

  Future<ApiResponse<Fragment$campaignDetails>> getCampaignDetails({
    required String id,
  });

  Future<ApiResponse<Fragment$campaignListItem>> createCampaign({
    required Input$CreateCampaignInput input,
  });

  Future<ApiResponse<void>> deleteCampaign({required String id});

  Future<ApiResponse<Query$campaignCodes>> getCampaignCodes({
    required Input$OffsetPaging? paging,
    required Input$CampaignCodeFilter filter,
    required List<Input$CampaignCodeSort> sorting,
  });

  Future<ApiResponse<String>> exportCampaignCodes({required String campaignId});
}
