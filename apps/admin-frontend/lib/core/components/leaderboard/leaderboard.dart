import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/leaderboard/leaderboard_item.dart';
import 'package:admin_frontend/core/components/leaderboard/leaderboard_item_view.dart';
import 'package:admin_frontend/core/components/leaderboard/leaderboard_mode.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';

export 'leaderboard_mode.dart';

class Leaderboard extends StatelessWidget {
  final List<Fragment$leaderboardItem> items;
  final LeaderboardMode mode;
  final String title;
  final String subtitle;

  const Leaderboard({
    super.key,
    required this.items,
    required this.mode,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    if (items.length < 3) {
      return ChartCard(
        title: title,
        subtitle: subtitle,
        child: Center(
          child: AppEmptyState(
            title: context.tr.noDataAvailable,
            image: Assets.images.emptyStates.cyberThreat,
          ),
        ),
      );
    }
    return ChartCard(
      title: title,
      subtitle: subtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [2, 1, 3]
                .map(
                  (e) => LeaderboardItemView(
                    rank: e,
                    item: items[e - 1],
                    mode: mode,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final user = items[index + 3];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "${index + 4}",
                        style: context.textTheme.bodyMedium?.variant(context),
                      ),
                      const SizedBox(width: 8),
                      AppAvatar(
                        imageUrl: user.avatarUrl,
                        size: AvatarSize.size32px,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          user.name,
                          style: context.textTheme.labelMedium,
                        ),
                      ),
                      Text(
                        user.valueForMode(mode),
                        style: context.textTheme.labelMedium,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(height: 24, color: context.colors.surfaceVariant),
              itemCount: items.length - 3,
            ),
          ),
        ],
      ),
    );
  }
}
