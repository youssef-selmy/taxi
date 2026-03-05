import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';

final mockDriverDocument1 = Fragment$driverDocument(
  id: '1',
  title: 'Driver’s ID',
  notificationDaysBeforeExpiry: 3,
  numberOfImages: 2,
  isEnabled: true,
  isRequired: false,
  hasExpiryDate: true,
  retentionPolicies: mockRetentionPolicies,
);

final mockDriverDocument2 = Fragment$driverDocument(
  id: '1',
  title: 'Driver’s License',
  notificationDaysBeforeExpiry: 3,
  numberOfImages: 2,
  isEnabled: false,
  isRequired: true,
  hasExpiryDate: true,
  retentionPolicies: [mockRetentionPolicies1],
);

final mockDriverDocumentList = [mockDriverDocument1, mockDriverDocument2];

final mockRetentionPolicies1 = Fragment$driverDocumentRetentionPolicy(
  id: '1',
  deleteAfterDays: 3,
  title: 'Normal',
);

final mockRetentionPolicies2 = Fragment$driverDocumentRetentionPolicy(
  id: '2',
  deleteAfterDays: 6,
  title: 'High Risk',
);

final mockRetentionPolicies = [mockRetentionPolicies1, mockRetentionPolicies2];

final mockDriverToDriverDocument1 = Fragment$driverToDriverDocument(
  id: '1',
  driverDocument: mockDriverDocument1,
  media: ImageFaker().idCard.one.toMedia,
  retentionPolicy: mockRetentionPolicies1,
  expiresAt: DateTime.now().add(const Duration(days: 30)),
);
final mockDriverToDriverDocument2 = Fragment$driverToDriverDocument(
  id: '2',
  driverDocument: mockDriverDocument2,
  media: ImageFaker().idCard.one.toMedia,
  retentionPolicy: mockRetentionPolicies2,
  expiresAt: null,
);

final mockDriverToDriverDocuments = [
  mockDriverToDriverDocument1,
  mockDriverToDriverDocument2,
];
