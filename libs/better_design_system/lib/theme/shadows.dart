import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum BetterShadow {
  shadow0,
  shadow2,
  shadow4,
  shadow8,
  shadow12,
  shadow16,
  shadow24,
  shadow32,
  shadow40,
  shadow48,
  shadowCard,
  shadowDropdown,
  shadowDialog;

  BoxShadow toBoxShadow(BuildContext context) => switch (this) {
    BetterShadow.shadow0 => kShadow0(context),
    BetterShadow.shadow2 => kShadow2(context),
    BetterShadow.shadow4 => kShadow4(context),
    BetterShadow.shadow8 => kShadow8(context),
    BetterShadow.shadow12 => kShadow12(context),
    BetterShadow.shadow16 => kShadow16(context),
    BetterShadow.shadow24 => kShadow24(context),
    BetterShadow.shadow32 => kShadow32(context),
    BetterShadow.shadow40 => kShadow40(context),
    BetterShadow.shadow48 => kShadow48(context),
    BetterShadow.shadowCard => kShadowCard(context),
    BetterShadow.shadowDropdown => kShadowDropdown(context),
    BetterShadow.shadowDialog => kShadowDialog(context),
  };
}

BoxShadow kShadow0(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 0),
  blurRadius: 0,
  spreadRadius: 0,
);

BoxShadow kShadow2(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 1),
  blurRadius: 2,
  spreadRadius: 0,
);

BoxShadow kShadow4(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 2),
  blurRadius: 4,
  spreadRadius: 0,
);

BoxShadow kShadow8(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 4),
  blurRadius: 8,
  spreadRadius: 0,
);

BoxShadow kShadow12(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 6),
  blurRadius: 12,
  spreadRadius: 0,
);

BoxShadow kShadow16(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 8),
  blurRadius: 16,
  spreadRadius: 0,
);

BoxShadow kShadow24(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 12),
  blurRadius: 24,
  spreadRadius: 0,
);

BoxShadow kShadow32(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 16),
  blurRadius: 32,
  spreadRadius: 0,
);

BoxShadow kShadow40(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 20),
  blurRadius: 40,
  spreadRadius: 0,
);

BoxShadow kShadow48(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 24),
  blurRadius: 48,
  spreadRadius: 0,
);

BoxShadow kShadowCard(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 12),
  blurRadius: 24,
  spreadRadius: 0,
);

BoxShadow kShadowDropdown(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 20),
  blurRadius: 40,
  spreadRadius: 0,
);

BoxShadow kShadowDialog(BuildContext context) => BoxShadow(
  color: context.colors.shadow,
  offset: const Offset(0, 24),
  blurRadius: 8,
  spreadRadius: 0,
);
