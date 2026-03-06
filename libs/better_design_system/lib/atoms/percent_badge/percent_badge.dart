import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/widgets.dart';

typedef BetterPercentBadge = AppPercentBadge;

class AppPercentBadge extends StatelessWidget {
  final double percent;
  const AppPercentBadge({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return AppBadge(
      prefixIcon: percent > 0
          ? BetterIcons.arrowUp02Outline
          : BetterIcons.arrowDown02Outline,
      text: '${percent.toStringAsFixed(1)}%',
      color: percent > 0 ? SemanticColor.success : SemanticColor.error,
      isRounded: true,
    );
  }
}
