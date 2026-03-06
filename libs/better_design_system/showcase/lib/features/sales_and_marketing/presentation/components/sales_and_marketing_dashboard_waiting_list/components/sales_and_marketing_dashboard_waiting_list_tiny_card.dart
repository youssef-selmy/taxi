import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingDashboardWaitingListTinyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const SalesAndMarketingDashboardWaitingListTinyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  static const tinyStatCards = [
    SalesAndMarketingDashboardWaitingListTinyCard(
      title: 'Add to Waiting List',
      subtitle: 'Add a new customer to the waiting list',
      icon: BetterIcons.addCircleFilled,
    ),
    SalesAndMarketingDashboardWaitingListTinyCard(
      title: 'Generate Sales Report',
      subtitle: 'Instantly generate a summary of sales',
      icon: BetterIcons.arrowDown03Outline,
    ),
    SalesAndMarketingDashboardWaitingListTinyCard(
      title: 'Import Data',
      subtitle: 'Upload a file to update waiting or sales list',
      icon: BetterIcons.arrowUp03Outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.outline),
      ),
      child: Row(
        spacing: 8,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.outline),
            ),
            child: Icon(icon, size: 20, color: context.colors.primary),
          ),
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: context.textTheme.labelLarge),
              Text(
                subtitle,
                style: context.textTheme.bodySmall?.variant(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
