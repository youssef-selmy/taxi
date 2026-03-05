import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/enums/payout_session_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';

class PayoutMethodTabItem extends StatelessWidget {
  final Fragment$shopPayoutSessionPayoutMethodDetail payoutMethod;
  final String? selectedPayoutMethodId;
  final void Function(String) onPayoutMethodSelected;

  const PayoutMethodTabItem({
    super.key,
    required this.payoutMethod,
    required this.selectedPayoutMethodId,
    required this.onPayoutMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => onPayoutMethodSelected(payoutMethod.id),
      minimumSize: Size(0, 0),
      child: AnimatedContainer(
        width: 180,
        duration: kThemeAnimationDuration,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.outline,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? null : kShadow(context),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: kBorder(context),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: payoutMethod.payoutMethod.media.widget(
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                payoutMethod.payoutMethod.name,
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              payoutMethod.status.toChip(context),
            ],
          ),
        ),
      ),
    );
  }

  bool get isSelected => selectedPayoutMethodId == payoutMethod.id;
}
