import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/circular_progress_bar/circular_progress_bar.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'fintech_saved_payment_method_card.dart';

enum FintechMyCardsStyle { styleA, styleB }

class FintechMyCards extends StatefulWidget {
  final FintechMyCardsStyle style;
  const FintechMyCards({super.key, this.style = FintechMyCardsStyle.styleA});

  @override
  State<FintechMyCards> createState() => _FintechMyCardsState();
}

class _FintechMyCardsState extends State<FintechMyCards> {
  late List<String> tabs;
  late String selectedTab;
  void _onTabChanged(String value) {
    setState(() {
      selectedTab = value;
    });
  }

  @override
  void initState() {
    tabs =
        widget.style == FintechMyCardsStyle.styleA
            ? ['Virtual', 'Physical']
            : ['Daily', 'Weekly', 'Monthly'];
    selectedTab = tabs.first;
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
              Text('My Cards', style: context.textTheme.titleSmall),
              AppOutlinedButton(
                onPressed: () {},
                text: 'Add New Card',
                prefixIcon: BetterIcons.add01Filled,
                color: SemanticColor.neutral,
                size: ButtonSize.medium,
              ),
            ],
          ),

          if (widget.style == FintechMyCardsStyle.styleA) ...[
            AppToggleSwitchButtonGroup<String>(
              isExpanded: true,
              options:
                  tabs
                      .map(
                        (e) => ToggleSwitchButtonGroupOption<String>(
                          value: e,
                          label: e,
                        ),
                      )
                      .toList(),
              selectedValue: selectedTab,
              onChanged: _onTabChanged,
            ),
          ],
          FintechSavedPaymentMethodCard(
            cardSubtitle: 'Robert Padillo',
            displayValue: '\$5,000,000',
            expireDate: '01/02',
            type: SavedPaymentMethodType.cardNumber,
          ),

          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AppIconButton(
                icon: BetterIcons.arrowLeft02Outline,
                size: ButtonSize.small,
                style: IconButtonStyle.outline,
              ),
              AppIconButton(
                icon: BetterIcons.arrowRight02Outline,
                size: ButtonSize.small,
                style: IconButtonStyle.outline,
              ),
            ],
          ),

          if (widget.style == FintechMyCardsStyle.styleA) ...[
            Column(
              spacing: 8,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Card Number',
                      style: context.textTheme.labelLarge?.variant(context),
                    ),
                    Text('**** 1121', style: context.textTheme.labelLarge),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Expiry Date',
                      style: context.textTheme.labelLarge?.variant(context),
                    ),
                    Text('09/21', style: context.textTheme.labelLarge),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'CVC',
                      style: context.textTheme.labelLarge?.variant(context),
                    ),
                    Text('***', style: context.textTheme.labelLarge),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Spending Limit (Monthly)',
                      style: context.textTheme.labelLarge?.variant(context),
                    ),
                    Text('***', style: context.textTheme.labelLarge),
                  ],
                ),
              ],
            ),

            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Unhide',
                    color: SemanticColor.neutral,
                    size: ButtonSize.medium,
                  ),
                ),
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Adjust Limit',
                    color: SemanticColor.neutral,
                    size: ButtonSize.medium,
                  ),
                ),
                AppIconButton(
                  icon: BetterIcons.moreVerticalCircle01Filled,
                  size: ButtonSize.medium,
                  style: IconButtonStyle.outline,
                ),
              ],
            ),
          ],

          if (widget.style == FintechMyCardsStyle.styleB) ...[
            AppToggleSwitchButtonGroup<String>(
              isExpanded: true,
              options:
                  tabs
                      .map(
                        (e) => ToggleSwitchButtonGroupOption<String>(
                          value: e,
                          label: e,
                        ),
                      )
                      .toList(),
              selectedValue: selectedTab,
              onChanged: _onTabChanged,
            ),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border.all(color: context.colors.outline),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    spacing: 12,
                    children: <Widget>[
                      AppCircularProgressBar(
                        size: CircularProgressBarSize.size52px,
                        status: CircularProgressBarStatus.uploading,
                        progress: 0.75,
                        showProgressNumber: true,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: <Widget>[
                          Text(
                            'Spending Limit',
                            style: context.textTheme.labelLarge?.variant(
                              context,
                            ),
                          ),
                          Row(
                            spacing: 8,
                            children: <Widget>[
                              Text(
                                '\$2,000.00',
                                style: context.textTheme.titleSmall,
                              ),
                              AppBadge(
                                text: 'Week',
                                color: SemanticColor.insight,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    BetterIcons.arrowRight01Outline,
                    size: 20,
                    color: context.colors.onSurface,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
