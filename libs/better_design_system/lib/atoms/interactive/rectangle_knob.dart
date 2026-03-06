import 'package:better_design_system/atoms/interactive/knob_state.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

export 'package:better_design_system/atoms/interactive/knob_state.dart';

typedef BetterRectangleKnob = AppRectangleKnob;

class AppRectangleKnob extends StatelessWidget {
  final KnobState state;
  final double width;
  final double height;
  final SemanticColor semanticColor;

  const AppRectangleKnob({
    super.key,
    this.state = KnobState.active,
    this.width = 4.0,
    this.height = 22.0,
    this.semanticColor = SemanticColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    Color knobColor;

    if (state == KnobState.active) {
      knobColor = semanticColor.main(context);
    } else {
      // KnobState.inactive
      knobColor = context.colors.onSurfaceVariantLow;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: knobColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}
