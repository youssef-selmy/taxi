import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/sidebar_navigation/enum/sidebar_navigation_user_profile_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
export 'enum/sidebar_navigation_user_profile_style.dart';

typedef BetterSidebarNavigationUserProfile = AppSidebarNavigationUserProfile;

class AppSidebarNavigationUserProfile extends StatefulWidget {
  const AppSidebarNavigationUserProfile({
    super.key,
    required this.avatarUrl,
    this.title,
    this.subtitle,
    this.onPressed,
    this.statusBadge = StatusBadgeType.online,
    this.style = SidebarNavigationUserProfileStyle.outline,
    this.icon,
  });

  final String avatarUrl;
  final String? title;
  final String? subtitle;
  final void Function()? onPressed;
  final StatusBadgeType statusBadge;
  final IconData? icon;

  final SidebarNavigationUserProfileStyle style;

  @override
  State<AppSidebarNavigationUserProfile> createState() =>
      _AppSidebarNavigationUserProfileState();
}

class _AppSidebarNavigationUserProfileState
    extends State<AppSidebarNavigationUserProfile> {
  bool _isHovered = false;
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onHover: (value) => setState(() => _isHovered = value),
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      onTap: () {
        widget.onPressed?.call();
      },
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getBackgroundColor(context),
          border: widget.style == SidebarNavigationUserProfileStyle.outline
              ? Border.all(
                  width: 1,
                  color: _isPressed
                      ? context.colors.outlineVariant
                      : context.colors.outline,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppAvatar(
              imageUrl: widget.avatarUrl,
              size: AvatarSize.size40px,
              shape: AvatarShape.circle,
              statusBadgeType: widget.statusBadge,
            ),
            if (widget.title != null || widget.subtitle != null)
              const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colors.onSurface,
                    ),
                  ),
                if (widget.subtitle != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    widget.subtitle!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),

            if (widget.title != null || widget.subtitle != null) ...[
              const SizedBox(width: 8),
              const Spacer(),
              Icon(
                widget.icon ?? BetterIcons.arrowDown01Outline,
                size: 24,
                color: context.colors.onSurface,
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
    }
    if (_isHovered) {
      return context.colors.surfaceVariantLow;
    } else {
      return null;
    }
  }
}
