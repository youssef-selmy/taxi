import 'package:flutter/cupertino.dart';

import '../popup_menu_overlay/popup_menu_overlay.dart';

export 'popup_menu_item.dart';

typedef BetterPopupMenuButton = AppPopupMenuButton;

class AppPopupMenuButton extends StatefulWidget {
  final List<AppPopupMenuItem> items;
  final double dropdownWidth;
  final Function(Function() onPressed) childBuilder;
  final bool showArrow;

  const AppPopupMenuButton({
    super.key,
    required this.items,
    this.dropdownWidth = 160,
    required this.childBuilder,
    this.showArrow = true,
  });

  @override
  createState() => _AppDropdownMenuState();
}

class _AppDropdownMenuState extends State<AppPopupMenuButton> {
  final controller = OverlayPortalController();
  final LayerLink _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => controller.hide(),
        child: CompositedTransformFollower(
          offset: const Offset(0, 12),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          link: _link,
          child: Align(
            alignment: Alignment.topCenter,
            child: AppPopupMenuOverlay(
              width: widget.dropdownWidth,
              items: widget.items,
              showArrow: widget.showArrow,
              onItemSelected: () {
                controller.hide();
              },
            ),
          ),
        ),
      ),
      child: CompositedTransformTarget(
        link: _link,
        child: GestureDetector(
          onTap: () => controller.toggle(),
          child: widget.childBuilder(() {
            controller.toggle();
          }),
        ),
      ),
    );
  }
}
