import 'package:better_design_system/atoms/status_badge/status_badge_type.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension CustomerCompactFragmentX on Fragment$CustomerCompact {
  String get fullName => [(firstName ?? ''), (lastName ?? '')].join(' ').trim();

  String? get profilePictureUrl => media?.address;

  Widget tableView(BuildContext context, {bool showTitle = false}) {
    return AppProfileCell(
      name: fullName,
      imageUrl: media?.address,
      subtitle: mobileNumber.formatPhoneNumber(null),
    );
  }
}

extension CustomerListItemFragmentX on Fragment$CustomerListItem {
  String get fullName => [(firstName ?? ''), (lastName ?? '')].join(' ').trim();

  String get mobileNumberFormatted =>
      mobileNumber.formatPhoneNumber(countryIso);

  String statusText(BuildContext context) => status == Enum$RiderStatus.Enabled
      ? context.tr.enabled
      : context.tr.disabled;

  Wrap balanceText(BuildContext context) => wallet
      .map((e) => e.balance.toCurrency(context, e.currency))
      .toList()
      .wrapWithCommas();

  Widget tableView(BuildContext context, {bool showTitle = false}) {
    return AppProfileCell(
      name: fullName,
      imageUrl: media?.address,
      subtitle: status == Enum$RiderStatus.Disabled ? context.tr.blocked : null,
      subtitleColor: status == Enum$RiderStatus.Disabled
          ? SemanticColor.error
          : null,
      statusBadgeType: status == Enum$RiderStatus.Disabled
          ? StatusBadgeType.busy
          : null,
    );
  }
}

extension CustomerDetailsX on Fragment$customerDetails {
  String get fullName => [(firstName ?? ''), (lastName ?? '')].join(' ').trim();

  String get avatarUrl => media?.address ?? "";

  String get mobileNumberFormatted =>
      mobileNumber.formatPhoneNumber(countryIso);
}
