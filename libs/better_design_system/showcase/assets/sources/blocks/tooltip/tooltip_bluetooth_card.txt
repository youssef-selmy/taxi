import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:better_design_system/molecules/tooltip/tooltip.dart';
import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class TooltipBluetoothCard extends StatelessWidget {
  const TooltipBluetoothCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 430,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppMobileTopBar(
              title: 'Bluetooth',
              padding: EdgeInsets.zero,
              onBackPressed: () {},
              suffixActions: [
                AppTooltip(
                  title: 'Connection guide',
                  trigger: TooltipTrigger.always,
                  size: TooltipSize.medium,
                  alignment: TooltipAlignment.bottom,
                  child: Icon(
                    BetterIcons.helpCircleOutline,
                    size: 24,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bluetooth', style: context.textTheme.labelLarge),
                AppSwitch(isSelected: true, onChanged: null),
              ],
            ),
            AppDivider(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Rename the device',
                      style: context.textTheme.labelLarge,
                    ),
                    Text(
                      'iPhone 16',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
                Icon(
                  BetterIcons.arrowRight01Outline,
                  size: 24,
                  color: context.colors.onSurfaceVariant,
                ),
              ],
            ),
            AppDivider(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List of active devices nearby',
                  style: context.textTheme.labelLarge,
                ),
                Icon(
                  BetterIcons.arrowRight01Outline,
                  size: 24,
                  color: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
