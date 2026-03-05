import 'package:better_design_system/theme/theme.dart';

import 'package:admin_frontend/schema.graphql.dart';

class AppTheme {
  static BetterThemes fromColorScheme(Enum$AppColorScheme colorScheme) =>
      switch (colorScheme) {
        Enum$AppColorScheme.Cobalt => BetterThemes.cobalt,
        Enum$AppColorScheme.EarthyGreen => BetterThemes.earthyGreen,
        Enum$AppColorScheme.HyperPink => BetterThemes.hyperPink,
        Enum$AppColorScheme.ElectricIndigo => BetterThemes.electricIndigo,
        Enum$AppColorScheme.Noir => BetterThemes.noir,
        Enum$AppColorScheme.CoralRed => BetterThemes.coralRed,
        Enum$AppColorScheme.AutumnOrange => BetterThemes.autumnOrange,
        Enum$AppColorScheme.SunburstYellow => BetterThemes.sunburstYellow,
        Enum$AppColorScheme.$unknown => BetterThemes.noir,
      };
}
