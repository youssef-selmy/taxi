import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef BetterNavbarLogo = AppNavbarLogo;

class AppNavbarLogo extends StatefulWidget {
  const AppNavbarLogo({
    super.key,
    this.title,
    this.subtitle,
    this.onPressed,
    required this.logoUrl,
  }) : assert(
         (title == null && subtitle == null) ||
             (title != null && subtitle != null),
         'Title and subtitle must both be null or both be non-null.',
       );

  final String? title;
  final String? subtitle;
  final void Function()? onPressed;
  final String logoUrl;

  @override
  State<AppNavbarLogo> createState() => _AppNavbarLogoState();
}

class _AppNavbarLogoState extends State<AppNavbarLogo> {
  bool _isHovered = false;

  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) => setState(() => _isHovered = value),
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      onTap: () {
        widget.onPressed?.call();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                  width: 40,
                  height: 40,
                  child: CachedNetworkImage(imageUrl: widget.logoUrl),
                ),
                if (widget.title != null) ...[
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title!,
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.colors.onSurface,
                        ),
                      ),
                      Text(
                        widget.subtitle!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
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
