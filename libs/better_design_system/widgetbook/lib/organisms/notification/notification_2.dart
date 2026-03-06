import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_icons/better_icon.dart';
import 'package:better_design_system/organisms/notification/notification_2.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppNotification2)
Widget defaultNotification2(BuildContext context) {
  final isUnread = context.knobs.boolean(
    label: 'Is Unread',
    initialValue: false,
  );
  final badgeText = context.knobs.stringOrNull(label: 'Badge Text');
  final title = context.knobs.stringOrNull(
    label: 'Title',
    initialValue: 'Notification',
  );
  final date = context.knobs.createdAt;
  final hasPrimaryAction = context.knobs.boolean(
    label: 'Has Primary Action',
    initialValue: true,
  );
  final hasSecondaryAction = context.knobs.boolean(
    label: 'Has Secondary Action',
    initialValue: true,
  );
  final statusBadgeType = context.knobs.object.dropdown<StatusBadgeType>(
    label: 'Actor Status',
    options: StatusBadgeType.values,
    initialOption: StatusBadgeType.online,
    labelBuilder: (value) => value.name,
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 600,
        child: AppNotification2(
          title: title ?? 'Notification',
          date: date,
          isUnread: isUnread,
          badgeText: badgeText,
          actorAvatarUrl: context.knobs.userImageNullable,
          actorName: context.knobs.stringOrNull(
            label: 'Actor Name',
            initialValue: 'John',
          ),
          statusBadgeType: statusBadgeType,
          message: context.knobs.stringOrNull(
            label: 'Message',
            initialValue: 'Great job on that task',
          ),
          quote: context.knobs.stringOrNull(label: 'Quote'),
          color: context.knobs.semanticColor,
          badgeColor: context.knobs.semanticColor,
          primaryActionText: hasPrimaryAction ? "Show all notifications" : null,
          primaryAction: hasPrimaryAction ? () {} : null,
          primaryActionIcon: null,
          secondaryActionText: hasSecondaryAction ? "Mark all as read" : null,
          secondaryAction: hasSecondaryAction ? () {} : null,
          secondaryActionIcon:
              hasSecondaryAction ? BetterIcons.tickDouble02Outline : null,
        ),
      ),
    ],
  );
}
