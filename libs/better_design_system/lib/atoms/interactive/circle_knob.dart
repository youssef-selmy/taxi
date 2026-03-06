import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/atoms/interactive/knob_state.dart';

export 'package:better_design_system/atoms/interactive/knob_state.dart';

typedef BetterCircleKnob = AppCircleKnob;

class AppCircleKnob extends StatelessWidget {
  final KnobState state;
  final SemanticColor semanticColor;

  const AppCircleKnob({
    super.key,
    this.state = KnobState.active,
    this.semanticColor = SemanticColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    Color outerColor;
    Color innerColor;

    if (state == KnobState.active) {
      outerColor = semanticColor.variantLow(context);
      innerColor = semanticColor.main(context);
    } else {
      // KnobState.inactive
      outerColor = context.colors.outlineVariant;
      innerColor = context.colors.onSurfaceVariantLow;
    }

    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(color: outerColor, shape: BoxShape.circle),
      child: Center(
        child: Container(
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: innerColor, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
