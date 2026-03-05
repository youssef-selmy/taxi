import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/schema.graphql.dart';

extension EmailProviderTypeGqlX on Enum$EmailProviderType {
  EmailProviderApiKeys apiKeys(BuildContext context) => switch (this) {
    Enum$EmailProviderType.SendGrid => EmailProviderApiKeys(
      apiKey: 'API Key',
      fromEmail: 'From Email',
      fromName: 'From Name',
      replyToEmail: 'Reply-To Email',
    ),
    Enum$EmailProviderType.MailerSend => EmailProviderApiKeys(
      apiKey: 'API Key',
      fromEmail: 'From Email',
      fromName: 'From Name',
      replyToEmail: 'Reply-To Email',
    ),
    Enum$EmailProviderType.$unknown => EmailProviderApiKeys(
      apiKey: 'UPDATE THE APP TO SUPPORT THIS PROVIDER',
    ),
  };

  String name(BuildContext context) {
    return switch (this) {
      Enum$EmailProviderType.SendGrid => 'SendGrid',
      Enum$EmailProviderType.MailerSend => 'MailerSend',
      Enum$EmailProviderType.$unknown => context.tr.unknown,
    };
  }
}

class EmailProviderApiKeys {
  final String? apiKey;
  final String? fromEmail;
  final String? fromName;
  final String? replyToEmail;

  EmailProviderApiKeys({
    this.apiKey,
    this.fromEmail,
    this.fromName,
    this.replyToEmail,
  });

  int get length => [apiKey, fromEmail, fromName, replyToEmail].nonNulls.length;
}
