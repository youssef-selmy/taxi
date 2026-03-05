import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockShopPayoutSessionListItem1 = Fragment$shopPayoutSessionListItem(
  id: "1",
  status: Enum$PayoutSessionStatus.PENDING,
  totalAmount: 5349123,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  shopTransactions: Fragment$shopPayoutSessionListItem$shopTransactions(
    totalCount: 6,
    nodes: [
      Fragment$shopPayoutSessionListItem$shopTransactions$nodes(
        shop: mockShopBasicInfo1,
      ),
      Fragment$shopPayoutSessionListItem$shopTransactions$nodes(
        shop: mockShopBasicInfo2,
      ),
    ],
  ),
);

final mockShopPayoutSessionListItem2 = Fragment$shopPayoutSessionListItem(
  id: "2",
  status: Enum$PayoutSessionStatus.PAID,
  totalAmount: 234123,
  currency: "EUR",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  shopTransactions: Fragment$shopPayoutSessionListItem$shopTransactions(
    totalCount: 3,
    nodes: [
      Fragment$shopPayoutSessionListItem$shopTransactions$nodes(
        shop: mockShopBasicInfo1,
      ),
      Fragment$shopPayoutSessionListItem$shopTransactions$nodes(
        shop: mockShopBasicInfo2,
      ),
    ],
  ),
);

final mockShopPayoutSessionListItem3 = Fragment$shopPayoutSessionListItem(
  id: "3",
  status: Enum$PayoutSessionStatus.FAILED,
  totalAmount: 123123,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  shopTransactions: Fragment$shopPayoutSessionListItem$shopTransactions(
    totalCount: 6,
    nodes: [
      Fragment$shopPayoutSessionListItem$shopTransactions$nodes(
        shop: mockShopBasicInfo1,
      ),
      Fragment$shopPayoutSessionListItem$shopTransactions$nodes(
        shop: mockShopBasicInfo2,
      ),
    ],
  ),
);

final mockShopPayoutSessionListItem4 = Fragment$shopPayoutSessionListItem(
  id: "4",
  status: Enum$PayoutSessionStatus.CANCELLED,
  totalAmount: 63331,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 4)),
  payoutMethods: [mockPayoutMethodCompact1],
  shopTransactions: Fragment$shopPayoutSessionListItem$shopTransactions(
    totalCount: 6,
    nodes: [
      Fragment$shopPayoutSessionListItem$shopTransactions$nodes(
        shop: mockShopBasicInfo1,
      ),
      Fragment$shopPayoutSessionListItem$shopTransactions$nodes(
        shop: mockShopBasicInfo2,
      ),
    ],
  ),
);

final mockShopPayoutSessionListItems = [
  mockShopPayoutSessionListItem1,
  mockShopPayoutSessionListItem2,
  mockShopPayoutSessionListItem3,
  mockShopPayoutSessionListItem4,
];

final mockPayoutPayoutSessionDetail = Fragment$shopPayoutSessionDetail(
  id: "1",
  totalAmount: 14223000,
  currency: "USD",
  status: Enum$PayoutSessionStatus.PENDING,
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  shopsCount: [
    Fragment$shopPayoutSessionDetail$shopsCount(
      count: Fragment$shopPayoutSessionDetail$shopsCount$count(id: 100),
    ),
  ],
  payoutMethodDetails: [
    Fragment$shopPayoutSessionPayoutMethodDetail(
      id: "1",
      payoutMethod: mockPayoutMethodCompact1,
      status: Enum$PayoutSessionStatus.PENDING,
      statistics: [
        Fragment$shopPayoutSessionPayoutMethodDetail$statistics(
          count: Fragment$shopPayoutSessionPayoutMethodDetail$statistics$count(
            id: 100,
          ),
          sum: Fragment$shopPayoutSessionPayoutMethodDetail$statistics$sum(
            amount: 8522.23,
          ),
        ),
      ],
    ),
    Fragment$shopPayoutSessionPayoutMethodDetail(
      id: "2",
      payoutMethod: mockPayoutMethodCompact2,
      status: Enum$PayoutSessionStatus.PAID,
      statistics: [
        Fragment$shopPayoutSessionPayoutMethodDetail$statistics(
          count: Fragment$shopPayoutSessionPayoutMethodDetail$statistics$count(
            id: 320,
          ),
          sum: Fragment$shopPayoutSessionPayoutMethodDetail$statistics$sum(
            amount: 213.23,
          ),
        ),
      ],
    ),
  ],
  paidShops: [
    Fragment$shopPayoutSessionDetail$paidShops(
      sum: Fragment$shopPayoutSessionDetail$paidShops$sum(amount: 1525400),
    ),
  ],
  unpaidShops: [
    Fragment$shopPayoutSessionDetail$unpaidShops(
      sum: Fragment$shopPayoutSessionDetail$unpaidShops$sum(amount: 23112),
    ),
  ],
);
