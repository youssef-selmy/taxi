import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/slider/slider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SliderImageClarityCard extends StatefulWidget {
  const SliderImageClarityCard({super.key});

  @override
  State<SliderImageClarityCard> createState() => _SliderImageClarityCardState();
}

class _SliderImageClarityCardState extends State<SliderImageClarityCard> {
  List<double> sliderValues = [20, 20, 20];

  void onSliderValueChanged(double value, int index) {
    setState(() {
      sliderValues[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Image Clarity', style: context.textTheme.labelLarge),
                Icon(
                  BetterIcons.cancelCircleOutline,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          AppDivider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    AppIconButton(
                      icon: BetterIcons.flashOutline,
                      style: IconButtonStyle.outline,
                      size: ButtonSize.medium,
                    ),
                    AppIconButton(
                      icon: BetterIcons.viewOutline,
                      style: IconButtonStyle.outline,
                      size: ButtonSize.medium,
                    ),
                  ],
                ),
                SizedBox(height: 12),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Assets.images.blocksComponent.home.image(
                    height: 288,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 24),
                Column(
                  spacing: 16,
                  children: [
                    AppSlider(
                      label: 'Contrast',
                      value: sliderValues[0],
                      onChanged: (value) {
                        onSliderValueChanged(value, 0);
                      },
                      showValueTooltip: false,
                      knobType: SliderKnobType.ring,
                    ),
                    AppSlider(
                      label: 'Saturation',
                      value: sliderValues[1],
                      onChanged: (value) {
                        onSliderValueChanged(value, 1);
                      },
                      showValueTooltip: false,
                      knobType: SliderKnobType.ring,
                    ),
                    AppSlider(
                      label: 'Temperature',
                      value: sliderValues[2],
                      onChanged: (value) {
                        onSliderValueChanged(value, 2);
                      },
                      showValueTooltip: false,
                      knobType: SliderKnobType.ring,
                    ),
                  ],
                ),
              ],
            ),
          ),

          AppDivider(height: 1),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              spacing: 12,
              children: <Widget>[
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Reset',
                    color: SemanticColor.neutral,
                  ),
                ),
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Save Changes',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
