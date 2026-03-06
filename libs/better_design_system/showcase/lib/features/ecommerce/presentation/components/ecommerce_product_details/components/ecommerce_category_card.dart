import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceCategoryCard extends StatelessWidget {
  const EcommerceCategoryCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Description', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppDropdownField.single(
                  items: [
                    AppDropdownItem(value: 'Sneakers', title: 'Sneakers'),
                    AppDropdownItem(value: 'Apparel', title: 'Apparel'),
                    AppDropdownItem(value: 'Accessories', title: 'Accessories'),
                  ],
                  label: 'Category',
                  isFilled: false,
                  initialValue: 'Sneakers',
                  type: DropdownFieldType.compact,
                ),
                const SizedBox(height: 12),
                AppDropdownField.single(
                  items: [
                    AppDropdownItem(value: 'Nike', title: 'Nike'),
                    AppDropdownItem(value: 'Adidas', title: 'Adidas'),
                    AppDropdownItem(value: 'Puma', title: 'Puma'),
                  ],
                  label: 'Brand',
                  isFilled: false,
                  initialValue: 'Nike',
                  type: DropdownFieldType.compact,
                ),
                const SizedBox(height: 12),
                AppTextButton(
                  onPressed: () {},
                  text: 'Add New Category',
                  size: ButtonSize.medium,
                  color: SemanticColor.primary,
                  prefixIcon: BetterIcons.add01Outline,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 16),
            child: Text('Inventory', style: context.textTheme.titleSmall),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                AppTextField(
                  label: 'Size',
                  isFilled: false,
                  initialValue: '12',
                ),
                AppNumberField.integer(
                  title: 'Quantity',
                  isFilled: false,
                  initialValue: 100,
                ),
                AppTextField(
                  label: 'SKU',
                  isFilled: false,
                  initialValue: 'AA-BB-CC-DD',
                ),
                AppTextButton(
                  onPressed: () {},
                  text: 'Add New Size',
                  size: ButtonSize.medium,
                  color: SemanticColor.primary,
                  prefixIcon: BetterIcons.add01Outline,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          AppDropdownField.single(
            items: [
              AppDropdownItem(value: 'Sneakers', title: 'Sneakers'),
              AppDropdownItem(value: 'Apparel', title: 'Apparel'),
              AppDropdownItem(value: 'Accessories', title: 'Accessories'),
            ],
            label: 'Category',
            isFilled: false,
            initialValue: 'Sneakers',
            type: DropdownFieldType.compact,
          ),
          const SizedBox(height: 12),
          AppDropdownField.single(
            items: [
              AppDropdownItem(value: 'Nike', title: 'Nike'),
              AppDropdownItem(value: 'Adidas', title: 'Adidas'),
              AppDropdownItem(value: 'Puma', title: 'Puma'),
            ],
            label: 'Brand',
            isFilled: false,
            initialValue: 'Nike',
            type: DropdownFieldType.compact,
          ),
          const SizedBox(height: 12),
          AppTextButton(
            onPressed: () {},
            text: 'Add New Category',
            size: ButtonSize.medium,
            color: SemanticColor.primary,
            prefixIcon: BetterIcons.add01Outline,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.5),
            child: AppDivider(),
          ),
          Text('Inventory', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Size',
                  isFilled: false,
                  initialValue: '12',
                ),
              ),
              Expanded(
                child: AppNumberField.integer(
                  title: 'Quantity',
                  isFilled: false,
                  initialValue: 100,
                ),
              ),
              Expanded(
                child: AppTextField(
                  label: 'SKU',
                  isFilled: false,
                  initialValue: 'AA-BB-CC-DD',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppTextButton(
            onPressed: () {},
            text: 'Add New Size',
            size: ButtonSize.medium,
            color: SemanticColor.primary,
            prefixIcon: BetterIcons.add01Outline,
          ),
        ],
      ),
    );
  }
}
