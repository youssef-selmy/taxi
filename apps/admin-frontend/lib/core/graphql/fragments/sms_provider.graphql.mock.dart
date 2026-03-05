import 'package:admin_frontend/core/graphql/fragments/sms_provider.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockSmsProviderListItem1 = Fragment$smsProviderListItem(
  id: "1",
  name: "Twilio",
  type: Enum$SMSProviderType.Twilio,
  isDefault: true,
  messagesAggregate: [
    Fragment$smsProviderListItem$messagesAggregate(
      count: Fragment$smsProviderListItem$messagesAggregate$count(id: 100),
    ),
  ],
);

final mockSmsProviderListItem2 = Fragment$smsProviderListItem(
  id: "2",
  name: "Plivo",
  type: Enum$SMSProviderType.Plivo,
  isDefault: false,
  messagesAggregate: [
    Fragment$smsProviderListItem$messagesAggregate(
      count: Fragment$smsProviderListItem$messagesAggregate$count(id: 100),
    ),
  ],
);

final mockSmsProviderListItem3 = Fragment$smsProviderListItem(
  id: "3",
  name: "Vonage",
  type: Enum$SMSProviderType.Vonage,
  isDefault: false,
  messagesAggregate: [
    Fragment$smsProviderListItem$messagesAggregate(
      count: Fragment$smsProviderListItem$messagesAggregate$count(id: 100),
    ),
  ],
);

final mockSmsProviderList = [
  mockSmsProviderListItem1,
  mockSmsProviderListItem2,
  mockSmsProviderListItem3,
];

final mockSmsProviderDetails = Fragment$smsProviderDetails(
  id: "1",
  name: "Twilio",
  type: Enum$SMSProviderType.Twilio,
  isDefault: true,
  accountId: "accountId",
  authToken: "authToken",
  smsType: "smsType",
  verificationTemplate: "Your verification code is {code}",
);
