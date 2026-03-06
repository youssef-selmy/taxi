import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class AppUserAccess extends StatelessWidget {
  const AppUserAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16.0)
              : EdgeInsets.zero,
      child: AppClickableCard(
        padding: EdgeInsets.zero,
        type: ClickableCardType.elevated,
        elevation: BetterShadow.shadow4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('User Access', style: context.textTheme.titleSmall),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  AppListItem(
                    padding: EdgeInsets.all(12),
                    leading: AppAvatar(
                      statusBadgeType: StatusBadgeType.offline,
                      imageUrl: ImageFaker().person.six,
                      size: AvatarSize.size40px,
                    ),
                    title: 'Charlie Press',
                    subtitle: 'charlie@better.com',
                  ),
                  const SizedBox(height: 16),
                  AppListItem(
                    padding: EdgeInsets.all(4),
                    actionType: ListItemActionType.switcher,
                    title: 'Full Access',
                    subtitle: 'Edit, suggest, comment and share',
                    isCompact: true,
                  ),
                  const SizedBox(height: 16),
                  AppListItem(
                    padding: EdgeInsets.all(4),
                    actionType: ListItemActionType.switcher,
                    title: 'Can Edit',
                    subtitle: 'Edit, suggest, comment',
                    isCompact: true,
                  ),
                  const SizedBox(height: 16),
                  AppListItem(
                    padding: EdgeInsets.all(4),
                    actionType: ListItemActionType.switcher,
                    title: 'Can Comment',
                    subtitle: 'Suggest and comment',
                    isCompact: true,
                    isSelected: true,
                  ),
                  const SizedBox(height: 16),
                  AppListItem(
                    padding: EdgeInsets.all(4),
                    actionType: ListItemActionType.switcher,
                    title: 'Can View',
                    isCompact: true,
                    isSelected: true,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: AppDivider(),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: AppTextButton(
                      onPressed: () {},
                      text: 'Remove Access',
                      color: SemanticColor.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
