import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:flutter/cupertino.dart';

class QuantityButton extends StatelessWidget {
  final int quantity;
  final int maxQuantity;
  final void Function(int) onQuantityChanged;

  const QuantityButton({
    super.key,
    required this.quantity,
    required this.maxQuantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        AppOutlinedButton(
          isDisabled: quantity <= 0,
          onPressed: () => onQuantityChanged(quantity - 1),
          prefixIcon: BetterIcons.remove01Filled,
          color: SemanticColor.neutral,
        ),
        Text(quantity.toString()),
        AppFilledButton(
          isDisabled: quantity >= maxQuantity,
          onPressed: () {
            onQuantityChanged(quantity + 1);
          },
          prefixIcon: BetterIcons.addCircleFilled,
        ),
      ],
    );
  }
}
