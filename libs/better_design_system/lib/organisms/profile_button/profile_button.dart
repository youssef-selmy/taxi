import 'package:flutter/material.dart';

import 'package:better_icons/better_icon.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/molecules/popup_menu_overlay/popup_menu_overlay.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

export 'package:better_design_system/atoms/status_badge/status_badge_type.dart';
export 'package:better_design_system/colors/semantic_color.dart';

export 'package:better_design_system/molecules/popup_menu_overlay/popup_menu_overlay.dart';

typedef BetterProfileButton = AppProfileButton;

class AppProfileButton extends StatefulWidget {
  const AppProfileButton({
    super.key,
    required this.avatarUrl,
    this.title,
    this.subtitle,
    this.statusBadge = StatusBadgeType.online,
    this.items = const [],
  });

  final String? avatarUrl;
  final String? title;
  final String? subtitle;
  final StatusBadgeType statusBadge;
  final List<AppPopupMenuItem> items;

  @override
  State<AppProfileButton> createState() => _AppProfileButtonState();
}

class _AppProfileButtonState extends State<AppProfileButton> {
  final controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.toggle();
            setState(() {
              _isActive = controller.isShowing;
            });
          },
          child: CompositedTransformFollower(
            offset: const Offset(0, 8),
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            link: _link,
            child: widget.items.isEmpty
                ? null
                : Align(
                    alignment: Alignment.topCenter,
                    child: AppPopupMenuOverlay(
                      items: widget.items,
                      onItemSelected: () {
                        controller.hide();
                        setState(() {
                          _isActive = controller.isShowing;
                        });
                      },
                    ),
                  ),
          ),
        );
      },
      child: CompositedTransformTarget(
        link: _link,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onHover: (value) => setState(() => _isHovered = value),
          onHighlightChanged: (value) => setState(() => _isPressed = value),
          onTap: () {
            controller.toggle();
            setState(() {
              _isActive = controller.isShowing;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _getBackgroundColor(context),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppAvatar(
                  imageUrl: widget.avatarUrl,
                  size: AvatarSize.size32px,
                  shape: AvatarShape.circle,
                  statusBadgeType: widget.statusBadge,
                ),

                if (widget.title != null) ...[
                  const SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title!,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.colors.onSurface,
                        ),
                      ),
                      if (widget.subtitle != null)
                        Text(
                          widget.subtitle!,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    turns: _isActive ? 0.5 : 0,
                    child: Icon(
                      BetterIcons.arrowDown01Outline,
                      size: 20,
                      color: _getForegroundColor(context),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (_isActive || _isPressed) {
      return context.colors.surfaceVariant;
    } else if (!_isActive && _isHovered) {
      return context.colors.surfaceVariantLow;
    } else {
      return null;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    if (_isActive) {
      return context.colors.onSurface;
    } else {
      return context.colors.onSurfaceVariant;
    }
  }
}
