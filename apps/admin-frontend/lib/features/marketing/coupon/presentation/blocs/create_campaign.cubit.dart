import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/coupon/data/repositories/coupon_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'create_campaign.state.dart';
part 'create_campaign.cubit.freezed.dart';

class CreateCampaignBloc extends Cubit<CreateCampaignState> {
  final CouponRepository _couponRepository = locator<CouponRepository>();

  CreateCampaignBloc() : super(CreateCampaignState.initial());

  void onTitleChanged(String p1) {
    emit(state.copyWith(title: p1));
  }

  void onDescriptionChanged(String p1) {
    emit(state.copyWith(description: p1));
  }

  void onAppTypeChanged(int index, Enum$AppType? p1) {
    emit(
      state.copyWith(
        targetUsers: [
          ...state.targetUsers.sublist(0, index),
          state.targetUsers[index].copyWith(appType: p1),
          ...state.targetUsers.sublist(index + 1),
        ],
      ),
    );
  }

  void detailsPageCompleted() {
    emit(state.copyWith(selectedPage: 1));
  }

  void onSendAsSmsChanged(bool p1) {
    emit(state.copyWith(sendSMS: p1));
  }

  void onSmsMessageChanged(String p1) {
    emit(state.copyWith(smsText: p1));
  }

  void onSendAsEmailChanged(bool p1) {
    emit(state.copyWith(sendEmail: p1));
  }

  void onEmailSubjectChanged(String p1) {
    emit(state.copyWith(emailSubject: p1));
  }

  void onEmailMessageChanged(String p1) {
    emit(state.copyWith(emailText: p1));
  }

  void onSendAsPushChanged(bool p1) {
    emit(state.copyWith(sendPush: p1));
  }

  void onPushTitleChanged(String p1) {
    emit(state.copyWith(pushTitle: p1));
  }

  void onPushMessageChanged(String p1) {
    emit(state.copyWith(pushText: p1));
  }

  void onBackButtonPressed() {
    emit(state.copyWith(selectedPage: state.selectedPage - 1));
  }

  void onSubmit({required DateTime? sendAt}) async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _couponRepository.createCampaign(
      input: Input$CreateCampaignInput(
        name: state.title!,
        description: state.description!,
        startAt: state.dateRange?.$1,
        expireAt: state.dateRange?.$2,
        manyTimesUserCanUse: state.manyUsersCanUse,
        manyUsersCanUse: state.manyUsersCanUse,
        maximumCost: state.maximumPurchase,
        minimumCost: state.minimumPurchase,
        discountFlat: state.discountFlat,
        discountPercent: state.discountPercent,
        isFirstTravelOnly: state.isFirstTravelOnly,
        codesCount: state.codesCount,
        sendSMS: state.sendSMS,
        smsText: state.smsText,
        sendEmail: state.sendEmail,
        emailSubject: state.emailSubject,
        emailText: state.emailText,
        sendPush: state.sendPush,
        pushTitle: state.pushTitle,
        pushText: state.pushText,
        sendAt: sendAt,
        targetUsers: state.targetUsers,
      ),
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void onCriteriaTypeChanged(
    int index,
    Enum$CampaignCriteriaOrdersType? value,
  ) {
    emit(
      state.copyWith(
        targetUsers: [
          ...state.targetUsers.sublist(0, index),
          state.targetUsers[index].copyWith(type: value),
          ...state.targetUsers.sublist(index + 1),
        ],
      ),
    );
  }

  void onCriteriaValueChanged(int index, String value) {
    emit(
      state.copyWith(
        targetUsers: [
          ...state.targetUsers.sublist(0, index),
          state.targetUsers[index].copyWith(value: double.parse(value)),
          ...state.targetUsers.sublist(index + 1),
        ],
      ),
    );
  }

  void onLastActivityChanged(int index, int? p0) {
    emit(
      state.copyWith(
        targetUsers: [
          ...state.targetUsers.sublist(0, index),
          state.targetUsers[index].copyWith(lastDays: p0!),
          ...state.targetUsers.sublist(index + 1),
        ],
      ),
    );
  }

  void addTarget() {
    emit(
      state.copyWith(
        targetUsers: [
          ...state.targetUsers,
          Input$CampaignTargetSegmentCriteria(
            lastDays: 30,
            value: 0,
            appType: Enum$AppType.Taxi,
            type: Enum$CampaignCriteriaOrdersType.OrderCountMoreThan,
          ),
        ],
      ),
    );
  }

  void couponSettingsPageCompleted() {
    onSubmit(sendAt: null);
  }

  void onManyTimesUserCanUseChanged(String p1) {
    emit(state.copyWith(manyTimesUserCanUse: int.parse(p1)));
  }

  void onCodesCountChanged(int? count) {
    emit(state.copyWith(codesCount: count!));
  }

  void onManyUsersCanUseChanged(String p1) {
    emit(state.copyWith(manyUsersCanUse: int.parse(p1)));
  }

  void onMaximumPurchaseChanged(String p1) {
    emit(state.copyWith(maximumPurchase: double.parse(p1)));
  }

  void onMinimumPurchaseChanged(String p1) {
    emit(state.copyWith(minimumPurchase: double.parse(p1)));
  }

  void onTargetUsersNextButtonPressed() {
    emit(state.copyWith(selectedPage: 2));
  }

  void onDiscountFlatChanged(double? value) {
    emit(state.copyWith(discountFlat: value ?? 0));
  }

  void onDiscountPercentChanged(double? value) {
    emit(state.copyWith(discountPercent: value ?? 0));
  }

  void onDateRangeChanged((DateTime, DateTime) value) {
    emit(state.copyWith(dateRange: value));
  }
}
