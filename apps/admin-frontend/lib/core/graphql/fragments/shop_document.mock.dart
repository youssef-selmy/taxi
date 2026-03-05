import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_document.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';

final mockShopDocument1 = Fragment$shopDocument(
  id: '1',
  title: 'Shop’s ID',
  notificationDaysBeforeExpiry: 3,
  isEnabled: true,
  isRequired: false,
  hasExpiryDate: true,
  retentionPolicies: mockRetentionPolicies,
);

final mockShopDocument2 = Fragment$shopDocument(
  id: '1',
  title: 'Shop’s License',
  notificationDaysBeforeExpiry: 3,
  isEnabled: false,
  isRequired: true,
  hasExpiryDate: true,
  retentionPolicies: [mockRetentionPolicies1],
);

final mockShopDocumentList = [mockShopDocument1, mockShopDocument2];

final mockRetentionPolicies1 = Fragment$shopDocumentRetentionPolicy(
  id: '1',
  deleteAfterDays: 3,
  title: 'Normal',
);

final mockRetentionPolicies2 = Fragment$shopDocumentRetentionPolicy(
  id: '2',
  deleteAfterDays: 6,
  title: 'High Risk',
);

final mockRetentionPolicies = [mockRetentionPolicies1, mockRetentionPolicies2];

final mockShopToShopDocument1 = Fragment$shopToShopDocument(
  id: '1',
  shopDocument: mockShopDocument1,
  media: ImageFaker().idCard.one.toMedia,
  retentionPolicy: mockRetentionPolicies1,
  expiresAt: DateTime.now().add(const Duration(days: 30)),
);
final mockShopToShopDocument2 = Fragment$shopToShopDocument(
  id: '2',
  shopDocument: mockShopDocument2,
  media: ImageFaker().idCard.one.toMedia,
  retentionPolicy: mockRetentionPolicies2,
  expiresAt: null,
);

final mockShopToShopDocuments = [
  mockShopToShopDocument1,
  mockShopToShopDocument2,
];
