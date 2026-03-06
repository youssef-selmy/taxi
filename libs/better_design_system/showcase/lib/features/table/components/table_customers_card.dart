import 'package:better_design_showcase/features/table/components/table_customers_data.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class TableCustomersCard extends StatelessWidget {
  const TableCustomersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1225,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.colors.outline,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Icon(
                      BetterIcons.userGroup03Filled,
                      size: 24,
                      color: context.colors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text('Customers', style: context.textTheme.titleSmall),
                      Text(
                        'List of all the clients registered',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppTextField(
                    constraints: BoxConstraints(maxWidth: 267),
                    hint: 'Search',
                    prefixIcon: Icon(
                      BetterIcons.search01Filled,
                      size: 20,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 16),
                  AppFilledButton(
                    onPressed: () {},
                    prefixIcon: BetterIcons.add01Outline,
                    text: 'Add User',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.5),
              child: const AppDivider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'Sort',
                      color: SemanticColor.neutral,
                      size: ButtonSize.medium,
                      prefix: Icon(
                        BetterIcons.arrowUpDownOutline,
                        size: 18,
                        color: context.colors.onSurfaceVariant,
                      ),
                      suffix: Icon(
                        BetterIcons.arrowDown01Outline,
                        size: 18,
                        color: context.colors.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.5),
                      child: Container(
                        width: 1,
                        decoration: BoxDecoration(
                          color: context.colors.outline,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'Filter',
                      color: SemanticColor.neutral,
                      size: ButtonSize.medium,
                      prefix: Icon(
                        BetterIcons.filterHorizontalOutline,
                        size: 18,
                        color: context.colors.onSurfaceVariant,
                      ),
                      suffix: Icon(
                        BetterIcons.arrowDown01Outline,
                        size: 18,
                        color: context.colors.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    const SizedBox(width: 8),
                    AppTextButton(
                      onPressed: () {},
                      text: 'Add Filter',
                      prefix: Icon(
                        BetterIcons.addSquareOutline,
                        size: 18,
                        color: context.colors.onSurfaceVariant,
                      ),
                      size: ButtonSize.medium,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.5),
                      child: Container(
                        width: 1,
                        decoration: BoxDecoration(
                          color: context.colors.outline,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AppIconButton(
                      icon: BetterIcons.file02Outline,
                      style: IconButtonStyle.outline,
                      size: ButtonSize.medium,
                    ),
                    const SizedBox(width: 8),
                    AppIconButton(
                      icon: BetterIcons.cloudDownloadOutline,
                      style: IconButtonStyle.outline,
                      size: ButtonSize.medium,
                    ),
                    const SizedBox(width: 8),
                    AppIconButton(
                      icon: BetterIcons.moreVerticalCircle01Outline,
                      style: IconButtonStyle.outline,
                      size: ButtonSize.medium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const TableCustomersData(),
          ],
        ),
      ),
    );
  }
}
