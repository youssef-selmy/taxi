import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/badge/badge_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'badge_size.dart';

// Export related files for easy access when importing this widget
export 'badge_style.dart';
export 'badge_size.dart';
export 'package:better_design_system/colors/semantic_color.dart';

/// A customizable badge widget that can display text with optional icons.
///
/// The [AppBadge] can be styled with different colors, sizes, and visual styles.
/// It supports prefix/suffix icons and can be rounded or disabled.
typedef BetterBadge = AppBadge;

class AppBadge extends StatelessWidget {
  /// The text to be displayed in the badge.
  final String text;

  /// Optional asset path for an image to be displayed before the text.
  final String? prefixImage;

  /// Optional icon to be displayed before the text.
  final IconData? prefixIcon;

  /// Optional icon to be displayed after the text.
  final IconData? suffixIcon;

  /// The semantic color of the badge.
  /// Defaults to [SemanticColor.primary].
  final SemanticColor color;

  /// The visual style of the badge.
  /// Defaults to [BadgeStyle.soft].
  final BadgeStyle style;

  /// The size of the badge.
  /// Defaults to [BadgeSize.medium].
  final BadgeSize size;

  /// Whether the badge should have rounded corners.
  /// Defaults to false.
  final bool isRounded;

  /// Whether the badge should appear disabled.
  /// Defaults to false.
  final bool isDisabled;

  /// Specifies whether a small dot indicator should be displayed inside the badge.
  final bool hasDot;

  /// Creates an [AppBadge].
  ///
  /// The [text] parameter is required, all others are optional.
  const AppBadge({
    super.key,
    required this.text,
    this.prefixImage,
    this.prefixIcon,
    this.suffixIcon,
    this.color = SemanticColor.neutral,
    this.style = BadgeStyle.soft,
    this.size = BadgeSize.medium,
    this.isRounded = false,
    this.isDisabled = false,
    this.hasDot = false,
  }) : assert(
         (hasDot ? 1 : 0) +
                 (prefixImage != null ? 1 : 0) +
                 (prefixIcon != null ? 1 : 0) <=
             1,
         'Only one of hasDot, prefixImage, or prefixIcon can be set at a time.',
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _decoration(context),
      padding: size.padding(isRounded),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: prefixIconSpacing),
          if (prefixImage != null) _image,
          if (prefixIcon != null) _icon(context, prefixIcon!),
          if (hasDot) _doteBadge(context),
          if (prefixImage != null || prefixIcon != null || hasDot)
            const SizedBox(width: 4),
          Text(text, style: _textStyle(context)),
          if (suffixIcon != null) const SizedBox(width: 4),
          if (suffixIcon != null) _icon(context, suffixIcon!),
          SizedBox(width: suffixIconSpacing),
        ],
      ),
    );
  }

  /// Returns the decoration for the badge container
  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
    color: _backgroundColor(context),
    borderRadius: _borderRadius,
    border: style == BadgeStyle.outline
        ? Border.all(
            color: isDisabled
                ? context.colors.outlineDisabled.withValues(alpha: 0.16)
                : (color == SemanticColor.neutral
                      ? context.colors.outline
                      : color.main(context)),
            width: 1,
          )
        : null,
  );

  /// Returns the background color of the badge based on style and disabled state
  Color _backgroundColor(BuildContext context) {
    switch (style) {
      case BadgeStyle.fill:
        return isDisabled
            ? context.colors.onSurfaceDisabled
            : color.main(context);
      case BadgeStyle.outline:
        return isDisabled
            ? context.colors.outlineDisabled.withValues(alpha: 0.16)
            : context.colors.surface;
      case BadgeStyle.soft:
        return isDisabled
            ? context.colors.surfaceMuted.withValues(alpha: 0.08)
            : color.containerColor(context);
    }
  }

  /// Returns the text color of the badge based on style and disabled state
  Color _textColor(BuildContext context) => switch (style) {
    BadgeStyle.fill =>
      isDisabled ? context.colors.surface : color.onColor(context),
    BadgeStyle.outline =>
      isDisabled
          ? context.colors.onSurfaceDisabled
          : switch (color) {
              SemanticColor.neutral => context.colors.onSurfaceVariant,
              _ => color.main(context),
            },
    BadgeStyle.soft =>
      isDisabled
          ? context.colors.onSurfaceDisabled
          : switch (color) {
              SemanticColor.neutral => context.colors.onSurfaceVariant,
              _ => color.bold(context),
            },
  };

  // /// Returns the text style for the badge text
  TextStyle? _textStyle(BuildContext context) => switch (size) {
    BadgeSize.small => context.textTheme.labelSmall?.copyWith(
      color: _textColor(context),
    ),
    BadgeSize.medium => context.textTheme.labelSmall?.copyWith(
      color: _textColor(context),
    ),
    BadgeSize.large => context.textTheme.labelMedium?.copyWith(
      color: _textColor(context),
    ),
  };

  /// Returns the image widget for the prefix image
  Widget get _image {
    // Create avatar widget first and use it here.
    return AppAvatar(
      imageUrl: prefixImage!,
      shape: AvatarShape.circle,
      size: size.avatarSize,
    );
  }

  // Create dotBadge widget for the prefix.
  Widget _doteBadge(BuildContext context) {
    final colorValue = _textColor(context);
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(shape: BoxShape.circle, color: colorValue),
      ),
    );
  }

  /// Returns an icon widget with appropriate size and color
  Widget _icon(BuildContext context, IconData icon) {
    return Icon(icon, size: _iconSize, color: _iconColor(context));
  }

  /// Returns the icon size based on the badge size
  double get _iconSize {
    switch (size) {
      case BadgeSize.small:
        return 12;
      case BadgeSize.medium:
        return 12;
      case BadgeSize.large:
        return 16;
    }
  }

  /// Returns the icon color (same as text color)
  Color _iconColor(BuildContext context) => _textColor(context);

  /// Returns the border radius based on whether the badge is rounded or not
  BorderRadius get _borderRadius {
    if (isRounded) {
      return BorderRadius.circular(100);
    } else {
      return BorderRadius.circular(4);
    }
  }

  /// Returns the spacing value between the suffix icon and the badge content.
  double get suffixIconSpacing {
    switch (size) {
      case BadgeSize.small:
        if (!isRounded) {
          if (hasDot && suffixIcon == null) {
            return 4;
          } else {
            return 0;
          }
        } else {
          if ((prefixImage != null || hasDot) && suffixIcon == null) {
            return 4;
          }
          if (prefixIcon != null || suffixIcon != null) {
            return 2;
          } else {
            return 0;
          }
        }

      case BadgeSize.medium:
        if (!isRounded) {
          if (hasDot && suffixIcon == null) {
            return 4;
          } else if (suffixIcon != null) {
            return 2;
          } else if ((prefixImage != null || prefixIcon != null) &&
              suffixIcon == null) {
            return 2;
          } else {
            return 0;
          }
        } else {
          if ((prefixImage != null || hasDot) && suffixIcon == null) {
            return 4;
          }

          if (prefixIcon != null || suffixIcon != null) {
            return 2;
          } else {
            return 0;
          }
        }
      case BadgeSize.large:
        if (suffixIcon != null) {
          return 4;
        }
        if ((hasDot || prefixImage != null || prefixIcon != null) &&
            suffixIcon == null) {
          return 4;
        } else {
          return 0;
        }
    }
  }

  /// Returns the spacing value between the prefix icon and the badge content.
  double get prefixIconSpacing {
    switch (size) {
      case BadgeSize.small:
        if (!isRounded) {
          return 0;
        } else {
          if (prefixIcon != null) {
            return 2;
          } else {
            return 0;
          }
        }

      case BadgeSize.medium:
        if (prefixIcon != null) {
          return 2;
        } else {
          return 0;
        }

      case BadgeSize.large:
        if (prefixIcon != null) {
          return 0;
        } else {
          return 0;
        }
    }
  }
}
