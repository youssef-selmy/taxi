import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/menu_button.dart';
import 'package:better_design_system/atoms/percent_badge/percent_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

typedef BetterMediumStatCard = AppMediumStatCard;

class AppMediumStatCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final String number;
  final String? badgeTitle;
  final double? percent;
  final Widget? actionButton;
  final void Function()? onMenuPressed;
  final double width;
  const AppMediumStatCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.number,
    this.badgeTitle,
    this.percent,
    this.actionButton,
    this.onMenuPressed,
    this.width = 245,
  });

  @override
  Widget build(BuildContext context) {
    bool showActionButton = actionButton != null;
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      padding: EdgeInsets.symmetric(vertical: showActionButton ? 12 : 16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: context.colors.outline),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: showActionButton ? 12 : 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  spacing: 4,
                  children: <Widget>[
                    Text(
                      title,
                      style: context.textTheme.labelLarge?.variant(context),
                    ),
                    if (badgeTitle != null)
                      AppBadge(
                        text: badgeTitle!,
                        color: SemanticColor.warning,
                        isRounded: true,
                      ),
                  ],
                ),
                AppMenuButton(onPressed: onMenuPressed),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: showActionButton ? 12 : 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                Text(
                  number,
                  style: showActionButton
                      ? context.textTheme.titleMedium
                      : context.textTheme.headlineSmall,
                ),
                if (percent != null) AppPercentBadge(percent: percent!),
              ],
            ),
          ),

          if (subtitle != null && !showActionButton) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                subtitle!,
                style: context.textTheme.labelSmall?.variant(context),
              ),
            ),
          ],

          if (showActionButton) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(height: 1, color: context.colors.outline),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: actionButton!,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
