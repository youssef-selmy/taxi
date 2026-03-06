import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/atoms/interactive/knob_state.dart';

export 'package:better_design_system/atoms/interactive/knob_state.dart';

typedef BetterRingKnob = AppRingKnob;

class AppRingKnob extends StatelessWidget {
  final KnobState state;
  final double innerDiameter;
  final SemanticColor semanticColor;

  const AppRingKnob({
    super.key,
    this.state = KnobState.active,
    this.innerDiameter = 10.0,
    this.semanticColor = SemanticColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    final Color innerCircleColor = context.colors.surface;

    if (state == KnobState.active) {
      borderColor = semanticColor.main(context);
    } else {
      // KnobState.inactive
      borderColor = context.colors.onSurfaceVariantLow;
    }

    return Container(
      width: innerDiameter,
      height: innerDiameter,
      decoration: BoxDecoration(
        color: innerCircleColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 4.0,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
    );
  }
}
