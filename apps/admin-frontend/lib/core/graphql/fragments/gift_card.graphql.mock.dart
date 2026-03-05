import 'package:admin_frontend/core/graphql/fragments/gift_card.graphql.dart';

final mockGiftBatchListItem1 = Fragment$giftBatchListItem(
  id: "1",
  name: "Gift Card",
  amount: 150,
  currency: "USD",
  giftCodesAggregate: [
    Fragment$giftBatchListItem$giftCodesAggregate(
      count: Fragment$giftBatchListItem$giftCodesAggregate$count(id: 10),
    ),
  ],
);

final mockGiftBatchListItem2 = Fragment$giftBatchListItem(
  id: "2",
  name: "Gift Card",
  amount: 200,
  currency: "USD",
  giftCodesAggregate: [
    Fragment$giftBatchListItem$giftCodesAggregate(
      count: Fragment$giftBatchListItem$giftCodesAggregate$count(id: 20),
    ),
  ],
);

final mockGiftBatchList = [mockGiftBatchListItem1, mockGiftBatchListItem2];

final mockGiftBatchDetails = Fragment$giftBatchDetails(
  id: "1",
  name: "Batch Jan 2024, 1",
  amount: 100,
  currency: "USD",
  usedCodesCount: [
    Fragment$giftBatchDetails$usedCodesCount(
      count: Fragment$giftBatchDetails$usedCodesCount$count(id: 30),
    ),
  ],
  unusedCodesCount: [
    Fragment$giftBatchDetails$unusedCodesCount(
      count: Fragment$giftBatchDetails$unusedCodesCount$count(id: 40),
    ),
  ],
);

final mockGiftCodeItem1 = Fragment$giftCode(
  id: "1",
  code: "1234567890",
  usedAt: null,
);

final mockGiftCodeItem2 = Fragment$giftCode(
  id: "2",
  code: "0987654321",
  usedAt: DateTime.now().subtract(const Duration(days: 1)),
);

final mockGiftCodeItems = [mockGiftCodeItem1, mockGiftCodeItem2];
