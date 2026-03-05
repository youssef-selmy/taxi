import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_localization/localizations.dart';

import 'package:better_icons/better_icons.dart';

class OrderConfirmed extends StatelessWidget {
  const OrderConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      icon: BetterIcons.checkmarkCircle02Filled,
      title: context.tr.orderConfirmed,
      subtitle: context.tr.orderConfirmedSuccessfully,
      primaryButton: AppFilledButton(
        text: context.tr.ok,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      child: const SizedBox(),
    );
  }
}
