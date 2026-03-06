import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:better_design_system/templates/map_settings_screen/map_settings_item.dart';

@UseCase(name: 'Default', type: MapSettingItem)
Widget defaultMapSettingsItem(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: SizedBox(
      width: 500,
      child: MapSettingItem(
        title: 'Google Maps',
        shortComings: [
          'Requires internet connection',
          'Limited offline capabilities',
        ],
        badge: AppBadge(
          text: 'Unavailable on Desktop',
          color: SemanticColor.warning,
          isRounded: true,
        ),
        image: Assets.images.mapPreviews.googlemap,
        isActive: context.knobs.boolean(label: 'Is Active', initialValue: true),
        benefits: ['High accuracy', 'Extensive coverage', 'Regular updates'],
        isDisabled: context.knobs.boolean(
          label: 'Is Disabled',
          initialValue: false,
        ),
        isSelected: context.knobs.boolean(
          label: 'Is Selected',
          initialValue: false,
        ),
        onPressed: () {},
      ),
    ),
  );
}
