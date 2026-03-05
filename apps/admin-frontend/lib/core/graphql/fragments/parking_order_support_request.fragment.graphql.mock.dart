import 'package:admin_frontend/core/graphql/fragments/parking_order_support_request.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockParkingOrderSupportRequest1 = Fragment$parkingOrderSupportRequest(
  id: '1',
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ComplaintStatus.Submitted,
  subject: 'Bad Driving',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);
final mockParkingOrderSupportRequest2 = Fragment$parkingOrderSupportRequest(
  id: '2',
  createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  status: Enum$ComplaintStatus.Submitted,
  subject: 'Good Driving',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
);

final mockParkingOrderSupportRequestList = [
  mockParkingOrderSupportRequest1,
  mockParkingOrderSupportRequest2,
];
