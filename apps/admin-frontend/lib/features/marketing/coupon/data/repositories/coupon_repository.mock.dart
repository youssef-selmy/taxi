import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/campaign.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/campaign.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/marketing/coupon/data/graphql/coupon.graphql.dart';
import 'package:admin_frontend/features/marketing/coupon/data/repositories/coupon_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CouponRepository)
class CouponRepositoryMock implements CouponRepository {
  @override
  Future<ApiResponse<Fragment$campaignListItem>> createCampaign({
    required Input$CreateCampaignInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockCampaignListItem1);
  }

  @override
  Future<ApiResponse<void>> deleteCampaign({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Query$campaignCodes>> getCampaignCodes({
    required Input$OffsetPaging? paging,
    required Input$CampaignCodeFilter filter,
    required List<Input$CampaignCodeSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$campaignCodes(
        campaignCodes: Query$campaignCodes$campaignCodes(
          nodes: mockCampaignCodes,
          pageInfo: mockPageInfo,
          totalCount: mockCampaignCodes.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$campaignDetails>> getCampaignDetails({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockCampaignDetails);
  }

  @override
  Future<ApiResponse<Query$campaigns>> getCampaigns({
    required Input$OffsetPaging? paging,
    required Input$CampaignFilter filter,
    required List<Input$CampaignSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$campaigns(
        campaigns: Query$campaigns$campaigns(
          nodes: mockCampaignListItems,
          pageInfo: mockPageInfo,
          totalCount: mockCampaignListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<String>> exportCampaignCodes({
    required String campaignId,
  }) async {
    return const ApiResponse.loaded('https://example.com/export.csv');
  }
}
