import 'package:better_design_system/theme/theme.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class ReversedTheme extends StatelessWidget {
  final Widget child;

  const ReversedTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final BetterThemes baseTheme = context.colors.betterTheme;
    final Brightness reversedBrightness =
        context.colors.brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;

    final ThemeData reversedTheme = BetterTheme.reversedTheme(
      baseTheme,
      context.isDark,
    ).copyWith(brightness: reversedBrightness);

    return Theme(data: reversedTheme, child: child);
  }
}
