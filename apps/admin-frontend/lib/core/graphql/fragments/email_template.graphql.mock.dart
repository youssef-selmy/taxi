import 'package:admin_frontend/core/graphql/fragments/email_template.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockEmailTemplateDetails = Fragment$emailTemplateDetails(
  id: '1',
  name: 'Driver Approved Email',
  eventType: Enum$EmailEventType.DRIVER_APPROVED,
  subject: 'Congratulations! Your driver application has been approved',
  contentSource: Enum$EmailContentSource.Inline,
  bodyHtml: '''
<html>
<body>
  <h1>Welcome, {firstName}!</h1>
  <p>Your driver application has been approved. You can now start accepting rides.</p>
  <p>Best regards,<br>The Team</p>
</body>
</html>
''',
  bodyPlainText:
      'Welcome, {firstName}! Your driver application has been approved.',
  providerTemplateId: null,
  isActive: true,
  locale: null,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final mockEmailTemplateList = [
  Fragment$emailTemplateListItem(
    id: '1',
    name: 'Driver Approved Email',
    eventType: Enum$EmailEventType.DRIVER_APPROVED,
    contentSource: Enum$EmailContentSource.Inline,
    isActive: true,
    locale: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Fragment$emailTemplateListItem(
    id: '2',
    name: 'Order Confirmed Email',
    eventType: Enum$EmailEventType.ORDER_CONFIRMED,
    contentSource: Enum$EmailContentSource.Inline,
    isActive: true,
    locale: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Fragment$emailTemplateListItem(
    id: '3',
    name: 'Welcome Email',
    eventType: Enum$EmailEventType.AUTH_WELCOME,
    contentSource: Enum$EmailContentSource.ProviderTemplate,
    isActive: true,
    locale: 'en',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
