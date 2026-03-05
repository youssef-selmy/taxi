import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/schema.graphql.dart';

extension SmsProviderTypeGqlX on Enum$SMSProviderType {
  SMSProviderApiKeys apiKeys(BuildContext context) => switch (this) {
    Enum$SMSProviderType.Twilio => SMSProviderApiKeys(
      accountId: 'Account SID',
      authToken: 'Auth Token',
      fromNumber: 'From Number',
      verificationTemplate: 'Verification Template',
      showCallMasking: true,
    ),
    Enum$SMSProviderType.BroadNet => SMSProviderApiKeys(
      accountId: 'Username',
      authToken: 'Password',
      fromNumber: 'From Number',
      verificationTemplate: 'Verification Template',
      smsType: 'SMS Type',
    ),
    Enum$SMSProviderType.Plivo => SMSProviderApiKeys(
      accountId: 'Auth ID',
      authToken: 'Auth Token',
      fromNumber: 'Sender ID',
      verificationTemplate: 'Verification Template',
    ),
    Enum$SMSProviderType.Vonage => SMSProviderApiKeys(
      accountId: 'API Key',
      authToken: 'API Secret',
      fromNumber: 'From Number',
      verificationTemplate: 'Verification Template',
    ),
    Enum$SMSProviderType.Pahappa => SMSProviderApiKeys(
      accountId: 'Username',
      authToken: 'Password',
      fromNumber: 'Sender',
      verificationTemplate: 'Verification Template',
    ),
    Enum$SMSProviderType.Firebase => SMSProviderApiKeys(
      accountId: 'UNSUPPORTED',
    ),
    Enum$SMSProviderType.$unknown => SMSProviderApiKeys(
      accountId: 'UPDATE THE APP TO SUPPORT THIS PROVIDER',
    ),
    Enum$SMSProviderType.ClickSend => SMSProviderApiKeys(
      accountId: 'UNSUPPORTED',
    ),
    Enum$SMSProviderType.Infobip => SMSProviderApiKeys(
      accountId: 'UNSUPPORTED',
    ),
    Enum$SMSProviderType.MessageBird => SMSProviderApiKeys(
      accountId: 'UNSUPPORTED',
    ),
    Enum$SMSProviderType.VentisSMS => SMSProviderApiKeys(
      accountId: 'Username',
      smsType: 'Password',
      authToken: 'Client Secret',
      fromNumber: 'Sender',
      verificationTemplate: 'Verification Template',
    ),
    Enum$SMSProviderType.ClickSMSNet => SMSProviderApiKeys(
      authToken: 'API Key',
      fromNumber: 'Sender',
    ),
  };

  String name(BuildContext context) {
    return switch (this) {
      Enum$SMSProviderType.Twilio => 'Twilio',
      Enum$SMSProviderType.BroadNet => 'BroadNet',
      Enum$SMSProviderType.Plivo => 'Plivo',
      Enum$SMSProviderType.Vonage => 'Vonage',
      Enum$SMSProviderType.Pahappa => 'Pahappa',
      Enum$SMSProviderType.Firebase => 'Firebase',
      Enum$SMSProviderType.ClickSend => 'ClickSend',
      Enum$SMSProviderType.Infobip => 'Infobip',
      Enum$SMSProviderType.MessageBird => 'MessageBird',
      Enum$SMSProviderType.$unknown => context.tr.unknown,
      Enum$SMSProviderType.VentisSMS => 'VentisSMS',
      Enum$SMSProviderType.ClickSMSNet => 'ClickSMSNet',
    };
  }
}

class SMSProviderApiKeys {
  final String? accountId;
  final String? authToken;
  final String? fromNumber;
  final String? verificationTemplate;
  final String? smsType;
  final bool showCallMasking;

  SMSProviderApiKeys({
    this.accountId,
    this.authToken,
    this.fromNumber,
    this.verificationTemplate,
    this.smsType,
    this.showCallMasking = false,
  });

  int get length => [
    accountId,
    authToken,
    fromNumber,
    verificationTemplate,
    smsType,
  ].nonNulls.length;
}
