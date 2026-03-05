import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/profile.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockProfileRole = Fragment$profileRole(
  id: "1",
  title: "Admin",
  permissions: Enum$OperatorPermission.values,
  taxiPermissions: Enum$TaxiPermission.values,
  shopPermissions: Enum$ShopPermission.values,
  parkingPermissions: Enum$ParkingPermission.values,
  allowedApps: [Enum$AppType.Taxi, Enum$AppType.Shop, Enum$AppType.Parking],
);

final mockProfile = Fragment$profile(
  id: "1",
  firstName: "John",
  lastName: "Doe",
  mobileNumber: "1234567890",
  media: ImageFaker().person.random().toMedia,
  role: mockProfileRole,
  userName: "johndoe",
  email: "john@doe.com",
);
