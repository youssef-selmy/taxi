import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommercePricingCard extends StatelessWidget {
  const EcommercePricingCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Pricing', style: context.textTheme.titleSmall),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppTextField(
                        density: TextFieldDensity.noDense,
                        label: 'Price',
                        isFilled: false,
                        initialValue: '199.99',
                        prefixIcon: Icon(
                          BetterIcons.dollarCircleOutline,
                          color: context.colors.onSurfaceVariant,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppTextButton(
                        onPressed: () {},
                        text: 'Add discount',
                        size: ButtonSize.medium,
                        color: SemanticColor.primary,
                        prefixIcon: BetterIcons.add01Outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 16),
            child: Text(
              'Shipping and Delivery',
              style: context.textTheme.titleSmall,
            ),
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
              spacing: 12,
              children: [
                AppTextField(
                  label: 'Weight',
                  isFilled: false,
                  initialValue: '1.25',
                  suffixIcon: SizedBox(
                    width: 40,
                    child: AppDropdownField.single(
                      items: [AppDropdownItem(value: 'kg', title: 'Kg')],
                      initialValue: 'kg',
                      isFilled: false,
                      type: DropdownFieldType.inLine,
                    ),
                  ),
                ),
                AppTextField(
                  label: 'Length',
                  isFilled: false,
                  initialValue: '12.00',
                  suffixIcon: SizedBox(
                    width: 40,
                    child: AppDropdownField.single(
                      items: [AppDropdownItem(value: 'in', title: 'in')],
                      initialValue: 'in',
                      isFilled: false,
                      type: DropdownFieldType.inLine,
                    ),
                  ),
                ),
                AppTextField(
                  label: 'Width',
                  isFilled: false,
                  initialValue: '12.00',
                  suffixIcon: SizedBox(
                    width: 40,
                    child: AppDropdownField.single(
                      items: [AppDropdownItem(value: 'in', title: 'in')],
                      initialValue: 'in',
                      isFilled: false,
                      type: DropdownFieldType.inLine,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 16),
            child: Text('Selling Type', style: context.textTheme.titleSmall),
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
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    AppCheckbox(value: false, size: CheckboxSize.small),
                    const SizedBox(width: 8),
                    Text(
                      'In-store selling only',
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    AppCheckbox(value: true, size: CheckboxSize.small),
                    const SizedBox(width: 8),
                    Text(
                      'Online selling only',
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    AppCheckbox(value: false, size: CheckboxSize.small),
                    const SizedBox(width: 8),
                    Text(
                      'Available both in-store and online',
                      style: context.textTheme.labelLarge,
                    ),
                  ],
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pricing', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: AppTextField(
                  density: TextFieldDensity.noDense,
                  label: 'Price',
                  isFilled: false,
                  initialValue: '199.99',
                  prefixIcon: Icon(
                    BetterIcons.dollarCircleOutline,
                    color: context.colors.onSurfaceVariant,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {},
                  text: 'Add discount',
                  size: ButtonSize.medium,
                  color: SemanticColor.primary,
                  prefixIcon: BetterIcons.add01Outline,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.5),
            child: AppDivider(),
          ),
          Text('Shipping and Delivery', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Weight',
                  isFilled: false,
                  initialValue: '1.25',
                  suffixIcon: SizedBox(
                    width: 40,
                    child: AppDropdownField.single(
                      items: [AppDropdownItem(value: 'kg', title: 'Kg')],
                      initialValue: 'kg',
                      isFilled: false,
                      type: DropdownFieldType.inLine,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AppTextField(
                  label: 'Length',
                  isFilled: false,
                  initialValue: '12.00',
                  suffixIcon: SizedBox(
                    width: 40,
                    child: AppDropdownField.single(
                      items: [AppDropdownItem(value: 'in', title: 'in')],
                      initialValue: 'in',
                      isFilled: false,
                      type: DropdownFieldType.inLine,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AppTextField(
                  label: 'Width',
                  isFilled: false,
                  initialValue: '12.00',
                  suffixIcon: SizedBox(
                    width: 40,
                    child: AppDropdownField.single(
                      items: [AppDropdownItem(value: 'in', title: 'in')],
                      initialValue: 'in',
                      isFilled: false,
                      type: DropdownFieldType.inLine,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.5),
            child: AppDivider(),
          ),
          Text('Selling Type', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          Row(
            children: [
              AppCheckbox(value: false, size: CheckboxSize.small),
              const SizedBox(width: 8),
              Text(
                'In-store selling only',
                style: context.textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              AppCheckbox(value: true, size: CheckboxSize.small),
              const SizedBox(width: 8),
              Text('Online selling only', style: context.textTheme.labelLarge),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              AppCheckbox(value: false, size: CheckboxSize.small),
              const SizedBox(width: 8),
              Text(
                'Available both in-store and online',
                style: context.textTheme.labelLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
