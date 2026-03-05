import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';

extension FragmentOrderTaxiListItemX on Fragment$taxiOrderListItem {
  Widget nameView(BuildContext context) {
    return Row(
      children: [
        Text("#$id", style: context.textTheme.labelMedium?.variant(context)),
        const SizedBox(width: 8),
        Expanded(
          child: AppProfileCell(
            name: driver?.fullName ?? context.tr.noDriver,
            imageUrl: driver?.imageUrl,
          ),
        ),
      ],
    );
  }
}
