import 'package:better_design_showcase/features/pagination/components/pagination_orders_table.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class PaginationOrdersCard extends StatelessWidget {
  const PaginationOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text('Orders', style: context.textTheme.titleMedium),
                    Text(
                      'List of all orders with current status',
                      style: context.textTheme.labelLarge!.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 358,
                  child: AppTextField(
                    prefixIcon: Icon(
                      BetterIcons.search01Filled,
                      color: context.colors.onSurfaceVariant,
                      size: 20,
                    ),
                    density: TextFieldDensity.dense,
                    hint: 'Search',
                    isFilled: false,
                  ),
                ),
                const SizedBox(width: 12),
                AppIconButton(
                  icon: BetterIcons.filterHorizontalOutline,
                  style: IconButtonStyle.outline,
                ),
                const SizedBox(width: 12),
                AppOutlinedButton(
                  onPressed: () {},
                  text: 'Export',
                  prefixIcon: BetterIcons.arrowDown03Outline,
                  color: SemanticColor.neutral,
                ),
                const SizedBox(width: 12),
                AppFilledButton(
                  onPressed: () {},
                  prefixIcon: BetterIcons.add01Outline,
                  text: 'New Order',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 21.5),
              child: const PaginationOrdersTable(),
            ),
          ],
        ),
      ),
    );
  }
}
