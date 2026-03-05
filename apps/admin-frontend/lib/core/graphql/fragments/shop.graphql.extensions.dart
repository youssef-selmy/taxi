import 'package:admin_frontend/core/enums/shop_status.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:collection/collection.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';

extension FragmentShopBasicX on Fragment$shopBasic {
  Widget tableView(
    BuildContext context, {
    AvatarSize size = AvatarSize.size40px,
  }) {
    return Row(
      children: [
        AppAvatar(imageUrl: image?.address, size: size),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categories.map((cat) => "#${cat.name}").join(", "),
                style: context.textTheme.labelMedium?.variant(context),
              ),
              Text(name, style: context.textTheme.labelMedium),
            ],
          ),
        ),
      ],
    );
  }
}

extension FragmentShopBasicInfoX on Fragment$shopBasicInfo {
  Widget tableView(BuildContext context) {
    return Row(
      children: [
        AppAvatar(imageUrl: image?.address, size: AvatarSize.size32px),
        const SizedBox(width: 8),
        Expanded(child: Text(name, style: context.textTheme.labelMedium)),
      ],
    );
  }
}

extension FragmentShopBasicListX on List<Fragment$shopBasic> {
  Widget tableView(
    BuildContext context, {
    AvatarSize size = AvatarSize.size40px,
  }) {
    if (length == 1) {
      return first.tableView(context, size: size);
    } else {
      return Row(
        children: mapIndexed(
          (index, e) => Transform.translate(
            offset: Offset(index * 10, 0),
            child: AppAvatar(imageUrl: e.image?.address, size: size),
          ),
        ).toList(),
      );
    }
  }
}

extension ShopFragmentListItemX on Fragment$shopListItem {
  Widget tableView(BuildContext context) {
    return AppProfileCell(
      name: name,
      imageUrl: image?.address,
      statusBadgeType: status.statusBadgeType,
      subtitle: status == Enum$ShopStatus.Active || lastActivityAt == null
          ? null
          : "${context.tr.lastActivityAt} ${lastActivityAt!.toTimeAgo}",
    );
  }
}
