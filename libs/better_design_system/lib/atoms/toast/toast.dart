import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/colors/color_system.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'toast_size.dart';
export 'toast_style.dart';

/// A customizable toast notification widget that can display a message with an optional icon.
///
/// The [AppToast] widget can be styled with different colors, sizes, and visual styles.
/// It supports an optional subtitle, custom actions, and an icon, and can also be closed via the [onClosed] callback.
typedef BetterToast = AppToast;

class AppToast extends StatelessWidget {
  /// The size of the toast.
  /// Defaults to [ToastSize.large].
  final ToastSize size;

  /// The visual style of the toast.
  /// Defaults to [ToastStyle.soft].
  final ToastStyle toastStyle;

  /// The main title text of the toast.
  final String title;

  /// Optional subtitle text to be displayed below the title.
  final String? subtitle;

  final double? maxHeight;

  /// The type of toast, which determines the icon and color scheme.
  /// Defaults to [SemanticColor.info].
  final SemanticColor color;

  /// A list of actions that can be taken with the toast (e.g., buttons).
  final List<ToastAction> actions;

  /// A callback that is invoked when the toast is closed.
  final void Function()? onClosed;

  /// Creates an [AppToast].
  ///
  /// The [title] and [icon] are required, while all other parameters are optional.
  const AppToast({
    super.key,
    this.size = ToastSize.large,
    this.toastStyle = ToastStyle.soft,
    required this.title,
    this.subtitle,
    this.onClosed,
    this.color = SemanticColor.info,
    this.actions = const [],
    this.maxHeight,
  }) : assert(
         actions.length <= 2,
         'The actions list can contain at most 2 items.',
       );

  @override
  Widget build(BuildContext context) {
    final reversedTheme = BetterTheme.reversedTheme(
      context.colors.betterTheme,
      context.isDark,
    );
    return Container(
      height: maxHeight,
      padding: size.padding,
      decoration: BoxDecoration(
        border: toastStyle == ToastStyle.outline
            ? Border.all(width: 1, color: context.colors.outline)
            : null,
        borderRadius: size.borderRadius,
        color: _getBackgroundColor(reversedTheme, context),
        boxShadow: toastStyle == ToastStyle.outline
            ? [kShadow16(context)]
            : null,
      ),
      child: Row(
        crossAxisAlignment: size == ToastSize.large
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.start,
        children: <Widget>[
          // Icon container with background color
          if (_icon != null) ...[
            Container(
              padding: size.iconPadding,
              decoration: BoxDecoration(
                borderRadius: size.iconBorderRadius,
                color: _getIconBackgroundColor(reversedTheme, context),
              ),
              child: Icon(
                _icon,
                size: size.iconSize,
                color: _getIconForegroundColor(context),
              ),
            ),
            const SizedBox(width: 8),
          ],
          // Toast message content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: _getIconTextColor(reversedTheme, context),
                  ),
                ),
                // Subtitle displayed when available and size is large
                if (subtitle != null && size == ToastSize.large) ...[
                  const SizedBox(height: 6),
                  Text(
                    subtitle!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: toastStyle == ToastStyle.outline
                          ? context.colors.onSurfaceVariant
                          : _getIconTextColor(reversedTheme, context),
                    ),
                  ),
                ],
                // Actions displayed when available and size is large
                if (actions.isNotEmpty && size == ToastSize.large) ...[
                  const SizedBox(height: 8),
                  Row(
                    spacing: 16,
                    children: actions
                        .map(
                          (e) => AppLinkButton(
                            onPressed: e.onPressed,
                            text: e.title,
                            color: _actionButtonSemanticColor(context),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
          // Action button when subtitle is not large
          if (actions.isNotEmpty && size != ToastSize.large) ...[
            ...actions
                .map(
                  (e) => AppLinkButton(
                    onPressed: e.onPressed,
                    text: e.title,
                    color: _actionButtonSemanticColor(context),
                  ),
                )
                .toList()
                .separated(separator: const SizedBox(width: 8)),
            const SizedBox(width: 8),
          ],
          // Close button
          if (onClosed != null)
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onClosed,
              minimumSize: const Size(0, 0),
              child: Icon(
                BetterIcons.cancel01Outline,
                color: toastStyle == ToastStyle.outline
                    ? context.colors.onSurfaceVariant
                    : _getIconTextColor(reversedTheme, context),
                size: 16,
              ),
            ),
        ],
      ),
    );
  }

  SemanticColor _actionButtonSemanticColor(BuildContext context) {
    return switch (toastStyle) {
      ToastStyle.soft => color,
      ToastStyle.outline => SemanticColor.neutral,
      ToastStyle.fill =>
        // because in dark mode the neutral color becomes white
        context.isDark ? SemanticColor.neutral : SemanticColor.white,
    };
  }

  // Returns the background color of the toast based on the style
  Color _getBackgroundColor(ThemeData theme, BuildContext context) =>
      switch (toastStyle) {
        ToastStyle.soft => color.variantLow(context),
        ToastStyle.outline => theme.extension<ColorSystem>()!.onSurface,
        ToastStyle.fill => color.main(context),
      };

  // Returns the background color of the icon container based on the style
  Color _getIconBackgroundColor(ThemeData theme, BuildContext context) =>
      switch (toastStyle) {
        ToastStyle.soft ||
        ToastStyle.fill => theme.extension<ColorSystem>()!.onSurface,
        ToastStyle.outline => color.containerColor(context),
      };

  // Returns the foreground color of the icon based on the style
  Color _getIconForegroundColor(BuildContext context) => color.main(context);

  // Returns the color of the text inside the toast based on the style
  Color _getIconTextColor(ThemeData theme, BuildContext context) {
    switch (toastStyle) {
      case ToastStyle.soft:
        return color.main(context);
      case ToastStyle.outline:
        return theme.extension<ColorSystem>()!.surface;
      case ToastStyle.fill:
        return color.onColor(context);
    }
  }

  // Icon mapping for the toast
  IconData? get _icon => switch (color) {
    SemanticColor.info => BetterIcons.informationCircleFilled,
    SemanticColor.success => BetterIcons.checkmarkCircle02Filled,
    SemanticColor.warning => BetterIcons.alert02Filled,
    SemanticColor.error => BetterIcons.alertCircleFilled,
    SemanticColor.neutral => BetterIcons.checkmarkCircle02Filled,
    SemanticColor.white => BetterIcons.checkmarkCircle02Filled,
    SemanticColor.primary => BetterIcons.flashFilled,
    SemanticColor.secondary => BetterIcons.flashFilled,
    SemanticColor.tertiary => BetterIcons.flashFilled,
    SemanticColor.insight => BetterIcons.flashFilled,
  };
}

/// Represents an action button within the toast.
class ToastAction {
  /// The title of the action button.
  final String title;

  /// The callback function to be invoked when the action is pressed.
  final void Function() onPressed;

  /// Creates a [ToastAction] with a title and an action callback.
  const ToastAction({required this.title, required this.onPressed});
}
