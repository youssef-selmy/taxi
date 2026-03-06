import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

enum DialogHeaderIconStyle { simple, withBorder, withBackground, expanded }

enum DialogHeaderAlignment { start, center }

typedef BetterDialogHeader = AppDialogHeader;

class AppDialogHeader extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final SemanticColor? iconColor;
  final DialogHeaderIconStyle iconStyle;
  final DialogHeaderAlignment alignment;
  final List<Widget> actions;
  final Function()? onClosePressed;

  const AppDialogHeader({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.iconStyle = DialogHeaderIconStyle.simple,
    this.alignment = DialogHeaderAlignment.start,
    this.actions = const [],
    this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    if (title == null) return const SizedBox();
    return switch (alignment) {
      DialogHeaderAlignment.start => startAlignment(context),
      DialogHeaderAlignment.center => centerAlignment(context),
    };
  }

  Widget startAlignment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 14, bottom: 14, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[_icon(context), const SizedBox(width: 16)],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                if (title != null) _title(context),
                if (subtitle != null) _subtitle(context),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ...actions.separated(separator: const SizedBox(width: 8)),
          if (onClosePressed != null) ...[
            const SizedBox(width: 8),
            AppIconButton(
              style: IconButtonStyle.ghost,
              icon: BetterIcons.cancelCircleOutline,
              onPressed: onClosePressed,
            ),
          ],
        ],
      ),
    );
  }

  Widget centerAlignment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      // padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  _icon(context),
                  const SizedBox(height: 8),
                ],
                if (title != null) _title(context),
                if (subtitle != null) ...[
                  SizedBox(height: context.isMobile ? 22 : 4),
                  _subtitle(context),
                ],
              ],
            ),
          ),
          if (onClosePressed != null) ...[
            Align(
              alignment: Alignment.topRight,
              child: AppIconButton(
                style: IconButtonStyle.ghost,
                icon: BetterIcons.cancelCircleOutline,
                onPressed: onClosePressed,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Text _title(BuildContext context) =>
      Text(title!, style: context.textTheme.labelLarge);

  Text _subtitle(BuildContext context) {
    return Text(
      subtitle!,
      style: context.textTheme.bodyMedium?.variant(context),
    );
  }

  Widget _icon(BuildContext context, {double size = 24}) {
    if (icon == null) return const SizedBox.shrink();
    if (iconStyle == DialogHeaderIconStyle.expanded) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (iconColor ?? SemanticColor.neutral).containerColor(context),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: _iconColor(context), size: 48),
      );
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconStyle == DialogHeaderIconStyle.withBackground
            ? (iconColor ?? SemanticColor.neutral).containerColor(context)
            : null,
        borderRadius: BorderRadius.circular(8),
        border: iconStyle != DialogHeaderIconStyle.withBorder
            ? null
            : Border.all(color: context.colors.outline, width: 1),
      ),
      child: Icon(icon, color: _iconColor(context), size: size),
    );
  }

  Color _iconColor(BuildContext context) {
    return iconColor?.main(context) ?? context.colors.onSurface;
  }

  // largeAlignment(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             if (icon != null) ...[
  //               Container(
  //                 padding: EdgeInsets.all(16),
  //                 decoration: BoxDecoration(
  //                   color: (iconColor ?? SemanticColor.neutral).containerColor(
  //                     context,
  //                   ),
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: Icon(icon, color: _iconColor(context), size: 48),
  //               ),
  //               const SizedBox(height: 16),
  //             ],
  //             if (title != null)
  //               Text(title!, style: context.textTheme.titleMedium),
  //             if (subtitle != null) ...[
  //               const SizedBox(height: 22),
  //               _subtitle(context),
  //             ],
  //           ],
  //         ),
  //         Align(
  //           alignment: Alignment.topRight,
  //           child: AppIconButton(
  //             hasBorder: false,
  //             icon: BetterIcons.cancelCircleOutline,
  //             onPressed: onClosePressed,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
