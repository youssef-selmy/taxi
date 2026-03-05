part of 'campaign_list.cubit.dart';

@freezed
sealed class CampaignListState with _$CampaignListState {
  const factory CampaignListState({
    @Default(ApiResponseInitial()) ApiResponse<Query$campaigns> campaigns,
    Input$OffsetPaging? paging,
    String? searchQuery,
    @Default([]) List<Input$CampaignSort> sort,
  }) = _CampaignListState;
}
