import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FintechRecentTransaction extends StatefulWidget {
  final List<String> recentTracsactionTabs;
  const FintechRecentTransaction({
    super.key,
    this.recentTracsactionTabs = const ['Income', 'Expense'],
  });

  @override
  State<FintechRecentTransaction> createState() =>
      _FintechRecentTransactionState();
}

class _FintechRecentTransactionState extends State<FintechRecentTransaction> {
  void _onTransactionTypeChanged(String value) {
    setState(() {
      selectedTransactionType = value;
    });
  }

  late String selectedTransactionType;

  @override
  void initState() {
    selectedTransactionType = widget.recentTracsactionTabs.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Recent Tracsaction', style: context.textTheme.titleSmall),

              AppOutlinedButton(
                onPressed: () {},
                prefixIcon: BetterIcons.filterVerticalOutline,
                color: SemanticColor.neutral,
                size: ButtonSize.medium,
              ),
            ],
          ),

          AppToggleSwitchButtonGroup<String>(
            isExpanded: true,
            options:
                widget.recentTracsactionTabs
                    .map(
                      (e) => ToggleSwitchButtonGroupOption<String>(
                        value: e,
                        label: e,
                      ),
                    )
                    .toList(),
            selectedValue: selectedTransactionType,
            onChanged: _onTransactionTypeChanged,
          ),

          _transactionItem(
            context,
            icon: BetterIcons.userFilled,
            iconColor: context.colors.insight,
            title: 'Payment to Sara',
            subtitle: '21 Oct',
            price: '25',
          ),
          _transactionItem(
            context,
            icon: BetterIcons.globe02Filled,
            iconColor: context.colors.info,
            title: 'Internet Payment',
            subtitle: '21 Oct',
            price: '5',
          ),

          _transactionItem(
            context,
            icon: BetterIcons.arrowUpDownOutline,
            iconColor: context.colors.onSurfaceVariant,
            title: 'Internal Transfer',
            subtitle: '21 Oct',
            price: '1,000',
          ),

          _transactionItem(
            context,
            icon: BetterIcons.moneyBag02Filled,
            iconColor: context.colors.warning,
            title: 'Buy Crypto - BTC',
            subtitle: '21 Oct',
            price: '2,500',
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: AppOutlinedButton(
                  onPressed: () {},
                  text: 'View All',
                  color: SemanticColor.neutral,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border.all(color: context.colors.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 24, color: iconColor),
            ),
            SizedBox(width: 12),
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.labelLarge),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.variant(context),
                ),
              ],
            ),
          ],
        ),
        Text('\$$price', style: context.textTheme.titleSmall),
      ],
    );
  }
}
