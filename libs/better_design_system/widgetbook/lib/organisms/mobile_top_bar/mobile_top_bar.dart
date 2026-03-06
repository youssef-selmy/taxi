import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppMobileTopBar)
Widget defaultMobileTopBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(100),
    child: Container(
      color: context.colors.surfaceVariant,
      child: Column(
        children: [
          SafeArea(
            child: AppMobileTopBar(
              onBackPressed: () {},
              isFilled: context.knobs.boolean(
                label: 'isFilled',
                initialValue: false,
              ),
              childAlignment: context.knobs.object.dropdown(
                label: 'Child Alignment',
                options: MobileTopBarChildAlignment.values,
                initialOption: MobileTopBarChildAlignment.center,
              ),
              suffixActions: [
                AppIconButton(
                  icon: BetterIcons.search01Filled,
                  onPressed: () {},
                ),
                AppIconButton(icon: BetterIcons.add01Filled, onPressed: () {}),
              ],
              child: const Text('Sample Child Widget'),
            ),
          ),
        ],
      ),
    ),
  );
}
