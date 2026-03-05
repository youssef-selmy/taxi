import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockParkingPayoutSessionListItem1 = Fragment$parkingPayoutSessionListItem(
  id: "1",
  status: Enum$PayoutSessionStatus.PENDING,
  totalAmount: 5349123,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  parkingTransactions:
      Fragment$parkingPayoutSessionListItem$parkingTransactions(
        totalCount: 6,
        nodes: [
          Fragment$parkingPayoutSessionListItem$parkingTransactions$nodes(
            customer: mockCustomerCompact1,
          ),
          Fragment$parkingPayoutSessionListItem$parkingTransactions$nodes(
            customer: mockCustomerCompact3,
          ),
        ],
      ),
);

final mockParkingPayoutSessionListItem2 = Fragment$parkingPayoutSessionListItem(
  id: "2",
  status: Enum$PayoutSessionStatus.PAID,
  totalAmount: 234123,
  currency: "EUR",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  parkingTransactions:
      Fragment$parkingPayoutSessionListItem$parkingTransactions(
        totalCount: 3,
        nodes: [
          Fragment$parkingPayoutSessionListItem$parkingTransactions$nodes(
            customer: mockCustomerCompact2,
          ),
          Fragment$parkingPayoutSessionListItem$parkingTransactions$nodes(
            customer: mockCustomerCompact4,
          ),
        ],
      ),
);

final mockParkingPayoutSessionListItem3 = Fragment$parkingPayoutSessionListItem(
  id: "3",
  status: Enum$PayoutSessionStatus.FAILED,
  totalAmount: 123123,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  payoutMethods: [mockPayoutMethodCompact1],
  parkingTransactions:
      Fragment$parkingPayoutSessionListItem$parkingTransactions(
        totalCount: 6,
        nodes: [
          Fragment$parkingPayoutSessionListItem$parkingTransactions$nodes(
            customer: mockCustomerCompact4,
          ),
          Fragment$parkingPayoutSessionListItem$parkingTransactions$nodes(
            customer: mockCustomerCompact7,
          ),
        ],
      ),
);

final mockParkingPayoutSessionListItem4 = Fragment$parkingPayoutSessionListItem(
  id: "4",
  status: Enum$PayoutSessionStatus.CANCELLED,
  totalAmount: 63331,
  currency: "USD",
  createdAt: DateTime.now().subtract(const Duration(days: 4)),
  payoutMethods: [mockPayoutMethodCompact1],
  parkingTransactions:
      Fragment$parkingPayoutSessionListItem$parkingTransactions(
        totalCount: 6,
        nodes: [
          Fragment$parkingPayoutSessionListItem$parkingTransactions$nodes(
            customer: mockCustomerCompact5,
          ),
          Fragment$parkingPayoutSessionListItem$parkingTransactions$nodes(
            customer: mockCustomerCompact7,
          ),
        ],
      ),
);

final mockParkingPayoutSessionListItems = [
  mockParkingPayoutSessionListItem1,
  mockParkingPayoutSessionListItem2,
  mockParkingPayoutSessionListItem3,
  mockParkingPayoutSessionListItem4,
];

final mockPayoutPayoutSessionDetail = Fragment$parkingPayoutSessionDetail(
  id: "1",
  totalAmount: 14223000,
  currency: "USD",
  status: Enum$PayoutSessionStatus.PENDING,
  createdAt: DateTime.now().subtract(const Duration(days: 8)),
  parkingCount: [
    Fragment$parkingPayoutSessionDetail$parkingCount(
      count: Fragment$parkingPayoutSessionDetail$parkingCount$count(id: 100),
    ),
  ],
  payoutMethodDetails: [
    Fragment$parkingPayoutSessionPayoutMethodDetail(
      id: "1",
      payoutMethod: mockPayoutMethodCompact1,
      status: Enum$PayoutSessionStatus.PENDING,
      statistics: [
        Fragment$parkingPayoutSessionPayoutMethodDetail$statistics(
          count:
              Fragment$parkingPayoutSessionPayoutMethodDetail$statistics$count(
                id: 100,
              ),
          sum: Fragment$parkingPayoutSessionPayoutMethodDetail$statistics$sum(
            amount: 8522.23,
          ),
        ),
      ],
    ),
    Fragment$parkingPayoutSessionPayoutMethodDetail(
      id: "2",
      payoutMethod: mockPayoutMethodCompact2,
      status: Enum$PayoutSessionStatus.PAID,
      statistics: [
        Fragment$parkingPayoutSessionPayoutMethodDetail$statistics(
          count:
              Fragment$parkingPayoutSessionPayoutMethodDetail$statistics$count(
                id: 320,
              ),
          sum: Fragment$parkingPayoutSessionPayoutMethodDetail$statistics$sum(
            amount: 213.23,
          ),
        ),
      ],
    ),
  ],
  paidParkings: [
    Fragment$parkingPayoutSessionDetail$paidParkings(
      sum: Fragment$parkingPayoutSessionDetail$paidParkings$sum(
        amount: 1525400,
      ),
    ),
  ],
  unpaidParkings: [
    Fragment$parkingPayoutSessionDetail$unpaidParkings(
      sum: Fragment$parkingPayoutSessionDetail$unpaidParkings$sum(
        amount: 23112,
      ),
    ),
  ],
);
