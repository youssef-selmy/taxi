import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingAnalyticsLastTransactionCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingAnalyticsLastTransactionCard({
    super.key,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text('Last Transaction', style: context.textTheme.titleSmall),
          Table(
            border: TableBorder.all(
              color: context.colors.outline,
              width: 1,
              borderRadius: BorderRadius.circular(10),
            ),
            children: [
              TableRow(
                children: [
                  _buildTableItem(
                    context,
                    icon: BetterIcons.shoppingBasket03Filled,
                    title: 'To be packed',
                    value: '8956',
                    isMobile: isMobile,
                  ),
                  _buildTableItem(
                    context,
                    icon: BetterIcons.truckDeliveryFilled,
                    title: 'To be delivered',
                    value: '1999',
                    isMobile: isMobile,
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableItem(
                    context,
                    icon: BetterIcons.shoppingBagCheckFilled,
                    title: 'To be shipped',
                    value: '669',
                    isMobile: isMobile,
                  ),
                  _buildTableItem(
                    context,
                    icon: BetterIcons.invoice01Filled,
                    title: 'To be invoice',
                    value: '412',
                    isMobile: isMobile,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required bool isMobile,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        children: <Widget>[
          Icon(icon, size: isMobile ? 24 : 32, color: context.colors.primary),
          SizedBox(height: 12),
          Text(title, style: context.textTheme.labelMedium?.variant(context)),
          SizedBox(height: 8),
          Text(value, style: context.textTheme.titleSmall),
        ],
      ),
    );
  }
}
