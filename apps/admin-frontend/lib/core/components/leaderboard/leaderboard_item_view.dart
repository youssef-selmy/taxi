import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard_item.dart';
import 'package:admin_frontend/core/components/leaderboard/leaderboard_mode.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';

class LeaderboardItemView extends StatelessWidget {
  final Fragment$leaderboardItem item;
  final int rank;
  final LeaderboardMode mode;

  const LeaderboardItemView({
    super.key,
    required this.item,
    required this.rank,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Transform.translate(
              offset: const Offset(0, 20),
              child: AppAvatar(imageUrl: item.avatarUrl, size: avatarSize),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: rankBackgroundColor(context),
                  border: Border.all(color: context.colors.surface, width: 3),
                ),
                child: Center(
                  child: Text(
                    "${rank}st",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: rankTextColor(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(item.name, style: context.textTheme.labelMedium),
        Text(item.valueForMode(mode), style: context.textTheme.labelMedium),
      ],
    );
  }

  AvatarSize get avatarSize =>
      rank == 1 ? AvatarSize.size72px : AvatarSize.size56px;

  Color rankBackgroundColor(BuildContext context) => rank == 1
      ? context.colors.warningVariantLow
      : context.colors.surfaceVariant;

  Color rankTextColor(BuildContext context) =>
      rank == 1 ? context.colors.warning : context.colors.onSurfaceVariant;
}
