import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class EcommerceDescriptionCard extends StatelessWidget {
  const EcommerceDescriptionCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Description', style: context.textTheme.titleSmall),
          Container(
            padding: const EdgeInsets.all(16),
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
                AppTextField(
                  label: 'Name',
                  isFilled: false,
                  initialValue: 'Nike Air Force 1',
                ),
                const SizedBox(height: 18),
                AppTextField(
                  label: 'Description',
                  isFilled: false,
                  hint: 'Placeholder',
                  maxLines: 5,
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
          Text('Description', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Name',
            isFilled: false,
            initialValue: 'Nike Air Force 1',
          ),
          const SizedBox(height: 18),
          AppTextField(
            label: 'Description',
            isFilled: false,
            hint: 'Placeholder',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
