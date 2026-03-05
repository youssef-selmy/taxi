part of 'create_campaign.cubit.dart';

@freezed
sealed class CreateCampaignState with _$CreateCampaignState {
  const factory CreateCampaignState({
    @Default(0) int selectedPage,
    String? title,
    String? description,
    required List<Input$CampaignTargetSegmentCriteria> targetUsers,
    (DateTime, DateTime)? dateRange,
    String? url,
    @Default(0) int codesCount,
    @Default(0) int manyTimesUserCanUse,
    @Default(0) int manyUsersCanUse,
    @Default(0) double minimumPurchase,
    @Default(0) double maximumPurchase,
    @Default(0) double discountFlat,
    @Default(0) double discountPercent,
    @Default(false) bool isFirstTravelOnly,
    @Default(false) bool sendSMS,
    @Default(false) bool sendEmail,
    @Default(true) bool sendPush,
    String? smsText,
    String? emailSubject,
    String? emailText,
    String? pushTitle,
    String? pushText,
    @Default(ApiResponseInitial()) ApiResponse<void> networkStateSave,
  }) = _CreateCampaignState;

  factory CreateCampaignState.initial() => CreateCampaignState(
    targetUsers: [
      Input$CampaignTargetSegmentCriteria(
        lastDays: 30,
        value: 0,
        appType: Enum$AppType.Taxi,
        type: Enum$CampaignCriteriaOrdersType.OrderCountMoreThan,
      ),
    ],
  );
}
