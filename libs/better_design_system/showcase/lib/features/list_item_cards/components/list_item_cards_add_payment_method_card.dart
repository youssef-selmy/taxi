import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class ListItemCardsAddPaymentMethodCard extends StatefulWidget {
  const ListItemCardsAddPaymentMethodCard({super.key});

  @override
  State<ListItemCardsAddPaymentMethodCard> createState() =>
      _ListItemCardsAddPaymentMethodCardState();
}

class _ListItemCardsAddPaymentMethodCardState
    extends State<ListItemCardsAddPaymentMethodCard> {
  int _selectedIndex = 0;
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 385,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Payment Method', style: context.textTheme.titleSmall),
            const SizedBox(height: 16),
            Column(
              spacing: 8,
              children: [
                _buildPaymentOption(
                  index: 0,
                  title: 'Credit Card or Debit Card',
                  icon: BetterIcons.creditCardFilled,
                ),
                _buildPaymentOption(
                  index: 1,
                  title: 'Bank Account',
                  icon: BetterIcons.bankFilled,
                ),
                _buildPaymentOption(
                  index: 2,
                  title: 'PayPal',
                  imageAsset: Assets.images.paymentMethods.paypalPng,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required int index,
    required String title,
    IconData? icon,
    AssetGenImage? imageAsset,
  }) {
    final isSelected = _selectedIndex == index;
    final isHovered = _hoveredIndex == index;

    return FocusableActionDetector(
      onShowHoverHighlight: (hovered) {
        setState(() {
          _hoveredIndex = hovered ? index : null;
        });
      },
      child: AppListItem(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color:
                isHovered
                    ? context.colors.surfaceVariantLow
                    : context.colors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.colors.outline),
          ),
          alignment: Alignment.center,
          child:
              icon != null
                  ? Icon(icon, color: context.colors.primary, size: 20)
                  : imageAsset!.image(width: 20, height: 20),
        ),
        isSelected: isSelected,
        title: title,
        actionType: ListItemActionType.radio,
        onTap: (_) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
