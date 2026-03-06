import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/tag/tag_size.dart';
import 'package:better_design_system/atoms/tag/tag_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';

// Export related files for easy access when importing this widget
export 'tag_size.dart';
export 'tag_style.dart';
export 'package:better_design_system/colors/semantic_color.dart';

/// A customizable Tag widget that can display text with optional icons or images.
///
/// The [AppTag] can be styled with different colors, sizes, and visual styles.
/// It supports prefix/suffix icons and can be rounded or disabled.
typedef BetterTag = AppTag;

class AppTag extends StatelessWidget {
  /// The text to be displayed inside the Tag.
  final String text;

  /// Optional asset path for an image to be displayed before the text.
  final String? prefixImage;

  /// Optional icon to be displayed before the text.
  final IconData? prefixIcon;

  /// The semantic color of the Tag.
  /// Defaults to [SemanticColor.primary].
  final SemanticColor color;

  /// The visual style of the Tag (fill, outline, or soft).
  /// Defaults to [TagStyle.soft].
  final TagStyle style;

  /// The size of the Tag (medium or large).
  /// Defaults to [TagSize.medium].
  final TagSize size;

  /// Determines whether the Tag should have rounded corners.
  /// Defaults to false.
  final bool isRounded;

  /// Determines whether the Tag should appear in a disabled state.
  /// Defaults to false.
  final bool isDisabled;

  final Widget? prefixWidget;
  final Widget? suffixWidget;

  /// Callback function for when the remove button is pressed.
  final void Function()? onRemovedPressed;

  /// Creates an [AppTag] widget.
  ///
  /// The [text] parameter is required, while all others are optional.
  /// Ensures that both [prefixImage] and [prefixIcon] are not set simultaneously.
  const AppTag({
    super.key,
    required this.text,
    this.prefixImage,
    this.prefixIcon,
    this.color = SemanticColor.primary,
    this.style = TagStyle.soft,
    this.size = TagSize.small,
    this.isRounded = false,
    this.isDisabled = false,
    this.onRemovedPressed,
    this.suffixWidget,
    this.prefixWidget,
  }) : assert(
         (prefixImage != null ? 1 : 0) + (prefixIcon != null ? 1 : 0) <= 1,
         'prefixImage and prefixIcon cannot be set at the same time.',
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _decoration(context),
      padding: size.padding,
      child: Row(
        spacing: 6,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixWidget != null) prefixWidget!,
          if (prefixImage != null) _image,
          if (prefixIcon != null) _icon(context, prefixIcon!),
          Padding(
            padding: EdgeInsets.only(
              left: (prefixIcon != null || prefixImage != null) ? 0 : 2,
            ),
            child: Text(text, style: _textStyle(context)),
          ),
          if (suffixWidget != null) suffixWidget!,
          if (onRemovedPressed != null) ...[_closeIcon(context)],
        ],
      ),
    );
  }

  /// Returns the decoration for the Tag container, including background color and border.
  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
    color: _backgroundColor(context),
    borderRadius: _borderRadius,
    border: style == TagStyle.outline
        ? Border.all(
            color: isDisabled
                ? context.colors.outlineDisabled.withValues(alpha: 0.16)
                : context.colors.outline,
            width: 1,
          )
        : null,
  );

  /// Determines the background color of the Tag based on style and state.
  Color _backgroundColor(BuildContext context) {
    switch (style) {
      case TagStyle.fill:
        return isDisabled
            ? context.colors.onSurfaceDisabled
            : color.main(context);
      case TagStyle.outline:
        return context.colors.surface;
      case TagStyle.soft:
        return isDisabled
            ? context.colors.surfaceMuted.withValues(alpha: 0.08)
            : color.containerColor(context);
    }
  }

  /// Determines the text color based on Tag style and state.
  Color _textColor(BuildContext context) => switch (style) {
    TagStyle.fill =>
      isDisabled ? context.colors.surface : color.onColor(context),
    TagStyle.outline =>
      isDisabled
          ? context.colors.onSurfaceDisabled
          : switch (color) {
              SemanticColor.neutral => context.colors.onSurfaceVariant,
              _ => color.main(context),
            },
    TagStyle.soft =>
      isDisabled
          ? context.colors.onSurfaceDisabled
          : switch (color) {
              SemanticColor.neutral => context.colors.onSurfaceVariant,
              _ => color.bold(context),
            },
  };

  /// Determines the text style based on Tag size.
  TextStyle? _textStyle(BuildContext context) {
    switch (size) {
      case TagSize.small:
        return context.textTheme.labelMedium?.copyWith(
          color: _textColor(context),
        );
      case TagSize.medium:
        return context.textTheme.labelLarge?.copyWith(
          color: _textColor(context),
        );
    }
  }

  /// Returns the widget for displaying an image as a prefix.
  Widget get _image => AppAvatar(
    imageUrl: prefixImage!,
    shape: isRounded ? AvatarShape.circle : AvatarShape.rounded,
    size: size.avatarSize,
  );

  /// Returns the prefix icon button.
  Widget _closeIcon(BuildContext context) {
    final Color prefixIconColor = switch (style) {
      TagStyle.soft => _textColor(context),
      TagStyle.outline =>
        isDisabled
            ? context.colors.onSurfaceDisabled
            : context.colors.onSurfaceVariantLow,
      TagStyle.fill => color.onColor(context),
    };

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onRemovedPressed,
      minimumSize: const Size(0, 0),
      child: Icon(
        BetterIcons.cancel01Outline,
        size: _iconSize,
        color: prefixIconColor,
      ),
    );
  }

  /// Returns the icon widget with appropriate size and color.
  Widget _icon(BuildContext context, IconData icon) =>
      Icon(icon, size: _iconSize, color: _iconColor(context));

  /// Determines the icon size based on Tag size.
  double get _iconSize => size == TagSize.small ? 14 : 18;

  /// Determines the icon color (same as text color).
  Color _iconColor(BuildContext context) {
    return _textColor(context);
  }

  /// Determines the border radius of the Tag.
  BorderRadius get _borderRadius => isRounded
      ? BorderRadius.circular(100)
      : BorderRadius.circular(size == TagSize.medium ? 4 : 6);

  /// Determines the spacing between prefix icon and Tag content.
  double get prefixIconSpacing =>
      prefixIcon != null ? 2 : (size == TagSize.medium ? 4 : 6);
}
