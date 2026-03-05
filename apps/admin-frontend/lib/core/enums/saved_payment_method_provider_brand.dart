import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/gen/assets.gen.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension SavedPaymentMethodProviderBrandX on Enum$ProviderBrand {
  String name(BuildContext context) {
    return switch (this) {
      Enum$ProviderBrand.Visa => context.tr.visa,
      Enum$ProviderBrand.Mastercard => context.tr.mastercard,
      _ => throw Exception("${context.tr.unknownBrandType} ${toString()}"),
    };
  }

  AssetGenImage get image => switch (this) {
    Enum$ProviderBrand.Visa => Assets.images.visa,
    Enum$ProviderBrand.Mastercard => Assets.images.mastercard,
    _ => throw Exception('Unknown provider brand: $this'),
  };
}
