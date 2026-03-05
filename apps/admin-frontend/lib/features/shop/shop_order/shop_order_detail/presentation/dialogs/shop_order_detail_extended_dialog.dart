import 'package:flutter/cupertino.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class ShopOrderDetailExtendedDialog extends StatefulWidget {
  const ShopOrderDetailExtendedDialog({super.key});

  @override
  State<ShopOrderDetailExtendedDialog> createState() =>
      _ShopOrderDetailExtendedDialogState();
}

class _ShopOrderDetailExtendedDialogState
    extends State<ShopOrderDetailExtendedDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      secondaryButton: AppOutlinedButton(
        onPressed: () {
          context.router.maybePop();
        },
        text: context.tr.cancel,
        color: SemanticColor.neutral,
      ),
      primaryButton: AppFilledButton(
        color: SemanticColor.primary,
        onPressed: () {
          context.router.maybePop();
        },
        text: context.tr.confirm,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      maxWidth: 648,
      icon: BetterIcons.clock01Filled,
      title: context.tr.extendedDeliveryTime,
      onClosePressed: () {
        context.router.maybePop();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            context.tr.enterExtendedDeliveryTime,
            style: context.textTheme.bodyMedium?.variant(context),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                '${context.tr.estimateDeliveryTime}: ',
                style: context.textTheme.bodyMedium?.variant(context),
              ),
              Text(
                DateTime.now().formatTime,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.selectExtendedTime,
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (DateTime newDateTime) {},
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
