import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockCancelReasonTaxiCustomer1 = Fragment$cancelReason(
  id: '1',
  title: 'Delay',
  isEnabled: true,
  userType: Enum$AnnouncementUserType.Rider,
  ordersAggregate: [
    Fragment$cancelReason$ordersAggregate(
      count: Fragment$cancelReason$ordersAggregate$count(id: 40),
    ),
  ],
);

final mockCancelReasonTaxiCustomer2 = Fragment$cancelReason(
  id: '2',
  title: 'I feel unsafe',
  isEnabled: true,
  userType: Enum$AnnouncementUserType.Rider,
  ordersAggregate: [
    Fragment$cancelReason$ordersAggregate(
      count: Fragment$cancelReason$ordersAggregate$count(id: 10),
    ),
  ],
);

final mockCancelReasonTaxiCustomer3 = Fragment$cancelReason(
  id: '3',
  title: 'Car condition',
  isEnabled: true,
  userType: Enum$AnnouncementUserType.Rider,
  ordersAggregate: [
    Fragment$cancelReason$ordersAggregate(
      count: Fragment$cancelReason$ordersAggregate$count(id: 46),
    ),
  ],
);

final mockCancelReasonTaxiCustomer4 = Fragment$cancelReason(
  id: '4',
  title: 'Driver behavior',
  isEnabled: true,
  userType: Enum$AnnouncementUserType.Rider,
  ordersAggregate: [
    Fragment$cancelReason$ordersAggregate(
      count: Fragment$cancelReason$ordersAggregate$count(id: 47),
    ),
  ],
);

final mockCancelReasonTaxiDriver1 = Fragment$cancelReason(
  id: '5',
  title: 'Delay',
  isEnabled: true,
  userType: Enum$AnnouncementUserType.Driver,
  ordersAggregate: [
    Fragment$cancelReason$ordersAggregate(
      count: Fragment$cancelReason$ordersAggregate$count(id: 64),
    ),
  ],
);

final mockCancelReasonTaxiDriver2 = Fragment$cancelReason(
  id: '6',
  title: 'I feel unsafe',
  isEnabled: true,
  userType: Enum$AnnouncementUserType.Driver,
  ordersAggregate: [
    Fragment$cancelReason$ordersAggregate(
      count: Fragment$cancelReason$ordersAggregate$count(id: 86),
    ),
  ],
);

final mockCancelReasonTaxiDriver3 = Fragment$cancelReason(
  id: '7',
  title: 'Rider behavior',
  isEnabled: true,
  userType: Enum$AnnouncementUserType.Driver,
  ordersAggregate: [
    Fragment$cancelReason$ordersAggregate(
      count: Fragment$cancelReason$ordersAggregate$count(id: 94),
    ),
  ],
);

final mockCancelReasonTaxiDriver4 = Fragment$cancelReason(
  id: '8',
  title: 'Trouble with the car',
  isEnabled: true,
  userType: Enum$AnnouncementUserType.Driver,
  ordersAggregate: [
    Fragment$cancelReason$ordersAggregate(
      count: Fragment$cancelReason$ordersAggregate$count(id: 45),
    ),
  ],
);

final mockCancelReasonTaxiCustomer = [
  mockCancelReasonTaxiCustomer1,
  mockCancelReasonTaxiCustomer2,
  mockCancelReasonTaxiCustomer3,
  mockCancelReasonTaxiCustomer4,
];

final mockCancelReasonTaxiDriver = [
  mockCancelReasonTaxiDriver1,
  mockCancelReasonTaxiDriver2,
  mockCancelReasonTaxiDriver3,
  mockCancelReasonTaxiDriver4,
];

final mockCancelReasonTaxi = [
  ...mockCancelReasonTaxiCustomer,
  ...mockCancelReasonTaxiDriver,
];
