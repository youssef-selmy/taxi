part of 'campaign_details.cubit.dart';

@freezed
sealed class CampaignDetailsState with _$CampaignDetailsState {
  const factory CampaignDetailsState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$campaignDetails> campaign,
    @Default(ApiResponseInitial()) ApiResponse<Query$campaignCodes> giftCodes,
    @Default(ApiResponseInitial()) ApiResponse<String> exportCodes,
    String? campaignId,
    Input$OffsetPaging? giftCodesPaging,
  }) = _CampaignDetailsState;
}
