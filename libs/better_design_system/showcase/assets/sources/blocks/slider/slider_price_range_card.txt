import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/molecules/slider/range_slider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SliderPriceRangeCard extends StatelessWidget {
  const SliderPriceRangeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price Range', style: context.textTheme.titleSmall),
            SizedBox(height: 8),
            Text(
              'Choose price limits',
              style: context.textTheme.bodySmall?.variant(context),
            ),
            SizedBox(height: 24),
            AppRangeSlider(
              label: '',
              minValue: 0,
              maxValue: 100,
              showValueTooltip: false,
              values: RangeValues(24, 65),
              intermediateStepsCount: 3,
              onChanged: (value) {},
              knobType: SliderKnobType.ring,
            ),

            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 16,
              children: [
                Expanded(child: _buildTextField(context, 'minimun', '24')),
                Expanded(child: _buildTextField(context, 'maximum', '68')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(title, style: context.textTheme.labelLarge?.variant(context)),
        AppTextField(
          prefixIcon: Icon(
            BetterIcons.dollarCircleOutline,
            size: 20,
            color: context.colors.onSurfaceVariant,
          ),
          initialValue: value,
        ),
      ],
    );
  }
}
