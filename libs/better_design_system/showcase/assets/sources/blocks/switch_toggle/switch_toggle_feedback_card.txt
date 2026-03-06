import 'package:better_design_system/atoms/buttons/bordered_toggle_button.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:flutter/material.dart';

enum Points { nicePoints, navigativePoints }

class SwitchToggleFeedbackCard extends StatefulWidget {
  const SwitchToggleFeedbackCard({super.key});

  @override
  State<SwitchToggleFeedbackCard> createState() =>
      _SwitchToggleFeedbackCardState();
}

class _SwitchToggleFeedbackCardState extends State<SwitchToggleFeedbackCard> {
  Points selectedPoint = Points.nicePoints;

  final List<String> nicePoints = [
    'Safe Driving',
    'Fast Driving',
    'Clean Vehicle',
    'Polite Driver',
    'Good Smell',
  ];
  final List<String> negativePoints = [
    'Rude Driver',
    'Dirty Vehicle',
    'Late Arrival',
    'Unsafe Driving',
    'Uncomfortable Ride',
  ];

  List<String> selectedNicePoints = ['Polite Driver'];

  List<String> selectedNegativePoints = ['Unsafe Driving'];

  void onNicePointSelected(String value) {
    if (selectedNicePoints.contains(value)) {
      setState(() {
        selectedNicePoints.removeWhere((element) => element == value);
      });
    } else {
      setState(() {
        selectedNicePoints.add(value);
      });
    }
  }

  void onNegativePointSelected(String value) {
    if (selectedNegativePoints.contains(value)) {
      setState(() {
        selectedNegativePoints.removeWhere((element) => element == value);
      });
    } else {
      setState(() {
        selectedNegativePoints.add(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 385,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppToggleSwitchButtonGroup<Points>(
              isExpanded: true,

              options:
                  Points.values
                      .map(
                        (e) => ToggleSwitchButtonGroupOption(
                          value: e,
                          label: e.title,
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPoint = value;
                });
              },
              selectedValue: selectedPoint,
            ),

            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: switch (selectedPoint) {
                Points.nicePoints => Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    ...nicePoints.map(
                      (nicePoint) => AppBorderedToggleButton(
                        label: nicePoint,
                        isSelected: selectedNicePoints.contains(nicePoint),
                        onPressed: () {
                          onNicePointSelected(nicePoint);
                        },
                        color: SemanticColor.success,
                      ),
                    ),
                  ],
                ),

                Points.navigativePoints => Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    ...negativePoints.map(
                      (negativePoint) => AppBorderedToggleButton(
                        label: negativePoint,
                        isSelected: selectedNegativePoints.contains(
                          negativePoint,
                        ),
                        onPressed: () {
                          onNegativePointSelected(negativePoint);
                        },
                        color: SemanticColor.error,
                      ),
                    ),
                  ],
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension PointsTitle on Points {
  String get title {
    switch (this) {
      case Points.nicePoints:
        return 'Nice points';
      case Points.navigativePoints:
        return 'Navigative points';
    }
  }
}
