import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/counter_input/counter_input.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_design_system/molecules/slider/slider.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SliderVolumeControlCard extends StatefulWidget {
  const SliderVolumeControlCard({super.key});

  @override
  State<SliderVolumeControlCard> createState() =>
      _SliderVolumeControlCardState();
}

class _SliderVolumeControlCardState extends State<SliderVolumeControlCard> {
  double sliderValue = 30;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  spacing: 12,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Icon(
                        BetterIcons.volumeHighOutline,
                        size: 24,
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                    Text('Volume Control', style: context.textTheme.titleSmall),
                  ],
                ),

                AppSwitch(isSelected: true, onChanged: null),
              ],
            ),

            SizedBox(height: 8),
            AppDivider(height: 20),
            SizedBox(height: 24),
            AppSlider(
              value: sliderValue,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
              showValueTooltip: false,
              knobType: SliderKnobType.ring,
              intermediateStepsCount: 0,
            ),
            SizedBox(height: 24),
            AppCounterInput(
              initialValue: int.parse(sliderValue.toStringAsFixed(0)),
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  sliderValue = double.parse(value.toString());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
