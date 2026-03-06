import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef BetterSidebarNavigationLogo = AppSidebarNavigationLogo;

class AppSidebarNavigationLogo extends StatefulWidget {
  const AppSidebarNavigationLogo({
    super.key,
    this.title,
    this.subtitle,
    this.onPressed,
    required this.logoUrl,
    this.isCollapsed = false,
  });

  final String? title;
  final String? subtitle;
  final void Function()? onPressed;
  final String logoUrl;
  final bool isCollapsed;

  @override
  State<AppSidebarNavigationLogo> createState() =>
      _AppSidebarNavigationLogoState();
}

class _AppSidebarNavigationLogoState extends State<AppSidebarNavigationLogo> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) => setState(() => _isHovered = value),
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      onTap: () => widget.onPressed?.call(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 32,
              height: 32,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: widget.logoUrl,
                  width: 32,
                  height: 32,
                  errorWidget: (context, url, error) => Icon(
                    BetterIcons.alert02Filled,
                    size: 24,
                    color: context.colors.onSurfaceVariantLow,
                  ),
                ),
              ),
            ),
            if (!widget.isCollapsed) ...[
              if (widget.title != null) ...[
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title!,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                    if (widget.subtitle != null)
                      Text(
                        widget.subtitle!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                  ],
                ),
              ],
              // Spacer(),
            ],

            if (widget.subtitle != null) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: Border.all(color: context.colors.outline),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  BetterIcons.arrowDown01Outline,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (_isPressed) {
      return context.colors.surfaceVariant;
    } else if (!_isPressed && _isHovered) {
      return context.colors.surfaceVariantLow;
    } else {
      return null;
    }
  }
}
