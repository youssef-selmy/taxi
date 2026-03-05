import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockTaxiPayoutSessionListItem1 = Fragment$taxiPayoutSessionListItem(
  id: "1",
  status: Enum$PayoutSessionStatus.PENDING,
  totalAmount: 5349123,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  driverTransactions: Fragment$taxiPayoutSessionListItem$driverTransactions(
    totalCount: 6,
    nodes: [
      Fragment$taxiPayoutSessionListItem$driverTransactions$nodes(
        driver: mockDriverName1,
      ),
      Fragment$taxiPayoutSessionListItem$driverTransactions$nodes(
        driver: mockDriverName5,
      ),
    ],
  ),
);

final mockTaxiPayoutSessionListItem2 = Fragment$taxiPayoutSessionListItem(
  id: "2",
  status: Enum$PayoutSessionStatus.PAID,
  totalAmount: 234123,
  currency: "EUR",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  driverTransactions: Fragment$taxiPayoutSessionListItem$driverTransactions(
    totalCount: 3,
    nodes: [
      Fragment$taxiPayoutSessionListItem$driverTransactions$nodes(
        driver: mockDriverName3,
      ),
      Fragment$taxiPayoutSessionListItem$driverTransactions$nodes(
        driver: mockDriverName2,
      ),
    ],
  ),
);

final mockTaxiPayoutSessionListItem3 = Fragment$taxiPayoutSessionListItem(
  id: "3",
  status: Enum$PayoutSessionStatus.FAILED,
  totalAmount: 123123,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  driverTransactions: Fragment$taxiPayoutSessionListItem$driverTransactions(
    totalCount: 6,
    nodes: [
      Fragment$taxiPayoutSessionListItem$driverTransactions$nodes(
        driver: mockDriverName4,
      ),
      Fragment$taxiPayoutSessionListItem$driverTransactions$nodes(
        driver: mockDriverName1,
      ),
    ],
  ),
);

final mockTaxiPayoutSessionListItem4 = Fragment$taxiPayoutSessionListItem(
  id: "4",
  status: Enum$PayoutSessionStatus.CANCELLED,
  totalAmount: 63331,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 4)),
  payoutMethods: [mockPayoutMethodCompact1],
  driverTransactions: Fragment$taxiPayoutSessionListItem$driverTransactions(
    totalCount: 6,
    nodes: [
      Fragment$taxiPayoutSessionListItem$driverTransactions$nodes(
        driver: mockDriverName1,
      ),
      Fragment$taxiPayoutSessionListItem$driverTransactions$nodes(
        driver: mockDriverName3,
      ),
    ],
  ),
);

final mockTaxiPayoutSessionListItems = [
  mockTaxiPayoutSessionListItem1,
  mockTaxiPayoutSessionListItem2,
  mockTaxiPayoutSessionListItem3,
  mockTaxiPayoutSessionListItem4,
];

final mockPayoutPayoutSessionDetail = Fragment$taxiPayoutSessionDetail(
  id: "1",
  totalAmount: 14223000,
  currency: "USD",
  status: Enum$PayoutSessionStatus.PENDING,
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  driversCount: [
    Fragment$taxiPayoutSessionDetail$driversCount(
      count: Fragment$taxiPayoutSessionDetail$driversCount$count(id: 100),
    ),
  ],
  payoutMethodDetails: [
    Fragment$taxiPayoutSessionPayoutMethodDetail(
      id: "1",
      payoutMethod: mockPayoutMethodCompact1,
      status: Enum$PayoutSessionStatus.PENDING,
      statistics: [
        Fragment$taxiPayoutSessionPayoutMethodDetail$statistics(
          count: Fragment$taxiPayoutSessionPayoutMethodDetail$statistics$count(
            id: 100,
          ),
          sum: Fragment$taxiPayoutSessionPayoutMethodDetail$statistics$sum(
            amount: 8522.23,
          ),
        ),
      ],
    ),
    Fragment$taxiPayoutSessionPayoutMethodDetail(
      id: "2",
      payoutMethod: mockPayoutMethodCompact2,
      status: Enum$PayoutSessionStatus.PAID,
      statistics: [
        Fragment$taxiPayoutSessionPayoutMethodDetail$statistics(
          count: Fragment$taxiPayoutSessionPayoutMethodDetail$statistics$count(
            id: 320,
          ),
          sum: Fragment$taxiPayoutSessionPayoutMethodDetail$statistics$sum(
            amount: 213.23,
          ),
        ),
      ],
    ),
  ],
  paidDrivers: [
    Fragment$taxiPayoutSessionDetail$paidDrivers(
      sum: Fragment$taxiPayoutSessionDetail$paidDrivers$sum(amount: 1525400),
    ),
  ],
  unpaidDrivers: [
    Fragment$taxiPayoutSessionDetail$unpaidDrivers(
      sum: Fragment$taxiPayoutSessionDetail$unpaidDrivers$sum(amount: 23112),
    ),
  ],
);
