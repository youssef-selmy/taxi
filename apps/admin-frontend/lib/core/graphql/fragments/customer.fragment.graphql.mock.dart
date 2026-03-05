import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockCustomerListItem1 = Fragment$CustomerListItem(
  id: "1",
  firstName: "Kaylynn",
  lastName: "Rosser",
  mobileNumber: "16505551234",
  orderCount: [
    Fragment$CustomerListItem$orderCount(
      count: Fragment$CustomerListItem$orderCount$count(id: 254),
    ),
  ],
  status: Enum$RiderStatus.Enabled,
  wallet: mockCustomerWallets,
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerListItem2 = Fragment$CustomerListItem(
  id: "2",
  firstName: "Skylar",
  lastName: "Bergson",
  mobileNumber: "16505551235",
  orderCount: [
    Fragment$CustomerListItem$orderCount(
      count: Fragment$CustomerListItem$orderCount$count(id: 254),
    ),
  ],
  status: Enum$RiderStatus.Enabled,
  wallet: mockCustomerWallets,
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerListItem3 = Fragment$CustomerListItem(
  id: "3",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551236",
  status: Enum$RiderStatus.Enabled,
  orderCount: [
    Fragment$CustomerListItem$orderCount(
      count: Fragment$CustomerListItem$orderCount$count(id: 254),
    ),
  ],
  wallet: mockCustomerWallets,
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerListItem4 = Fragment$CustomerListItem(
  id: "4",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551237",
  status: Enum$RiderStatus.Disabled,
  orderCount: [
    Fragment$CustomerListItem$orderCount(
      count: Fragment$CustomerListItem$orderCount$count(id: 254),
    ),
  ],
  wallet: mockCustomerWallets,
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerListItem5 = Fragment$CustomerListItem(
  id: "5",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551238",
  status: Enum$RiderStatus.Enabled,
  orderCount: [
    Fragment$CustomerListItem$orderCount(
      count: Fragment$CustomerListItem$orderCount$count(id: 254),
    ),
  ],
  wallet: mockCustomerWallets,
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerListItem6 = Fragment$CustomerListItem(
  id: "6",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551239",
  status: Enum$RiderStatus.Disabled,
  orderCount: [
    Fragment$CustomerListItem$orderCount(
      count: Fragment$CustomerListItem$orderCount$count(id: 254),
    ),
  ],
  wallet: mockCustomerWallets,
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerListItem7 = Fragment$CustomerListItem(
  id: "7",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551240",
  status: Enum$RiderStatus.Enabled,
  orderCount: [
    Fragment$CustomerListItem$orderCount(
      count: Fragment$CustomerListItem$orderCount$count(id: 254),
    ),
  ],
  wallet: mockCustomerWallets,
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerListItem8 = Fragment$CustomerListItem(
  id: "8",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551241",
  status: Enum$RiderStatus.Enabled,
  orderCount: [
    Fragment$CustomerListItem$orderCount(
      count: Fragment$CustomerListItem$orderCount$count(id: 254),
    ),
  ],
  wallet: mockCustomerWallets,
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerListItems = [
  mockCustomerListItem1,
  mockCustomerListItem2,
  mockCustomerListItem3,
  mockCustomerListItem4,
  mockCustomerListItem5,
  mockCustomerListItem6,
  mockCustomerListItem7,
  mockCustomerListItem8,
];

final mockCustomerCompact1 = Fragment$CustomerCompact(
  id: "1",
  firstName: "Kaylynn",
  lastName: "Rosser",
  mobileNumber: "16505551234",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerCompact2 = Fragment$CustomerCompact(
  id: "2",
  firstName: "Skylar",
  lastName: "Bergson",
  mobileNumber: "16505551235",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerCompact3 = Fragment$CustomerCompact(
  id: "3",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551236",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerCompact4 = Fragment$CustomerCompact(
  id: "4",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551237",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerCompact5 = Fragment$CustomerCompact(
  id: "5",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551238",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerCompact6 = Fragment$CustomerCompact(
  id: "6",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551239",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerCompact7 = Fragment$CustomerCompact(
  id: "7",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551240",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerCompact8 = Fragment$CustomerCompact(
  id: "8",
  firstName: "Kai",
  lastName: "Bergson",
  mobileNumber: "16505551241",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomerCompacts = [
  mockCustomerCompact1,
  mockCustomerCompact2,
  mockCustomerCompact3,
  mockCustomerCompact4,
  mockCustomerCompact5,
  mockCustomerCompact6,
  mockCustomerCompact7,
  mockCustomerCompact8,
];

final mockCustomerDetail = Fragment$customerDetails(
  id: "1",
  registrationTimestamp: DateTime.now().subtract(const Duration(days: 532)),
  lastActivityAt: DateTime.now().subtract(const Duration(hours: 2)),
  status: Enum$RiderStatus.Enabled,
  mobileNumber: "16505551234",
  firstName: "Kaylynn",
  lastName: "Rosser",
  email: "kay@rose.com",
  countryIso: "US",
  media: ImageFaker().person.random().toMedia,
);

final mockCustomer1 = Fragment$CustomerListItem(
  id: '1',
  mobileNumber: '123456778',
  status: Enum$RiderStatus.Enabled,
  countryIso: '98',
  firstName: 'john',
  lastName: 'doe',
  lastActivityAt: DateTime.now().subtract(const Duration(minutes: 10)),
  orderCount: [],
  media: ImageFaker().person.random().toMedia,
  wallet: mockCustomerWallets,
);
final mockCustomer2 = Fragment$CustomerListItem(
  id: '2',
  mobileNumber: '123456778',
  status: Enum$RiderStatus.Enabled,
  countryIso: '98',
  firstName: 'john',
  lastName: 'doe',
  lastActivityAt: DateTime.now().subtract(const Duration(minutes: 10)),
  orderCount: [],
  media: ImageFaker().person.random().toMedia,
  wallet: mockCustomerWallets,
);
final mockCustomer3 = Fragment$CustomerListItem(
  id: '3',
  mobileNumber: '123456778',
  status: Enum$RiderStatus.Enabled,
  countryIso: '98',
  firstName: 'john',
  lastName: 'doe',
  lastActivityAt: DateTime.now().subtract(const Duration(minutes: 10)),
  orderCount: [],
  media: ImageFaker().person.random().toMedia,
  wallet: mockCustomerWallets,
);
final mockCustomer4 = Fragment$CustomerListItem(
  id: '4',
  mobileNumber: '123456778',
  status: Enum$RiderStatus.Enabled,
  countryIso: '98',
  firstName: 'john',
  lastName: 'doe',
  lastActivityAt: DateTime.now().subtract(const Duration(minutes: 10)),
  orderCount: [],
  media: ImageFaker().person.random().toMedia,
  wallet: mockCustomerWallets,
);

final mockCustomersList = [
  mockCustomer1,
  mockCustomer2,
  mockCustomer3,
  mockCustomer4,
];
