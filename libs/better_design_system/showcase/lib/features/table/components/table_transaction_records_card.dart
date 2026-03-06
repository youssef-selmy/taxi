import 'package:better_design_showcase/features/table/components/table_transaction_records_data.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class TableTransactionRecordsCard extends StatelessWidget {
  const TableTransactionRecordsCard({super.key});

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
                  Text(
                    'Transaction Records',
                    style: context.textTheme.titleSmall,
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
                    text: 'Insert',
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
            const TableTransactionRecordsData(),
          ],
        ),
      ),
    );
  }
}
