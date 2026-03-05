import 'package:admin_frontend/core/graphql/fragments/email_provider.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockEmailProviderDetails = Fragment$emailProviderDetails(
  id: '1',
  name: 'SendGrid Production',
  type: Enum$EmailProviderType.SendGrid,
  isDefault: true,
  apiKey: 'SG.xxx',
  fromEmail: 'noreply@example.com',
  fromName: 'Example App',
  replyToEmail: 'support@example.com',
);

final mockEmailProviderList = [];
