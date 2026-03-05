import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_localization/localizations.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

export 'package:better_design_system/utils/extensions/extensions.dart';
export 'package:better_localization/localizations.dart';
export 'package:better_localization/country_code/phone_number.extensions.dart';

part 'datetime.dart';

extension DoubleAdminX on double {
  Color color(BuildContext context) => switch (this) {
    0 => context.colors.onSurface,
    > 0.0 => context.colors.success,
    < 0.0 => context.colors.error,
    double() => context.colors.onSurface,
  };

  Widget toCurrency(
    BuildContext context,
    String currency, {
    bool colored = false,
  }) => Text.rich(
    TextSpan(
      text: formatCurrency(currency),
      style: (colored == false || this == 0)
          ? context.textTheme.labelMedium
          : context.textTheme.labelMedium?.apply(color: color(context)),
      children: [
        TextSpan(
          text: ' $currency',
          style: (colored == false || this == 0)
              ? context.textTheme.labelMedium?.variant(context)
              : context.textTheme.labelMedium?.apply(color: color(context)),
        ),
      ],
    ),
  );
}

extension AppBoolX on bool {
  String toActiveInactive(BuildContext context) =>
      this ? context.tr.active : context.tr.inactive;

  AppTag toActiveInactiveChip(BuildContext context) => AppTag(
    text: toActiveInactive(context),
    prefixIcon: this
        ? BetterIcons.checkmarkCircle02Filled
        : BetterIcons.cancelCircleFilled,
    color: this ? SemanticColor.success : SemanticColor.error,
  );
}

extension DateRangeX on (DateTime?, DateTime?) {
  String toRange(BuildContext context) {
    if ($1 == null && $2 == null) {
      return context.tr.notSet;
    }
    if ($1 == null) {
      return "${context.tr.until} ${$2!.formatDate(context)}";
    }
    if ($2 == null) {
      return "${context.tr.from} ${$1!.formatDate(context)}";
    }
    return "${$1!.formatDate(context)} - ${$2!.formatDate(context)}";
  }

  AppTag toAvailabilityChip(BuildContext context) {
    if ($1 == null && $2 == null) {
      return AppTag(
        text: context.tr.notSet,
        prefixIcon: BetterIcons.cancelCircleFilled,
        color: SemanticColor.error,
      );
    }
    final startIsBeforeNow = $1?.isBefore(DateTime.now()) ?? true;
    final endIsAfterNow = $2?.isAfter(DateTime.now()) ?? true;

    if (startIsBeforeNow && endIsAfterNow) {
      return AppTag(
        text: context.tr.available,
        prefixIcon: BetterIcons.checkmarkCircle02Filled,
        color: SemanticColor.success,
      );
    }
    if (startIsBeforeNow) {
      return AppTag(
        text: context.tr.expired,
        prefixIcon: BetterIcons.cancelCircleFilled,
        color: SemanticColor.error,
      );
    }
    return AppTag(
      text: context.tr.upcoming,
      prefixIcon: BetterIcons.clock01Filled,
      color: SemanticColor.warning,
    );
  }
}

extension ValidatorsX on BuildContext {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return tr.errorNameRequired;
    }
    return null;
  }
}

extension SizingX on BuildContext {
  EdgeInsets get pagePadding => responsive(
    const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
    lg: const EdgeInsets.only(left: 32, right: 32, top: 24, bottom: 24),
  );

  EdgeInsets get pagePaddingHorizontal => responsive(
    const EdgeInsets.only(left: 16, right: 16),
    lg: const EdgeInsets.only(left: 40, right: 40),
  );

  EdgeInsets get pagePaddingVertical => responsive(
    const EdgeInsets.only(top: 16),
    lg: const EdgeInsets.only(top: 48),
  );
}

extension PricingModeX on Enum$PricingMode {
  String get titleCased => switch (this) {
    Enum$PricingMode.FIXED => 'Fixed',
    Enum$PricingMode.RANGE => 'Range',
    Enum$PricingMode.$unknown => 'Unknown',
  };
}

extension RangePolicyX on Enum$RangePolicy {
  String get titleCased => switch (this) {
    Enum$RangePolicy.ENFORCE => 'Enforce',
    Enum$RangePolicy.SOFT => 'Soft',
    Enum$RangePolicy.OPEN => 'Open',
    Enum$RangePolicy.$unknown => 'Unknown',
  };
}
