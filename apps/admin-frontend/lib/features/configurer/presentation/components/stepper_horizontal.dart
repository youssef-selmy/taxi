import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class StepperHorizontal extends StatelessWidget {
  final List<String> steps;
  final int currentStep;
  final Function(int) onStepSelected;

  const StepperHorizontal({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.onStepSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: steps
          .map((step) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                onStepSelected(steps.indexOf(step));
              },
              minimumSize: Size(0, 0),
              child: AnimatedContainer(
                duration: kThemeAnimationDuration,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: Border.all(
                    color: currentStep == steps.indexOf(step)
                        ? context.colors.primary
                        : context.colors.outline,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  step,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: currentStep == steps.indexOf(step)
                        ? context.colors.onSurface
                        : context.colors.onSurfaceVariant,
                  ),
                ),
              ),
            );
          })
          .toList()
          .separated(
            separator: Container(
              color: context.colors.outline,
              height: 2,
              width: 16,
            ),
          ),
    );
  }
}
