import 'package:image_faker/image_faker.dart';
import 'package:time/time.dart';

import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';

final mockStaffRole1 = Fragment$staffRole(
  id: "1",
  title: "Admin",
  permissions: [],
  allowedApps: [],
  taxiPermissions: [],
  shopPermissions: [],
  parkingPermissions: [],
);

final mockStaffRole2 = Fragment$staffRole(
  id: "2",
  title: "Manager",
  permissions: [],
  allowedApps: [],
  taxiPermissions: [],
  shopPermissions: [],
  parkingPermissions: [],
);

final staffRoles = [mockStaffRole1, mockStaffRole2];

final mockStaffListItem1 = Fragment$staffListItem(
  id: "1",
  firstName: "Daniel",
  lastName: "Doe",
  mobileNumber: "16505551234",
  userName: "Danieldoe",
  isBlocked: true,
  media: ImageFaker().person.random().toMedia,
  role: mockStaffRole1,
  lastActivity: 30.minutes.ago,
);

final mockStaffListItem2 = Fragment$staffListItem(
  id: "2",
  firstName: "Jane",
  lastName: "Doe",
  mobileNumber: "14404441234",
  userName: "janedoe",
  isBlocked: false,
  media: ImageFaker().person.random().toMedia,
  role: mockStaffRole2,
  lastActivity: 4.days.ago,
);

final mockStaffListItem3 = Fragment$staffListItem(
  id: "2",
  firstName: "Jane",
  lastName: "Doe",
  mobileNumber: "14404441234",
  userName: "janedoe",
  isBlocked: false,
  media: ImageFaker().person.random().toMedia,
  role: mockStaffRole2,
  lastActivity: 32.days.ago,
);

final mockStaffList = [
  mockStaffListItem1,
  mockStaffListItem2,
  mockStaffListItem3,
];

final mockStaffDetails = Fragment$staffDetails(
  id: "1",
  firstName: "John",
  lastName: "Doe",
  mobileNumber: "16406503216",
  userName: "johndoe",
  email: "johndoe@gmial.com",
  isBlocked: false,
  media: ImageFaker().person.random().toMedia,
  role: mockStaffRole1,
  lastActivity: 10.minutes.ago,
);

final mockStaffSession1 = Fragment$staffSession(
  id: "1",
  sessionInfo: mockSessionInfo1,
);

final mockStaffSession2 = Fragment$staffSession(
  id: "2",
  sessionInfo: mockSessionInfo2,
);

final mockStaffSessionList = [mockStaffSession1, mockStaffSession2];
