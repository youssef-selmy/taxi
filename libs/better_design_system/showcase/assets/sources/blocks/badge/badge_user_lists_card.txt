import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/list_item/vertical_toggle_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class BadgeUserListsCard extends StatelessWidget {
  const BadgeUserListsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 297,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'User lists',
                  style: context.textTheme.labelLarge?.variant(context),
                ),
                Row(
                  spacing: 4,
                  children: [
                    Text(
                      'Online',
                      style: context.textTheme.labelLarge?.variantLow(context),
                    ),
                    AppBadge(
                      text: '2',
                      color: SemanticColor.neutral,
                      isRounded: true,
                    ),
                  ],
                ),
              ],
            ),

            Column(
              children: [
                _buildListItem(
                  context,
                  imageUrl: ImageFaker().person.two,
                  name: 'Aspen Dokidis',
                  statusBadge: StatusBadgeType.online,
                ),
                AppDivider(height: 20),
                _buildListItem(
                  context,
                  imageUrl: ImageFaker().person.three,
                  name: 'Charlie George',
                  statusBadge: StatusBadgeType.online,
                ),
                AppDivider(height: 20),
                _buildListItem(
                  context,
                  imageUrl: ImageFaker().person.four,
                  name: 'Phillip George',
                  statusBadge: StatusBadgeType.away,
                ),
                AppDivider(height: 20),
                _buildListItem(
                  context,
                  imageUrl: ImageFaker().person.five,
                  name: 'Miracle Press',
                  statusBadge: StatusBadgeType.offline,
                ),
                AppDivider(height: 20),
                _buildListItem(
                  context,
                  imageUrl: ImageFaker().person.six,
                  name: 'Martin Lubin',
                  statusBadge: StatusBadgeType.offline,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required String imageUrl,
    required String name,
    required StatusBadgeType statusBadge,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: <Widget>[
        Row(
          spacing: 8,
          children: [
            AppAvatar(
              imageUrl: imageUrl,
              size: AvatarSize.size40px,
              statusBadgeType: statusBadge,
            ),
            Text(name, style: context.textTheme.labelLarge),
          ],
        ),
        AppBadge(
          text: _getBadgeText(statusBadge),
          hasDot: true,
          color: _getBadgeColor(statusBadge),
          size: BadgeSize.large,
          isRounded: true,
        ),
      ],
    );
  }

  SemanticColor _getBadgeColor(
    StatusBadgeType statusBadge,
  ) => switch (statusBadge) {
    StatusBadgeType.none || StatusBadgeType.offline => SemanticColor.neutral,
    StatusBadgeType.away => SemanticColor.warning,
    StatusBadgeType.busy => SemanticColor.error,
    StatusBadgeType.online => SemanticColor.success,
  };

  String _getBadgeText(StatusBadgeType statusBadge) => switch (statusBadge) {
    StatusBadgeType.none => 'None',
    StatusBadgeType.away => 'Away',
    StatusBadgeType.offline => 'Offline',
    StatusBadgeType.busy => 'Busy',
    StatusBadgeType.online => 'Online',
  };
}
