import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension DriverDocumentFragmentX on Fragment$driverDocument {
  Input$DriverDocumentInput toInput() => Input$DriverDocumentInput(
    title: title,
    numberOfImages: numberOfImages,
    notificationDaysBeforeExpiry: notificationDaysBeforeExpiry,
    hasExpiryDate: hasExpiryDate,
    isEnabled: isEnabled,
    isRequired: isRequired,
  );
}

extension DriverDocumentRetentionPolicyFragmentX
    on Fragment$driverDocumentRetentionPolicy {
  Input$DriverDocumentRetentionPolicyInput toInput(String documentId) =>
      Input$DriverDocumentRetentionPolicyInput(
        title: title,
        deleteAfterDays: deleteAfterDays,
        driverDocumentId: documentId,
      );
}
