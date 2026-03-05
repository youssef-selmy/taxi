import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/campaign.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/coupon/data/graphql/coupon.graphql.dart';
import 'package:admin_frontend/features/marketing/coupon/data/repositories/coupon_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'campaign_details.state.dart';
part 'campaign_details.cubit.freezed.dart';

class CampaignDetailsBloc extends Cubit<CampaignDetailsState> {
  final CouponRepository _couponRepository = locator<CouponRepository>();

  CampaignDetailsBloc() : super(CampaignDetailsState());

  void onStarted({required String campaignId}) {
    _getCampaignDetails(campaignId: campaignId);
    _getCouponCodes(campaignId: campaignId);
  }

  Future<void> _getCampaignDetails({required String campaignId}) async {
    emit(state.copyWith(campaign: const ApiResponse.loading()));
    final campaign = await _couponRepository.getCampaignDetails(id: campaignId);
    emit(state.copyWith(campaign: campaign));
  }

  Future<void> _getCouponCodes({required String campaignId}) async {
    emit(
      state.copyWith(
        campaignId: campaignId,
        giftCodes: const ApiResponse.loading(),
      ),
    );
    final couponCodes = await _couponRepository.getCampaignCodes(
      paging: state.giftCodesPaging,
      filter: Input$CampaignCodeFilter(
        campaignId: Input$IDFilterComparison(eq: campaignId),
      ),
      sorting: [],
    );
    emit(state.copyWith(giftCodes: couponCodes));
  }

  void onExportGiftCodes() async {
    final result = await _couponRepository.exportCampaignCodes(
      campaignId: state.campaignId!,
    );
    final networkState = result;
    emit(state.copyWith(exportCodes: networkState));
  }

  void resetExportState() {
    emit(state.copyWith(exportCodes: const ApiResponse.initial()));
  }

  void onCodesPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(giftCodesPaging: p1));
    _getCouponCodes(campaignId: state.campaignId!);
  }
}
