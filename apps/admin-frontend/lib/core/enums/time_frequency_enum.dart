import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TimeFrequencyEnumX on Enum$TimeFrequency {
  String name(BuildContext context) {
    return switch (this) {
      Enum$TimeFrequency.Daily => context.tr.daily,
      Enum$TimeFrequency.Monthly => context.tr.monthly,
      Enum$TimeFrequency.Quarterly => context.tr.quarterly,
      Enum$TimeFrequency.Weekly => context.tr.weekly,
      Enum$TimeFrequency.Yearly => context.tr.yearly,
      Enum$TimeFrequency.$unknown => context.tr.unknown,
    };
  }
}
