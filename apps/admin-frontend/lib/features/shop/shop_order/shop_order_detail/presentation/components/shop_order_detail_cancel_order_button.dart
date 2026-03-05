import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';

import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/dialogs/shop_order_detail_cancel_order_dialog.dart';

class ShopOrderDetailCancelOrderButton extends StatelessWidget {
  const ShopOrderDetailCancelOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppOutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) {
            return const ShopOrderDetailCancelOrderDialog();
          },
        );
      },
      text: context.tr.cancelOrder,
      color: SemanticColor.error,
    );
  }
}
