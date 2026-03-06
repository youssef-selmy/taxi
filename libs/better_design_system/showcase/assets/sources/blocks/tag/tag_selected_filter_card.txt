import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class TagSelectedFilterCard extends StatelessWidget {
  const TagSelectedFilterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 382,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              children: [
                Text('Selected Filter', style: context.textTheme.labelLarge),
                AppBadge(
                  text: '5',
                  color: SemanticColor.neutral,
                  isRounded: true,
                ),
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                AppTag(
                  prefixIcon: BetterIcons.truckFilled,
                  text: 'Free Delivery',
                  color: SemanticColor.neutral,
                  onRemovedPressed: () {},
                  style: TagStyle.outline,
                ),
                AppTag(
                  prefixIcon: BetterIcons.dollarCircleFilled,
                  text: 'Up to \$4',
                  color: SemanticColor.neutral,
                  onRemovedPressed: () {},
                  style: TagStyle.outline,
                ),
                AppTag(
                  prefixIcon: BetterIcons.location01Filled,
                  text: 'Closest',
                  color: SemanticColor.neutral,
                  onRemovedPressed: () {},
                  style: TagStyle.outline,
                ),
                AppTag(
                  prefixIcon: BetterIcons.clock01Filled,
                  text: 'Under 3 min',
                  color: SemanticColor.neutral,
                  onRemovedPressed: () {},
                  style: TagStyle.outline,
                ),
                AppTag(
                  prefixIcon: BetterIcons.starFilled,
                  text: 'Rating: Any',
                  color: SemanticColor.neutral,
                  onRemovedPressed: () {},
                  style: TagStyle.outline,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
