import 'package:better_design_system/atoms/status_badge/status_badge.dart';
import 'package:better_design_system/atoms/status_badge/status_badge_size.dart';
import 'package:better_design_system/atoms/status_badge/status_badge_type.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppStatusBadge)
Widget defaultStatusBadge(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      AppStatusBadge(
        statusBadgeType: StatusBadgeType.busy,
        statusBadgeSize: context.knobs.object.dropdown(
          label: 'size',
          options: StatusBadgeSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
      AppStatusBadge(
        statusBadgeType: StatusBadgeType.away,
        statusBadgeSize: context.knobs.object.dropdown(
          label: 'size',
          options: StatusBadgeSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
      AppStatusBadge(
        statusBadgeType: StatusBadgeType.online,
        statusBadgeSize: context.knobs.object.dropdown(
          label: 'size',
          options: StatusBadgeSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
      AppStatusBadge(
        statusBadgeType: StatusBadgeType.offline,
        statusBadgeSize: context.knobs.object.dropdown(
          label: 'size',
          options: StatusBadgeSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
    ],
  );
}
