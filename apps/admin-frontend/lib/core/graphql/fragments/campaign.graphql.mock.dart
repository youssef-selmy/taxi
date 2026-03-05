import 'package:admin_frontend/core/graphql/fragments/campaign.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockCampaignListItem1 = Fragment$campaignListItem(
  id: "1",
  name: "Campaign 1",
  isEnabled: true,
  startAt: DateTime.now().subtract(const Duration(days: 1)),
  expireAt: DateTime.now().add(const Duration(days: 1)),
  appType: [Enum$AppType.Taxi, Enum$AppType.Shop],
  codesAggregate: [
    Fragment$campaignListItem$codesAggregate(
      count: Fragment$campaignListItem$codesAggregate$count(id: 10),
    ),
  ],
);

final mockCampaignListItem2 = Fragment$campaignListItem(
  id: "2",
  name: "Campaign 2",
  isEnabled: false,
  startAt: DateTime.now().subtract(const Duration(days: 30)),
  expireAt: DateTime.now().subtract(const Duration(days: 2)),
  appType: [Enum$AppType.Taxi],
  codesAggregate: [
    Fragment$campaignListItem$codesAggregate(
      count: Fragment$campaignListItem$codesAggregate$count(id: 20),
    ),
  ],
);

final mockCampaignListItem3 = Fragment$campaignListItem(
  id: "3",
  name: "Campaign 3",
  isEnabled: true,
  startAt: DateTime.now().add(const Duration(days: 3)),
  expireAt: DateTime.now().add(const Duration(days: 40)),
  appType: [Enum$AppType.Shop],
  codesAggregate: [
    Fragment$campaignListItem$codesAggregate(
      count: Fragment$campaignListItem$codesAggregate$count(id: 30),
    ),
  ],
);

final mockCampaignListItems = [
  mockCampaignListItem1,
  mockCampaignListItem2,
  mockCampaignListItem3,
];

final mockCampaignDetails = Fragment$campaignDetails(
  id: "1",
  name: "Campaign 1",
  appType: [Enum$AppType.Taxi, Enum$AppType.Shop],
  isEnabled: true,
  manyTimesUserCanUse: 10,
  discountFlat: 10,
  discountPercent: 10,
  minimumCost: 5,
  maximumCost: 15,
  manyUsersCanUse: 1,
  currency: "USD",
  startAt: DateTime.now().subtract(const Duration(days: 1)),
  expireAt: DateTime.now().add(const Duration(days: 1)),
  usedCodesCount: [
    Fragment$campaignDetails$usedCodesCount(
      count: Fragment$campaignDetails$usedCodesCount$count(id: 30),
    ),
  ],
  unusedCodesCount: [
    Fragment$campaignDetails$unusedCodesCount(
      count: Fragment$campaignDetails$unusedCodesCount$count(id: 40),
    ),
  ],
);

final mockCampaignCode1 = Fragment$campaignCode(id: "1", code: "CODE1");

final mockCampaignCode2 = Fragment$campaignCode(id: "2", code: "CODE2");

final mockCampaignCode3 = Fragment$campaignCode(id: "3", code: "CODE3");

final mockCampaignCodes = [
  mockCampaignCode1,
  mockCampaignCode2,
  mockCampaignCode3,
];
