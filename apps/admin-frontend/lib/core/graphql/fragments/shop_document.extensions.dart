import 'package:admin_frontend/core/graphql/fragments/shop_document.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ShopDocumentFragmentX on Fragment$shopDocument {
  Input$ShopDocumentInput toInput() => Input$ShopDocumentInput(
    title: title,
    notificationDaysBeforeExpiry: notificationDaysBeforeExpiry,
    hasExpiryDate: hasExpiryDate,
    isEnabled: isEnabled,
    isRequired: isRequired,
  );
}

extension ShopDocumentRetentionPolicyFragmentX
    on Fragment$shopDocumentRetentionPolicy {
  Input$ShopDocumentRetentionPolicyInput toInput(String documentId) =>
      Input$ShopDocumentRetentionPolicyInput(
        title: title,
        deleteAfterDays: deleteAfterDays,
        shopDocumentId: documentId,
      );
}
