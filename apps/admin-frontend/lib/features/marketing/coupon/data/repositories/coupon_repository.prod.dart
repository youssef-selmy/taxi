import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/campaign.graphql.dart';
import 'package:admin_frontend/features/marketing/coupon/data/graphql/coupon.graphql.dart';
import 'package:admin_frontend/features/marketing/coupon/data/repositories/coupon_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CouponRepository)
class CouponRepositoryImpl implements CouponRepository {
  final GraphqlDatasource graphQLDatasource;

  CouponRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$campaignListItem>> createCampaign({
    required Input$CreateCampaignInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createCampaign(
        variables: Variables$Mutation$createCampaign(input: input),
      ),
    );
    return result.mapData((r) => r.createCampaign);
  }

  @override
  Future<ApiResponse<void>> deleteCampaign({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteCampaign(
        variables: Variables$Mutation$deleteCampaign(id: id),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Query$campaignCodes>> getCampaignCodes({
    required Input$OffsetPaging? paging,
    required Input$CampaignCodeFilter filter,
    required List<Input$CampaignCodeSort> sorting,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$campaignCodes(
        variables: Variables$Query$campaignCodes(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$campaignDetails>> getCampaignDetails({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$campaign(variables: Variables$Query$campaign(id: id)),
    );
    return result.mapData((r) => r.campaign);
  }

  @override
  Future<ApiResponse<Query$campaigns>> getCampaigns({
    required Input$OffsetPaging? paging,
    required Input$CampaignFilter filter,
    required List<Input$CampaignSort> sorting,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$campaigns(
        variables: Variables$Query$campaigns(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<String>> exportCampaignCodes({
    required String campaignId,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$exportCampaignCodes(
        variables: Variables$Query$exportCampaignCodes(campaignId: campaignId),
      ),
    );
    return result.mapData((r) => r.exportCampaignCodes);
  }
}
