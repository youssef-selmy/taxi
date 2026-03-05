import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/components/leaderboard/leaderboard_mode.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';

extension LeaderboardItemX on Fragment$leaderboardItem {
  String valueForMode(LeaderboardMode mode) {
    switch (mode) {
      case LeaderboardMode.totalOrders:
        return totalCount?.toStringAsFixed(0) ?? "-";
      case LeaderboardMode.totalSpendingOrEarning:
        return totalAmount?.formatCurrency(currency ?? Env.defaultCurrency) ??
            "-";
    }
  }
}
