part of 'driver_pending_verification_review.bloc.dart';

@freezed
sealed class DriverPendingVerificationReviewState
    with _$DriverPendingVerificationReviewState {
  const factory DriverPendingVerificationReviewState({
    String? driverId,
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverReview> driverReviewState,
    @Default(ApiResponse.initial()) ApiResponse<Query$services> servicesState,
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverDocuments> driverDocumentsState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$driverRejection> driverRejectionState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$driverApprove> driverApproveState,
    @Default([]) List<DateTime?> driverDocumentsExpireDateTime,
    @Default([])
    List<Fragment$driverDocumentRetentionPolicy?>
    driverDocumentsRetentionPolicy,
    @Default([]) List<bool> driverDocumentsExpireDate,
    Fragment$driverDetail? driverReview,
    Fragment$driverDetail? originalDriverReview,
    @Default(0) int stepperCurrentIndex,
    @Default([]) List<Fragment$taxiPricing> servicesFilter,
    @Default([])
    List<DriverPendingVerificationReviewServicesModel> selectedServiceCheckBox,
    @Default(true) canDeliverServices,
    @Default([])
    List<DriverPendingVerificationReviewServicesOptionModel>
    deliveryServicesOption,
    String? rejectionNote,
    String? rejectionNoteToStaff,
  }) = _DriverPendingVerificationReviewState;
}
