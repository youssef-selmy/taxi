import 'package:admin_frontend/core/enums/driver_status.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.dart';

extension DriverListItemX on Fragment$driverListItem {
  String get fullName => [(firstName ?? ''), (lastName ?? '')].join(' ').trim();
}

extension DriverNameFragmentX on Fragment$DriverName {
  String get fullName => [(firstName ?? ''), (lastName ?? '')].join(' ').trim();

  Widget tableView(BuildContext context, {bool showTitle = false}) {
    return AppProfileCell(
      name: fullName,
      imageUrl: media?.address,
      statusBadgeType: status.statusBadgeType,
      subtitle: status == Enum$DriverStatus.Online
          ? context.tr.online
          : "${context.tr.lastActive} ${lastSeenTimestamp?.toTimeAgo ?? context.tr.never}",
      subtitleColor: status == Enum$DriverStatus.Online
          ? SemanticColor.primary
          : null,
    );
  }
}

extension DriverNameNullableFragmentX on Fragment$DriverName? {
  Widget tableViewNullable(BuildContext context, bool isSearching) {
    return AppProfileCell(
      name:
          this?.fullName ??
          (isSearching ? context.tr.searching : context.tr.notSet),
      imageUrl: this?.media?.address,
      statusBadgeType: this?.status.statusBadgeType,
      subtitle: this == null
          ? null
          : this?.status == Enum$DriverStatus.Online
          ? context.tr.online
          : "${context.tr.lastActive} ${this?.lastSeenTimestamp?.toTimeAgo ?? context.tr.never}",
      subtitleColor: this?.status == Enum$DriverStatus.Online
          ? SemanticColor.primary
          : null,
    );
  }
}

extension Fragment$driverListItemX on Fragment$driverListItem {
  Wrap balanceText(BuildContext context) => wallet
      .map((e) => e.balance.toCurrency(context, e.currency))
      .toList()
      .wrapWithCommas();

  Widget tableView(BuildContext context, {bool showTitle = false}) {
    return AppProfileCell(
      name: fullName,
      imageUrl: media?.address,
      subtitle: status == Enum$DriverStatus.Online
          ? context.tr.online
          : "${context.tr.lastActive} ${lastSeenTimestamp?.toTimeAgo ?? context.tr.never}",
      statusBadgeType: status.statusBadgeType,
      subtitleColor: status == Enum$DriverStatus.Online
          ? SemanticColor.primary
          : null,
    );
  }
}
