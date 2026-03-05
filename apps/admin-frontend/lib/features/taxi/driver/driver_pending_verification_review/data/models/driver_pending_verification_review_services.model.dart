import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_pending_verification_review_services.model.freezed.dart';

@freezed
sealed class DriverPendingVerificationReviewServicesModel
    with _$DriverPendingVerificationReviewServicesModel {
  factory DriverPendingVerificationReviewServicesModel({
    String? serviceId,
    bool? isSelectedService,
  }) = _DriverPendingVerificationReviewServicesModel;
}
