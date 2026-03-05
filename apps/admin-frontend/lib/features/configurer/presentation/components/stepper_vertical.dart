import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/radio/radio.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class StepperVertical extends StatelessWidget {
  final List<String> steps;
  final int currentStep;

  const StepperVertical({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps
          .asMap()
          .map(
            (index, step) => MapEntry(
              index,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    width: 207,
                    duration: kThemeAnimationDuration,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      border: Border.all(
                        color: currentStep == index
                            ? context.colors.primary
                            : context.colors.outline,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            step,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: currentStep == index
                                  ? context.colors.onSurface
                                  : context.colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                        if (currentStep > index)
                          const AppRadio(groupValue: true, value: true),
                      ],
                    ),
                  ),
                  if (index != steps.length - 1)
                    Container(
                      margin: const EdgeInsets.only(left: 24),
                      width: 1.5,
                      color: context.colors.outline,
                      height: 32,
                    ),
                ],
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
