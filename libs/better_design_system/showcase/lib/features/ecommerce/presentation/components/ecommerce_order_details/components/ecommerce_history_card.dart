import 'package:better_design_system/organisms/step_indicator/vertical_step_indicator.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceHistoryCard extends StatelessWidget {
  const EcommerceHistoryCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 16.0 : 20.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: _cardDecoration(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('History', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          AppVerticalStepIndicator(
            style: StepIndicatorItemStyle.circular,
            items: [
              StepIndicatorItem(
                label: 'Order Placed',
                description: '30 May, 2023',
                value: 1,
              ),
              StepIndicatorItem(label: 'Order Submitted', value: 2),
              StepIndicatorItem(
                label: 'Order Packed',
                value: 3,
                icon: BetterIcons.packageFilled,
              ),
              StepIndicatorItem(
                label: 'Order Shipped',
                value: 4,
                icon: BetterIcons.truckFilled,
              ),
              StepIndicatorItem(
                label: 'Delivered',
                value: 5,
                icon: BetterIcons.packageDeliveredFilled,
              ),
            ],
            selectedStep: 3,
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) => BoxDecoration(
    color: context.colors.surface,
    border: Border.all(color: context.colors.outline),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
  );
}
