part of 'announcement_detail.cubit.dart';

@freezed
sealed class AnnouncementDetailState with _$AnnouncementDetailState {
  const factory AnnouncementDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$announcementDetails> announcementState,
    @Default(ApiResponseInitial()) ApiResponse<void> updateState,
    @Default(ApiResponseInitial()) ApiResponse<void> deleteState,
    String? announcementId,
    DateTime? startDate,
    DateTime? endDate,
    String? title,
    String? description,
    String? url,
    Enum$AppType? appType,
    Enum$AnnouncementUserType? userType,
    Fragment$Media? image,
  }) = _AnnouncementDetailState;
}
