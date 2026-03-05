import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/announcement.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/announcement/data/repositories/announcement_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'announcement_detail.state.dart';
part 'announcement_detail.cubit.freezed.dart';

class AnnouncementDetailBloc extends Cubit<AnnouncementDetailState> {
  final AnnouncementRepository _announcementRepository =
      locator<AnnouncementRepository>();

  AnnouncementDetailBloc() : super(AnnouncementDetailState());

  void onStarted({required String announcementId}) {
    emit(AnnouncementDetailState(announcementId: announcementId));
    _fetchAnnouncementDetail();
  }

  void onDelete() async {
    emit(state.copyWith(deleteState: const ApiResponse.loading()));
    final deleteOrError = await _announcementRepository.delete(
      id: state.announcementId!,
    );
    final deleteState = deleteOrError;
    emit(state.copyWith(deleteState: deleteState));
  }

  void onSubmit() async {
    emit(state.copyWith(updateState: const ApiResponse.loading()));
    final announcementOrError = await _announcementRepository.update(
      id: state.announcementId!,
      input: Input$UpdateAnnouncementInput(
        title: state.title!,
        description: state.description ?? "",
        url: state.url,
        appType: state.appType,
        mediaId: state.image?.id,
        userType: state.userType == null ? [] : [state.userType!],
        startAt: state.startDate,
        expireAt: state.endDate,
      ),
    );
    final updateState = announcementOrError;
    emit(state.copyWith(updateState: updateState));
  }

  void _fetchAnnouncementDetail() async {
    emit(state.copyWith(announcementState: const ApiResponse.loading()));
    final announcementOrError = await _announcementRepository.get(
      id: state.announcementId!,
    );
    final announcementState = announcementOrError;
    emit(
      state.copyWith(
        announcementState: announcementState,
        title: announcementState.data?.title,
        description: announcementState.data?.description,
        url: announcementState.data?.url,
        appType: announcementState.data?.appType,
        userType: announcementState.data?.userType.firstOrNull,
        image: announcementState.data?.media,
        startDate: announcementState.data?.startAt,
        endDate: announcementState.data?.expireAt,
      ),
    );
  }

  void onAppTypeChanged(Enum$AppType? p1) {
    emit(state.copyWith(appType: p1));
  }

  void onDescriptionChanged(String p1) {
    emit(state.copyWith(description: p1));
  }

  void onTitleChanged(String p1) {
    emit(state.copyWith(title: p1));
  }

  void onUrlChanged(String p1) {
    emit(state.copyWith(url: p1));
  }

  void onUserTypeChanged(Enum$AnnouncementUserType? p1) {
    emit(state.copyWith(userType: p1));
  }

  void onDateRangeChanged((DateTime, DateTime) value) {
    emit(state.copyWith(startDate: value.$1, endDate: value.$2));
  }

  void onImageUploaded(Fragment$Media media) {
    emit(state.copyWith(image: media));
  }
}
