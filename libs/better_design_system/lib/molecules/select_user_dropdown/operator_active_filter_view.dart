import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'select_user_item.dart';

class SelectUsersDropdownSelectedUsersView<T> extends StatelessWidget {
  final List<SelectUserItem<T>> items;

  const SelectUsersDropdownSelectedUsersView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (items.isEmpty) {
      return Text("not selected", style: context.textTheme.labelMedium);
    } else if (items.length == 1) {
      return Row(
        children: [
          AppAvatar(imageUrl: items[0].avatar, size: AvatarSize.xl20px),
          const SizedBox(width: 6),
          Text(
            items[0].label,
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ],
      );
    } else if (items.length > 1 && items.length < 5) {
      return SizedBox(
        width: 73,
        height: 24,
        child: Stack(
          children: List.generate(items.length, (int index) {
            return Positioned(
              left: positionedLeft(index),
              child: AppAvatar(
                imageUrl: items[index].avatar,
                size: AvatarSize.xl20px,
              ),
            );
          }),
        ),
      );
    } else {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: context.colors.surfaceVariant,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              items.length.toString(),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colors.primary,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text("Selected", style: context.textTheme.labelMedium),
        ],
      );
    }
  }
}

double positionedLeft(int index) {
  switch (index) {
    case 0:
      return 0;
    case 1:
      return 18;
    case 2:
      return 33;
    case 3:
      return 48;

    default:
      return 0;
  }
}
