import 'package:better_design_system/theme/theme.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'main.directories.g.dart';

void main() => runApp(const WidgetbookApp());

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [...directories],
      lightTheme: BetterTheme.noirLightTheme(context.isDesktop),
      darkTheme: BetterTheme.noirDarkTheme(context.isDesktop),
      themeMode: ThemeMode.system,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Cobalt (Light)',
              data: BetterTheme.cobaltLight(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Cobalt (Dark)',
              data: BetterTheme.cobaltDark(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Indigo (Light)',
              data: BetterTheme.indigoLight(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Indigo (Dark)',
              data: BetterTheme.indigoDark(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Coral Red (Light)',
              data: BetterTheme.coralRedLight(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Coral Red (Dark)',
              data: BetterTheme.coralRedDark(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Earthy Green (Light)',
              data: BetterTheme.earthyGreenLight(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Earthy Green (Dark)',
              data: BetterTheme.earthyGreenDark(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Noir (Light)',
              data: BetterTheme.noirLightTheme(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Noir (Dark)',
              data: BetterTheme.noirDarkTheme(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Hyper Pink (Light)',
              data: BetterTheme.hyperPinkLightTheme(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Hyper Pink (Dark)',
              data: BetterTheme.hyperPinkDarkTheme(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Sunburst Yellow (Light)',
              data: BetterTheme.sunburstYellowLightTheme(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Sunburst Yellow (Dark)',
              data: BetterTheme.sunburstYellowDarkTheme(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Autumn Orange (Light)',
              data: BetterTheme.autumnOrangeLightTheme(context.isDesktop),
            ),
            WidgetbookTheme(
              name: 'Autumn Orange (Dark)',
              data: BetterTheme.autumnOrangeDarkTheme(context.isDesktop),
            ),
          ],
        ),
        InspectorAddon(),
        ViewportAddon([
          Viewports.none,
          IosViewports.iPhone13,
          IosViewports.iPadPro11Inches,
          MacosViewports.macbookPro,
        ]),
        AlignmentAddon(initialAlignment: Alignment.center),
      ],
    );
  }
}
