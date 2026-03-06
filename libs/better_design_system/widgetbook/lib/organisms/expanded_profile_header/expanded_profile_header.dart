import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/organisms/expanded_profile_header/expanded_profile_header.dart';
import 'package:better_design_system/templates/profile_screen_template/profile_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppExpandedProfileHeader)
Widget defaultExpandedProfileHeader(BuildContext context) {
  return AppExpandedProfileHeader(
    title: 'User Name',
    headerBackgroundType: context.knobs.object
        .dropdown<ProfileHeaderBackgroundType>(
          label: 'Header Background Type',
          options: ProfileHeaderBackgroundType.values,
          initialOption: ProfileHeaderBackgroundType.empty,
          labelBuilder: (value) => value.name,
        ),
    subtitle: 'User Subtitle',
    avatarUrl: 'https://example.com/avatar.jpg',
    kpiItems: [
      KpiItem(title: 'KPI Title', value: 'KPI Value', icon: Icons.star),
      KpiItem(
        title: 'KPI Title',
        value: 'KPI Value',
        icon: Icons.star,
        iconColor: SemanticColor.warning,
      ),
    ],
  );
}
