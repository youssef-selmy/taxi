import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
export 'package:better_design_system/atoms/status_badge/status_badge_type.dart';

/// The visual style of a notification.
enum NotificationStyle {
  /// A minimal notification without a card background.
  compact,

  /// A notification displayed within a card with border and shadow.
  withCard,
}

/// A notification component that displays user activity, system alerts, or messages.
///
/// [AppNotification] supports multiple visual configurations including:
/// - Compact or card-based layouts via [style]
/// - Actor information with avatar and status badge
/// - Action buttons for user interaction
/// - Unread indicators
/// - Quoted content blocks
///
/// Example:
/// ```dart
/// AppNotification(
///   title: 'New Message',
///   date: DateTime.now(),
///   actorName: 'John Doe',
///   actorAvatarUrl: 'https://example.com/avatar.jpg',
///   message: 'Hey, are you available for a quick call?',
///   isUnread: true,
///   primaryActionText: 'Reply',
///   primaryAction: () => print('Reply tapped'),
/// )
/// ```
typedef BetterNotification = AppNotification;

class AppNotification extends StatelessWidget {
  /// The title text displayed at the top of the notification.
  final String? title;

  /// The date/time when the notification was created.
  /// Displayed in both formatted and relative time formats.
  final DateTime date;

  /// The main message content of the notification.
  final String? message;

  /// Optional quoted text displayed in a highlighted container.
  final String? quote;

  /// URL for a main image displayed on the left side.
  /// Mutually exclusive with [icon] - only one should be provided.
  final String? imageUrl;

  /// URL for the actor's avatar image.
  final String? actorAvatarUrl;

  /// Status badge type shown on the actor's avatar.
  final StatusBadgeType? statusBadgeType;

  /// The name of the actor/user associated with this notification.
  final String? actorName;

  /// Icon displayed on the left side instead of an image.
  /// Mutually exclusive with [imageUrl] - only one should be provided.
  final IconData? icon;

  /// The semantic color applied to the [icon].
  /// Defaults to [SemanticColor.primary].
  final SemanticColor color;

  /// Text displayed in a badge next to the title.
  final String? badgeText;

  /// The semantic color applied to the badge.
  /// Defaults to [SemanticColor.warning].
  final SemanticColor badgeColor;

  /// The visual style of the notification.
  /// Defaults to [NotificationStyle.compact].
  final NotificationStyle style;

  /// Text for the primary action button.
  final String? primaryActionText;

  /// Text for the secondary action button.
  final String? secondaryActionText;

  /// Callback invoked when the primary action button is pressed.
  final Function()? primaryAction;

  /// Callback invoked when the secondary action button is pressed.
  final Function()? secondaryAction;

  /// Whether the notification is unread.
  /// When true, displays an unread indicator dot.
  final bool isUnread;

  /// Callback invoked when the notification is tapped.
  final Function()? onTap;

  /// Creates an [AppNotification].
  ///
  /// The [date] parameter is required. All other parameters are optional
  /// and allow customizing the notification's appearance and behavior.
  const AppNotification({
    super.key,
    this.title,
    required this.date,
    this.actorAvatarUrl,
    this.statusBadgeType,
    this.actorName,
    this.message,
    this.quote,
    this.imageUrl,
    this.icon,
    this.color = SemanticColor.primary,
    this.badgeText,
    this.badgeColor = SemanticColor.warning,
    this.style = NotificationStyle.compact,
    this.primaryActionText,
    this.secondaryActionText,
    this.primaryAction,
    this.secondaryAction,
    this.isUnread = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: style == NotificationStyle.withCard
            ? const EdgeInsets.all(12)
            : null,
        decoration: style == NotificationStyle.withCard
            ? BoxDecoration(
                color: context.colors.surface,
                border: Border.all(color: context.colors.outline),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.shadow,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              )
            : null,
        child: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              AppAvatar(imageUrl: imageUrl, size: AvatarSize.size40px),
            if (icon != null)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.outline),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: color.main(context)),
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      if (title != null) ...[
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            title!,
                            style: context.textTheme.labelLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (badgeText != null) ...[
                        const SizedBox(width: 8),
                        AppBadge(
                          text: badgeText!,
                          color: badgeColor,
                          size: BadgeSize.small,
                        ),
                      ],
                    ],
                  ),
                  if (actorAvatarUrl != null ||
                      actorName != null ||
                      message != null) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (actorAvatarUrl != null)
                          AppAvatar(
                            imageUrl: actorAvatarUrl,
                            size: AvatarSize.size40px,
                            statusBadgeType:
                                statusBadgeType ?? StatusBadgeType.none,
                          ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8,
                            children: [
                              if (actorName != null)
                                Text(
                                  actorName!,
                                  style: context.textTheme.labelMedium,
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    date.format('EEEE, h:mm a'),
                                    style: context.textTheme.labelSmall
                                        ?.variant(context),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      final rel = timeago.format(date);
                                      return Text(
                                        rel,
                                        style: context.textTheme.labelSmall
                                            ?.variant(context),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              if (message != null)
                                Text(
                                  message!,
                                  style: context.textTheme.bodySmall,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (quote != null) ...[
                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(quote!, style: context.textTheme.bodySmall),
                    ),
                  ],
                  Row(
                    spacing: 8,
                    children: [
                      if (primaryActionText != null)
                        AppFilledButton(
                          size: ButtonSize.medium,
                          onPressed: primaryAction,
                          text: primaryActionText!,
                        ),
                      if (secondaryActionText != null)
                        AppTextButton(
                          color: SemanticColor.neutral,
                          size: ButtonSize.medium,
                          onPressed: secondaryAction,
                          text: secondaryActionText!,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                if (isUnread)
                  const BetterDotBadge(dotBadgeSize: DotBadgeSize.small),
                // relative time moved next to the full date under actorName
              ],
            ),
          ],
        ),
      ),
    );
  }
}
