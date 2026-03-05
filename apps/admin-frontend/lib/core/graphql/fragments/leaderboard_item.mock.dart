import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';

final mockLeaderboardItem1 = Fragment$leaderboardItem(
  id: "1",
  name: "John Doe",
  avatarUrl: ImageFaker().person.random(),
  totalAmount: 653413,
  totalCount: 4324,
);

final mockLeaderboardItem2 = Fragment$leaderboardItem(
  id: "2",
  name: "Jane Doe",
  avatarUrl: ImageFaker().person.random(),
  totalAmount: 54321,
  totalCount: 123,
);

final mockLeaderboardItem3 = Fragment$leaderboardItem(
  id: "3",
  name: "John Smith",
  avatarUrl: ImageFaker().person.random(),
  totalAmount: 123456,
  totalCount: 543,
);

final mockLeaderboardItem4 = Fragment$leaderboardItem(
  id: "4",
  name: "Jane Smith",
  avatarUrl: ImageFaker().person.random(),
  totalAmount: 654321,
  totalCount: 321,
);

final mockLeaderboardItem5 = Fragment$leaderboardItem(
  id: "5",
  name: "John Johnson",
  avatarUrl: ImageFaker().person.random(),
  totalAmount: 987654,
  totalCount: 654,
);

final mockLeaderboardItem6 = Fragment$leaderboardItem(
  id: "6",
  name: "Jane Johnson",
  avatarUrl: ImageFaker().person.random().toMedia.address,
  totalAmount: 1234567,
  totalCount: 765,
);

final mockLeaderboardItem7 = Fragment$leaderboardItem(
  id: "7",
  name: "John Jackson",
  avatarUrl: ImageFaker().person.random().toMedia.address,
  totalAmount: 7654321,
  totalCount: 876,
);

final mockLeaderboardItem8 = Fragment$leaderboardItem(
  id: "8",
  name: "Jane Jackson",
  avatarUrl: ImageFaker().person.random().toMedia.address,
  totalAmount: 8765432,
  totalCount: 987,
);

final mockLeaderboardItem9 = Fragment$leaderboardItem(
  id: "9",
  name: "John Doe",
  avatarUrl: ImageFaker().person.random().toMedia.address,
  totalAmount: 653413,
  totalCount: 4324,
);

final mockLeaderboardItem10 = Fragment$leaderboardItem(
  id: "10",
  name: "Jane Doe",
  avatarUrl: ImageFaker().person.random(),
  totalAmount: 54321,
  totalCount: 123,
);

final mockLeaderboardItems = [
  mockLeaderboardItem1,
  mockLeaderboardItem2,
  mockLeaderboardItem3,
  mockLeaderboardItem4,
  mockLeaderboardItem5,
  mockLeaderboardItem6,
  mockLeaderboardItem7,
  mockLeaderboardItem8,
  mockLeaderboardItem9,
  mockLeaderboardItem10,
];
