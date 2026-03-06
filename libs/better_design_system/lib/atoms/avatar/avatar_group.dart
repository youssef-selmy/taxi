import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'avatar_size.dart';
export 'avatar_style.dart';
export '../status_badge/status_badge_type.dart';
export 'avatar_placeholder.dart';

part 'avatar_helper.dart';

/// A widget to display an avatar with an optional status badge and border,
/// supporting individual and grouped avatars with various shapes and sizes.
typedef BetterAvatarGroup = AppAvatarGroup;

class AppAvatarGroup extends StatelessWidget {
  const AppAvatarGroup({
    super.key,
    this.enabledBorder = false,
    required this.avatars,
    this.groupSize = AvatarGroupSize.small,
    this.placeHolder = AvatarPlaceholder.user,
    required this.totalAvatars,
    this.maxAvatars = 3,
    this.isAvatarGroupBackgroundEnabled = true,
  });

  /// Whether or not to enable a border around the avatar.
  final bool enabledBorder;

  /// The list of avatar URLs (can be more than one for avatar grouping).
  final List<String?> avatars;

  /// The size of the avatar group (small, medium, large).
  final AvatarGroupSize groupSize;

  /// Whether or not to enable the background for avatar groups.
  final bool isAvatarGroupBackgroundEnabled;

  final AvatarPlaceholder placeHolder;

  final int totalAvatars;

  final int maxAvatars;

  /// Returns whether the avatars are grouped (i.e., more than one avatar).
  bool get isAvatarGrouped {
    return avatars.length > 1;
  }

  @override
  Widget build(BuildContext context) {
    // If only one avatar, display it with a status badge.
    return avatars.length == 1
        ? AppAvatar(
            imageUrl: avatars.first,
            size: groupSize.avatarSize,
            shape: AvatarShape.circle,
            enabledBorder: enabledBorder,
          )
        // If there are multiple avatars, display them as a group.
        : _getGroupAvatar(context);
  }

  /// Creates the layout for grouped avatars with an optional background.
  Widget _getGroupAvatar(BuildContext context) {
    double currentAvatarSize = switch (groupSize) {
      AvatarGroupSize.small => 24,
      AvatarGroupSize.medium => 32,
      AvatarGroupSize.large => 40,
    };

    double avatarSpacing = currentAvatarSize / 1.3;
    double calculatedWidth =
        currentAvatarSize + (avatarsToDisplay - 1) * avatarSpacing;

    // Function to retrieve the text style based on avatar group size.
    TextStyle? getTextStyle() {
      return switch (groupSize) {
        AvatarGroupSize.small => context.textTheme.labelSmall?.copyWith(
          color: isAvatarGroupBackgroundEnabled
              ? context.colors.onSurfaceVariant
              : context.colors.primary,
        ),
        AvatarGroupSize.medium => context.textTheme.labelMedium?.copyWith(
          color: isAvatarGroupBackgroundEnabled
              ? context.colors.onSurfaceVariant
              : context.colors.primary,
        ),
        AvatarGroupSize.large => context.textTheme.labelLarge?.copyWith(
          color: isAvatarGroupBackgroundEnabled
              ? context.colors.onSurfaceVariant
              : context.colors.primary,
        ),
      };
    }

    // final double extraPadding = switch (groupSize) {
    //   AvatarGroupSize.small => 5,
    //   AvatarGroupSize.medium => 7,
    //   AvatarGroupSize.large => 9,
    // };

    return isAvatarGroupBackgroundEnabled
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            decoration: BoxDecoration(
              color: context.colors.surfaceVariant,
              borderRadius: BorderRadius.circular(100),
            ),
            child: SizedBox(
              height: currentAvatarSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRect(
                    child: SizedBox(
                      width: calculatedWidth,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        clipBehavior: Clip.hardEdge,
                        children: [
                          for (int i = 0; i < avatarsToDisplay; i++)
                            Positioned(
                              right: i * currentAvatarSize / 1.3,
                              child: _getAvatar(context, avatars[i]),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (remainingAvatars > 0) ...[
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                        left: 2,
                        bottom: 2,
                        right: 10,
                      ),
                      child: Text('+$remainingAvatars', style: getTextStyle()),
                    ),
                  ],
                ],
              ),
            ),
          )
        // If background is disabled, show stacked avatars.
        : SizedBox(
            width: calculatedWidth,
            height: currentAvatarSize,
            child: Stack(
              alignment: Alignment.centerRight,
              clipBehavior: Clip.hardEdge,
              children: [
                if (remainingAvatars > 0)
                  Container(
                    width: currentAvatarSize,
                    height: currentAvatarSize,
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: enabledBorder
                          ? Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text('+$remainingAvatars', style: getTextStyle()),
                    ),
                  ),
                for (int i = 0; i < avatarsToDisplay; i++)
                  Positioned(
                    right:
                        (i + (remainingAvatars > 0 ? 1 : 0)) *
                        currentAvatarSize /
                        1.3,
                    child: _getAvatar(context, avatars[i]),
                  ),
              ],
            ),
          );
  }

  int get remainingAvatars {
    return totalAvatars - avatarsToDisplay;
  }

  int get avatarsToDisplay {
    if (avatars.length <= maxAvatars) {
      return avatars.length;
    }
    if (totalAvatars > maxAvatars) {
      return maxAvatars;
    }
    return totalAvatars;
  }

  /// Creates the avatar widget based on the provided URL and size.
  Widget _getAvatar(BuildContext context, String? avatar) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: enabledBorder
            ? Border.all(color: context.colors.surfaceVariant, width: 1.5)
            : null,
      ),
      child: AppAvatar(
        imageUrl: avatar,
        size: groupSize.avatarSize,
        placeholder: placeHolder,
      ),
    );
  }
}
