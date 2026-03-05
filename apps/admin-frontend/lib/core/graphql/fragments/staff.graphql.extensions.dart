import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/molecules/select_user_dropdown/select_user_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';

extension StaffListItemX on Fragment$staffListItem {
  String get fullName => [(firstName ?? ''), (lastName ?? '')].join(' ').trim();

  Widget tableView(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        AppAvatar(imageUrl: media?.address, size: AvatarSize.size32px),
        const SizedBox(width: 8),
        Text(fullName, style: context.textTheme.labelMedium),
      ],
    );
  }
}

extension StaffListItemListX on List<Fragment$staffListItem> {
  List<SelectUserItem<Fragment$staffListItem>> toOperatorFilterItems(
    BuildContext context,
  ) {
    return map(
      (e) => SelectUserItem<Fragment$staffListItem>(
        value: e,
        label: e.fullName,
        avatar: e.media?.address,
      ),
    ).toList();
  }
}
