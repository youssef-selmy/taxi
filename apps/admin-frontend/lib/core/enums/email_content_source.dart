import 'package:flutter/material.dart';

import 'package:admin_frontend/schema.graphql.dart';

extension EmailContentSourceGqlX on Enum$EmailContentSource {
  String name(BuildContext context) {
    return switch (this) {
      Enum$EmailContentSource.Inline => 'Inline Body',
      Enum$EmailContentSource.ProviderTemplate => 'Provider Template',
      Enum$EmailContentSource.$unknown => 'Unknown',
    };
  }

  String description(BuildContext context) {
    return switch (this) {
      Enum$EmailContentSource.Inline =>
        'Use HTML body content defined in this template',
      Enum$EmailContentSource.ProviderTemplate =>
        'Use a template from your email provider (SendGrid/MailerSend)',
      Enum$EmailContentSource.$unknown => 'Unknown content source',
    };
  }
}
