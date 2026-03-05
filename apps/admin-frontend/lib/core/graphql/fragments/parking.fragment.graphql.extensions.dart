import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';

import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';

extension ParkingFragmentExtension on Fragment$parkingListItem {
  Widget tableView(BuildContext context) {
    return AppProfileCell(
      name: name ?? address ?? "-",
      avatarPlaceHolder: AvatarPlaceholder.parking,
      imageUrl: mainImage?.address,
    );
  }
}

extension ParkingFragmentCompactX on Fragment$parkingCompact {
  Widget tableView(BuildContext context) {
    return AppProfileCell(
      name: name ?? address ?? "",
      imageUrl: mainImage?.address,
      avatarPlaceHolder: AvatarPlaceholder.parking,
    );
  }
}
