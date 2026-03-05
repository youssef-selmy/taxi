import 'package:admin_frontend/core/graphql/fragments/customer_session.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.mock.dart';

final mockCustomerSession1 = Fragment$customerSession(
  id: "1",
  sessionInfo: mockSessionInfo1,
);

final mockCustomerSession2 = Fragment$customerSession(
  id: "2",
  sessionInfo: mockSessionInfo2,
);

final mockCustomerSession3 = Fragment$customerSession(
  id: "3",
  sessionInfo: mockSessionInfo3,
);

final mockCustomerSessions = [
  mockCustomerSession1,
  mockCustomerSession2,
  mockCustomerSession3,
];
