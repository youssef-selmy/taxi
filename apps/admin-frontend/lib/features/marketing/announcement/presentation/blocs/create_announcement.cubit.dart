import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/announcement/data/repositories/announcement_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'create_announcement.state.dart';
part 'create_announcement.cubit.freezed.dart';

class CreateAnnouncementBloc extends Cubit<CreateAnnouncementState> {
  final AnnouncementRepository _announcementRepository =
      locator<AnnouncementRepository>();

  CreateAnnouncementBloc() : super(const CreateAnnouncementState());

  void onTitleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void onDescriptionChanged(String description) {
    emit(state.copyWith(description: description));
  }

  void onAppTypeChanged(Enum$AppType? appType) {
    emit(state.copyWith(appType: appType));
  }

  void onUserTypeChanged(Enum$AnnouncementUserType? userType) {
    emit(state.copyWith(userType: userType));
  }

  void onUrlChanged(String url) {
    emit(state.copyWith(url: url));
  }

  void detailsPageCompleted() {
    emit(state.copyWith(selectedPage: 1));
  }

  void onSendAsSmsChanged(bool p1) {
    emit(state.copyWith(sendSMS: p1));
  }

  void onSmsMessageChanged(String p1) => emit(state.copyWith(smsMessage: p1));

  void onSendAsEmailChanged(bool p1) => emit(state.copyWith(sendEmail: p1));

  void onEmailSubjectChanged(String p1) =>
      emit(state.copyWith(emailSubject: p1));

  void onEmailMessageChanged(String p1) =>
      emit(state.copyWith(emailMessage: p1));

  void onSendAsPushChanged(bool p1) => emit(state.copyWith(sendPush: p1));

  void onPushTitleChanged(String p1) => emit(state.copyWith(pushTitle: p1));

  void onPushMessageChanged(String p1) => emit(state.copyWith(pushMessage: p1));

  void onSubmit({required DateTime? sendAt}) async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));

    // If startDate is today but has 00:00:00 time, use current time instead
    // This ensures announcements scheduled for "today" are sent immediately
    DateTime? effectiveStartDate = state.startDate;
    if (effectiveStartDate != null) {
      final now = DateTime.now();
      final isToday =
          effectiveStartDate.year == now.year &&
          effectiveStartDate.month == now.month &&
          effectiveStartDate.day == now.day;
      final isMidnight =
          effectiveStartDate.hour == 0 &&
          effectiveStartDate.minute == 0 &&
          effectiveStartDate.second == 0;
      if (isToday && isMidnight) {
        effectiveStartDate = now;
      }
    }

    final result = await _announcementRepository.create(
      input: Input$CreateAnnouncementInput(
        title: state.title!,
        description: state.description,
        url: state.url,
        appType: state.appType,
        mediaId: state.image?.id,
        userType: state.userType == null ? [] : [state.userType!],
        startAt: effectiveStartDate,
        expireAt: state.endDate,
        pushNotification: state.sendPush,
        pushNotificationTitle: state.pushTitle,
        pushNotificationBody: state.pushMessage,
        smsNotification: state.sendSMS,
        smsNotificationBody: state.smsMessage,
      ),
    );
    emit(state.copyWith(networkStateSave: result));
    emit(state.copyWith(networkStateSave: ApiResponse.initial()));
  }

  void onBackButtonPressed() =>
      emit(state.copyWith(selectedPage: state.selectedPage - 1));

  void onDateRangeChanged((DateTime, DateTime) value) {
    emit(state.copyWith(startDate: value.$1, endDate: value.$2));
  }

  void onStartDateChanged(DateTime? p1) => emit(state.copyWith(startDate: p1));

  void onEndDateChanged(DateTime? p1) => emit(state.copyWith(endDate: p1));

  void onImageUploaded(Fragment$Media media) {
    emit(state.copyWith(image: media));
  }
}
