part of 'create_announcement.cubit.dart';

@freezed
sealed class CreateAnnouncementState with _$CreateAnnouncementState {
  const factory CreateAnnouncementState({
    @Default(0) int selectedPage,
    String? title,
    String? description,
    Enum$AppType? appType,
    Enum$AnnouncementUserType? userType,
    DateTime? startDate,
    DateTime? endDate,
    String? url,
    Fragment$Media? image,
    @Default(false) bool sendSMS,
    @Default(false) bool sendEmail,
    @Default(true) bool sendPush,
    String? smsMessage,
    String? emailSubject,
    String? emailMessage,
    String? pushTitle,
    String? pushMessage,
    @Default(ApiResponseInitial()) ApiResponse<void> networkStateSave,
  }) = _CreateAnnouncementState;
}
