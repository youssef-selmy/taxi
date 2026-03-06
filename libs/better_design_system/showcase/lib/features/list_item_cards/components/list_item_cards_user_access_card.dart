import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class ListItemCardsUserAccessCard extends StatefulWidget {
  const ListItemCardsUserAccessCard({super.key});

  @override
  State<ListItemCardsUserAccessCard> createState() =>
      _ListItemCardsUserAccessCardState();
}

class _ListItemCardsUserAccessCardState
    extends State<ListItemCardsUserAccessCard> {
  bool _fullAccess = false;
  bool _canEdit = false;
  bool _canComment = true;
  bool _canView = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 385,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  isSelected: _fullAccess,
                  onTap: (_) {
                    setState(() {
                      _fullAccess = !_fullAccess;
                    });
                  },
                ),
                const SizedBox(height: 16),
                AppListItem(
                  padding: EdgeInsets.all(4),
                  actionType: ListItemActionType.switcher,
                  title: 'Can Edit',
                  subtitle: 'Edit, suggest, comment',
                  isCompact: true,
                  isSelected: _canEdit,
                  onTap: (_) {
                    setState(() {
                      _canEdit = !_canEdit;
                    });
                  },
                ),
                const SizedBox(height: 16),
                AppListItem(
                  padding: EdgeInsets.all(4),
                  actionType: ListItemActionType.switcher,
                  title: 'Can Comment',
                  subtitle: 'Suggest and comment',
                  isCompact: true,
                  isSelected: _canComment,
                  onTap: (_) {
                    setState(() {
                      _canComment = !_canComment;
                    });
                  },
                ),
                const SizedBox(height: 16),
                AppListItem(
                  padding: EdgeInsets.all(4),
                  actionType: ListItemActionType.switcher,
                  title: 'Can View',
                  isCompact: true,
                  isSelected: _canView,
                  onTap: (_) {
                    setState(() {
                      _canView = !_canView;
                    });
                  },
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
    );
  }
}
