import 'package:better_design_system/colors/color_schemes/autumn_orange_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/autumn_orange_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/hera_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/hera_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/sunburst_yellow_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/sunburst_yellow_color_scheme.light.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_assets/assets.dart';

import 'package:better_design_system/colors/color_schemes/cobalt_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/cobalt_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/coral_red_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/coral_red_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/earthy_green_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/earthy_green_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/hyper_pink_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/hyper_pink_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/electric_indigo_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/electric_indigo_color_scheme.light.dart';
import 'package:better_design_system/colors/color_schemes/noir_color_scheme.dark.dart';
import 'package:better_design_system/colors/color_schemes/noir_color_scheme.light.dart';
import 'package:better_design_system/colors/color_system.dart';
import 'package:better_design_system/typography/typography.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

part 'theme.input.dart';

class BetterTheme {
  static ThemeData _generateTheme(
    bool isDesktop,
    ColorSystem colorSystem,
    bool isDark,
  ) {
    final textTheme = AppTextStyle.textTheme;
    final colorScheme = colorSystem.toScheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: colorSystem.onSurface,
      ),
      fontFamily: BetterFonts.inter,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorSystem.surface,
      badgeTheme: BadgeThemeData(backgroundColor: colorSystem.error),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.labelMedium,
      ),
      popupMenuTheme: PopupMenuThemeData(textStyle: textTheme.labelMedium),
      tabBarTheme: TabBarThemeData(
        labelColor: colorSystem.onSurface,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        unselectedLabelColor: colorSystem.onSurfaceVariant,
        splashFactory: NoSplash.splashFactory,
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: textTheme.bodyMedium,
        checkboxHorizontalMargin: 10,
        dataTextStyle: textTheme.bodyMedium,
        dataRowMinHeight: 64,
        headingRowColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return colorScheme.surfaceContainer.withValues(alpha: 0.12);
          } else {
            return colorScheme.surfaceContainer;
          }
        }),
        horizontalMargin: 4,
        decoration: BoxDecoration(
          border: Border.all(color: colorSystem.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        headingRowHeight: 45,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: colorSystem.onSurface,
        backgroundColor: colorSystem.surface,
        textColor: colorSystem.onSurface,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorSystem.onSurface,
      ),
      dividerTheme: DividerThemeData(
        color: colorSystem.outline,
        thickness: 1.5,
      ),
      dividerColor: colorSystem.outline,
      bottomSheetTheme: const BottomSheetThemeData(),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      dialogTheme: DialogThemeData(
        barrierColor: Colors.white.withAlpha(25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: inputTheme(textTheme, colorSystem),

      datePickerTheme: DatePickerThemeData(
        dayShape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorSystem.primary;
          } else {
            return Colors.transparent;
          }
        }),
        side: BorderSide(color: colorSystem.outlineVariant, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
      cardTheme: CardThemeData(
        shadowColor: colorSystem.shadow,
        color: colorSystem.surface,
        surfaceTintColor: colorSystem.surface,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: colorSystem.outline, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return colorSystem.surface.withValues(alpha: 0.8);
            } else if (states.isHovered) {
              return colorSystem.primaryContainer;
            } else if (states.isPressed) {
              return colorSystem.surface;
            } else {
              return colorSystem.primary;
            }
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return colorSystem.onSurface.withValues(alpha: 0.8);
            } else {
              return colorSystem.onPrimary;
            }
          }),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          ),
          textStyle: WidgetStatePropertyAll(textTheme.labelMedium),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: WidgetStateProperty.resolveWith((states) {
            if (states.isHovered || states.isPressed) {
              return BorderSide(width: 1, color: colorSystem.primaryContainer);
            } else {
              return BorderSide(width: 1, color: colorSystem.outlineVariant);
            }
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return colorSystem.onSurface.withValues(alpha: 0.8);
            } else {
              return colorSystem.onSurface;
            }
          }),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          ),
          textStyle: WidgetStatePropertyAll(textTheme.labelMedium),
          // backgroundColor: WidgetStateProperty.resolveWith(
          //   (states) {
          //     if (states.isDisabled) {
          //       return colorSystem.surface.withValues(alpha: 0.8);
          //     } else if (states.isHovered) {
          //       return colorSystem.primaryContainer;
          //     } else if (states.isPressed) {
          //       return colorSystem.surface;
          //     } else {
          //       return colorSystem.surface;
          //     }
          //   },
          // ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return colorSystem.onSurface;
          } else if (states.isHovered) {
            return states.isSelected
                ? colorSystem.primary
                : colorSystem.outlineVariant;
          } else if (states.isFocused) {
            return states.isSelected
                ? colorSystem.primary
                : colorSystem.outlineVariant;
          } else if (states.isPressed) {
            return states.isSelected
                ? colorSystem.primary
                : colorSystem.outlineVariant;
          } else {
            return states.isSelected
                ? colorSystem.primary
                : colorSystem.outlineVariant;
          }
        }),
        overlayColor: WidgetStateProperty.fromMap({
          WidgetState.hovered: colorSystem.onSurface.withValues(alpha: 0.08),
          WidgetState.focused: colorSystem.onSurface.withValues(alpha: 0.12),
          WidgetState.pressed: colorSystem.primaryContainer,
          WidgetState.any: colorSystem.surface,
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            if (states.isSelected) {
              return const Color(0xFFFAF9FD);
            } else {
              return colorScheme.surfaceContainerLow;
            }
          } else {
            if (states.isSelected && !states.isHovered) {
              return colorSystem.surface;
            }
            if ((states.isSelected && states.isHovered) ||
                (states.isSelected && states.isPressed)) {
              return colorSystem.primaryContainer;
            }
            return colorScheme.surfaceContainerLow;
          }
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.isSelected) {
            if (states.isDisabled) {
              return colorSystem.outlineVariant;
            } else {
              return colorSystem.primary;
            }
          } else {
            if (states.isDisabled) {
              return const Color(0x1EE7E0EC);
            } else {
              return colorSystem.outlineVariant;
            }
          }
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return colorSystem.outlineVariant;
          } else {
            if (states.isSelected) {
              return colorSystem.primary;
            }
            return colorScheme.surfaceContainerLow;
          }
        }),
      ),
      extensions: [colorSystem],
    );
  }

  static ThemeData indigoLight(bool isDesktop) =>
      _generateTheme(isDesktop, electricIndigoLightColorScheme, false);
  static ThemeData indigoDark(bool isDesktop) =>
      _generateTheme(isDesktop, electricIndigoDarkColorScheme, true);
  static ThemeData cobaltLight(bool isDesktop) =>
      _generateTheme(isDesktop, cobaltLightColorScheme, false);
  static ThemeData cobaltDark(bool isDesktop) =>
      _generateTheme(isDesktop, cobaltDarkColorScheme, true);
  static ThemeData coralRedLight(bool isDesktop) =>
      _generateTheme(isDesktop, coralRedLightColorScheme, false);
  static ThemeData coralRedDark(bool isDesktop) =>
      _generateTheme(isDesktop, coralRedDarkColorScheme, true);
  static ThemeData earthyGreenLight(bool isDesktop) =>
      _generateTheme(isDesktop, earthyGreenLightColorScheme, false);
  static ThemeData earthyGreenDark(bool isDesktop) =>
      _generateTheme(isDesktop, earthyGreenDarkColorScheme, true);
  static ThemeData noirLightTheme(bool isDesktop) =>
      _generateTheme(isDesktop, noirLightColorScheme, false);
  static ThemeData noirDarkTheme(bool isDesktop) =>
      _generateTheme(isDesktop, noirDarkColorScheme, true);
  static ThemeData hyperPinkDarkTheme(bool isDesktop) =>
      _generateTheme(isDesktop, hyperPinkDarkColorScheme, true);
  static ThemeData hyperPinkLightTheme(bool isDesktop) =>
      _generateTheme(isDesktop, hyperPinkLightColorScheme, false);
  static ThemeData sunburstYellowLightTheme(bool isDesktop) =>
      _generateTheme(isDesktop, sunburstYellowLightColorScheme, false);
  static ThemeData sunburstYellowDarkTheme(bool isDesktop) =>
      _generateTheme(isDesktop, sunburstYellowDarkColorScheme, true);
  static ThemeData autumnOrangeLightTheme(bool isDesktop) =>
      _generateTheme(isDesktop, autumnOrangeLightColorScheme, false);
  static ThemeData autumnOrangeDarkTheme(bool isDesktop) =>
      _generateTheme(isDesktop, autumnOrangeDarkColorScheme, true);
  static ThemeData heraLightTheme(bool isDesktop) =>
      _generateTheme(isDesktop, heraLightColorScheme, false);
  static ThemeData heraDarkTheme(bool isDesktop) =>
      _generateTheme(isDesktop, heraDarkColorScheme, true);

  static ThemeData fromBetterTheme(
    BetterThemes theme,
    bool isDesktop,
    bool isDark,
  ) => switch (theme) {
    BetterThemes.electricIndigo =>
      isDark ? indigoDark(isDesktop) : indigoLight(isDesktop),
    BetterThemes.cobalt =>
      isDark ? cobaltDark(isDesktop) : cobaltLight(isDesktop),
    BetterThemes.coralRed =>
      isDark ? coralRedDark(isDesktop) : coralRedLight(isDesktop),
    BetterThemes.earthyGreen =>
      isDark ? earthyGreenDark(isDesktop) : earthyGreenLight(isDesktop),
    BetterThemes.noir =>
      isDark ? noirDarkTheme(isDesktop) : noirLightTheme(isDesktop),
    BetterThemes.hyperPink =>
      isDark ? hyperPinkDarkTheme(isDesktop) : hyperPinkLightTheme(isDesktop),
    BetterThemes.sunburstYellow =>
      isDark
          ? sunburstYellowDarkTheme(isDesktop)
          : sunburstYellowLightTheme(isDesktop),
    BetterThemes.autumnOrange =>
      isDark
          ? autumnOrangeDarkTheme(isDesktop)
          : autumnOrangeLightTheme(isDesktop),
    BetterThemes.hera =>
      isDark ? heraDarkTheme(isDesktop) : heraLightTheme(isDesktop),
  };

  static ThemeData reversedTheme(BetterThemes theme, bool isDark) =>
      fromBetterTheme(
        theme,
        false,
        !isDark,
      ).copyWith(brightness: isDark ? Brightness.light : Brightness.dark);
}

enum BetterThemes {
  electricIndigo,
  cobalt,
  coralRed,
  earthyGreen,
  noir,
  hyperPink,
  sunburstYellow,
  autumnOrange,
  hera;

  String get name => switch (this) {
    BetterThemes.electricIndigo => 'Electric Indigo',
    BetterThemes.cobalt => 'Cobalt',
    BetterThemes.coralRed => 'Coral Red',
    BetterThemes.earthyGreen => 'Earthy Green',
    BetterThemes.noir => 'Noir',
    BetterThemes.hyperPink => 'Hyper Pink',
    BetterThemes.sunburstYellow => 'Sunburst Yellow',
    BetterThemes.autumnOrange => 'Autumn Orange',
    BetterThemes.hera => 'Hera',
  };

  ThemeData themeData(bool isDesktop, bool isDark) =>
      BetterTheme.fromBetterTheme(this, isDesktop, isDark);
}
