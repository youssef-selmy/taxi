import 'package:flutter/material.dart';

import 'package:better_design_system/colors/color_schemes/cobalt_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/coral_red_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/earthy_green_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/hyper_pink_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/electric_indigo_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/noir_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/sunburst_yellow_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/autumn_orange_color_scheme.light.dart';

import 'package:admin_frontend/core/components/brand_color.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension AppColorSchemeEnumX on Enum$AppColorScheme {
  BrandColor get toBrandColor => switch (this) {
    Enum$AppColorScheme.Cobalt => BrandColor(
      colors: [
        cobaltLightColorScheme.primary,
        cobaltLightColorScheme.secondary,
        cobaltLightColorScheme.tertiary,
      ],
    ),
    Enum$AppColorScheme.CoralRed => BrandColor(
      colors: [
        coralRedLightColorScheme.primary,
        coralRedLightColorScheme.secondary,
        coralRedLightColorScheme.tertiary,
      ],
    ),
    Enum$AppColorScheme.EarthyGreen => BrandColor(
      colors: [
        earthyGreenLightColorScheme.primary,
        earthyGreenLightColorScheme.secondary,
        earthyGreenLightColorScheme.tertiary,
      ],
    ),
    Enum$AppColorScheme.HyperPink => BrandColor(
      colors: [
        hyperPinkLightColorScheme.primary,
        hyperPinkLightColorScheme.secondary,
        hyperPinkLightColorScheme.tertiary,
      ],
    ),
    Enum$AppColorScheme.AutumnOrange => BrandColor(
      colors: [
        autumnOrangeLightColorScheme.primary,
        autumnOrangeLightColorScheme.secondary,
        autumnOrangeLightColorScheme.tertiary,
      ],
    ),
    Enum$AppColorScheme.SunburstYellow => BrandColor(
      colors: [
        sunburstYellowLightColorScheme.primary,
        sunburstYellowLightColorScheme.secondary,
        sunburstYellowLightColorScheme.tertiary,
      ],
    ),
    Enum$AppColorScheme.Noir => BrandColor(
      colors: [
        noirLightColorScheme.primary,
        noirLightColorScheme.secondary,
        noirLightColorScheme.tertiary,
      ],
    ),
    Enum$AppColorScheme.ElectricIndigo => BrandColor(
      colors: [
        electricIndigoLightColorScheme.primary,
        electricIndigoLightColorScheme.secondary,
        electricIndigoLightColorScheme.tertiary,
      ],
    ),
    Enum$AppColorScheme.$unknown => BrandColor(colors: []),
  };

  String title(BuildContext context) {
    switch (this) {
      case Enum$AppColorScheme.Cobalt:
        return "Cobalt";
      case Enum$AppColorScheme.CoralRed:
        return "Coral Red";
      case Enum$AppColorScheme.EarthyGreen:
        return "Earthy Green";
      case Enum$AppColorScheme.HyperPink:
        return "Hyper Pink";
      case Enum$AppColorScheme.AutumnOrange:
        return "Autumn Orange";
      case Enum$AppColorScheme.SunburstYellow:
        return "Sunburst Yellow";
      case Enum$AppColorScheme.Noir:
        return "Noir";
      case Enum$AppColorScheme.ElectricIndigo:
        return "Electric Indigo";

      case Enum$AppColorScheme.$unknown:
        return "Unknown";
    }
  }
}
