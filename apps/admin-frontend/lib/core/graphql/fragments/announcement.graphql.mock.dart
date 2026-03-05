import 'package:admin_frontend/core/graphql/fragments/announcement.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockAnnouncementListItem1 = Fragment$announcementListItem(
  id: "1",
  title: "Announcement 1",
  appType: Enum$AppType.Taxi,
  startAt: DateTime(2024, 3, 1),
  expireAt: DateTime(2025, 12, 1),
  userType: [Enum$AnnouncementUserType.Driver],
);

final mockAnnouncementListItem2 = Fragment$announcementListItem(
  id: "2",
  title: "Announcement 2",
  appType: Enum$AppType.Taxi,
  startAt: DateTime(2024, 3, 1),
  expireAt: DateTime(2025, 12, 1),
  userType: [Enum$AnnouncementUserType.Rider],
);

final mockAnnouncementList = [
  mockAnnouncementListItem1,
  mockAnnouncementListItem2,
];

final mockAnnouncementDetails = Fragment$announcementDetails(
  id: "1",
  title: "Announcement 1",
  appType: Enum$AppType.Taxi,
  description: "Description",
  startAt: DateTime(2024, 3, 1),
  expireAt: DateTime(2025, 12, 1),
  userType: [Enum$AnnouncementUserType.Driver],
);
