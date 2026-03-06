import 'package:better_design_system/organisms/notification/notification.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppNotification)
Widget defaultNotification(BuildContext context) {
  final style = context.knobs.object.dropdown(
    label: 'Style',
    options: NotificationStyle.values,
    initialOption: NotificationStyle.compact,
    labelBuilder: (value) => value.name,
  );
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
  final prefixMode = context.knobs.object.dropdown(
    label: "Prefix Mode",
    options: ['icon', 'image'],
    initialOption: 'icon',
    labelBuilder: (value) => value.toString(),
  );
  final hasPrimaryAction = context.knobs.boolean(
    label: 'Has Primary Action',
    initialValue: false,
  );
  final hasSecondaryAction = context.knobs.boolean(
    label: 'Has Secondary Action',
    initialValue: false,
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 300,
        child: AppNotification(
          style: style,
          title: title ?? 'Notification',
          date: date,
          isUnread: isUnread,
          badgeText: badgeText,
          imageUrl:
              prefixMode == 'image' ? context.knobs.userImageNullable : null,
          icon: prefixMode == 'icon' ? BetterIcons.gps01Outline : null,
          actorAvatarUrl: context.knobs.userImageNullable,
          actorName: context.knobs.stringOrNull(label: 'Actor Name'),
          message: context.knobs.stringOrNull(label: 'Message'),
          quote: context.knobs.stringOrNull(label: 'Quote'),
          color: context.knobs.semanticColor,
          primaryActionText: hasPrimaryAction ? "Primary Action" : null,
          primaryAction: hasPrimaryAction ? () {} : null,
          secondaryActionText: hasSecondaryAction ? "Secondary Action" : null,
          secondaryAction: hasSecondaryAction ? () {} : null,
        ),
      ),
    ],
  );
}
