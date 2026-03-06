import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/templates/appearance_screen_template/theme_item.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

typedef BetterAppearanceScreenTemplate = AppAppearanceScreenTemplate;

class AppAppearanceScreenTemplate extends StatelessWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) onThemeModeChanged;

  final BetterThemes theme;
  final Function(BetterThemes) onThemeChanged;

  final bool canChangeTheme;

  const AppAppearanceScreenTemplate({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    required this.theme,
    required this.onThemeChanged,
    required this.canChangeTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: context.colors.surface,
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.strings.appearance,
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              "Select Light, Dark, or follow System setting",
              style: context.textTheme.bodySmall?.variant(context),
            ),
            const SizedBox(height: 12),
            AppListItem(
              isCompact: true,
              title: context.strings.darkLightSystemDefault,
              subtitle: context.strings.darkLightSystemDefaultDescription,
              actionType: ListItemActionType.switcher,
              onTap: (value) {
                if (value) {
                  onThemeModeChanged(ThemeMode.system);
                } else {
                  onThemeModeChanged(
                    context.isDark ? ThemeMode.dark : ThemeMode.light,
                  );
                }
              },
              isSelected: themeMode == ThemeMode.system,
            ),
            const SizedBox(height: 12),
            if (themeMode != ThemeMode.system) ...[
              AppListItem(
                borderRadius: BorderRadius.circular(99),
                padding: const EdgeInsets.all(8),
                actionType: ListItemActionType.radio,
                onTap: (value) {
                  if (value) {
                    onThemeModeChanged(ThemeMode.light);
                  }
                },
                isSelected: themeMode == ThemeMode.light,
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceVariantLow,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    BetterIcons.sun01Filled,
                    color: context.colors.warning,
                  ),
                ),
                title: context.strings.lightMode,
              ),
              const SizedBox(height: 12),
              Theme(
                data: BetterTheme.fromBetterTheme(
                  context.colors.betterTheme,
                  false,
                  true,
                ),
                child: AppListItem(
                  borderRadius: BorderRadius.circular(99),
                  padding: const EdgeInsets.all(8),
                  actionType: ListItemActionType.radio,
                  onTap: (value) {
                    if (value) {
                      onThemeModeChanged(ThemeMode.dark);
                    }
                  },
                  isSelected: themeMode == ThemeMode.dark,
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceVariantLow,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      BetterIcons.moon02Filled,
                      color: context.colors.warning,
                    ),
                  ),
                  title: context.strings.darkMode,
                ),
              ),
            ],
            const SizedBox(height: 24),
            if (canChangeTheme) ...[
              Row(
                spacing: 8,
                children: [
                  Text("Brand Colors", style: context.textTheme.titleSmall),
                  const AppBadge(
                    text: "Only in Demo",
                    isRounded: true,
                    color: SemanticColor.info,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Select your brand colors",
                style: context.textTheme.bodySmall?.variant(context),
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = context.isMobile;
                  final crossAxisCount = isMobile ? 2 : 3;
                  return LayoutGrid(
                    rowSizes: List.generate(
                      (BetterThemes.values.length / crossAxisCount).ceil(),
                      (_) => auto,
                    ),
                    columnSizes: List.generate(crossAxisCount, (_) => 1.fr),
                    rowGap: 8,
                    columnGap: 8,
                    children: [
                      for (final theme in BetterThemes.values)
                        AppThemeItem(
                          theme: theme,
                          onPressed: () {
                            onThemeChanged(theme);
                          },
                          isSelected: this.theme == theme,
                        ),
                    ],
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
