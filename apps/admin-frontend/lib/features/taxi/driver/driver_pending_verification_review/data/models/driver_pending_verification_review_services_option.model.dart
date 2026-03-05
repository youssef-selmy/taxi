import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/schema.graphql.dart';

part 'driver_pending_verification_review_services_option.model.freezed.dart';

@freezed
sealed class DriverPendingVerificationReviewServicesOptionModel
    with _$DriverPendingVerificationReviewServicesOptionModel {
  factory DriverPendingVerificationReviewServicesOptionModel({
    Enum$DeliveryPackageSize? maxDeliveryPackageSize,
    bool? isSelectedServiceOption,
  }) = _DriverPendingVerificationReviewServicesOptionModel;
}
