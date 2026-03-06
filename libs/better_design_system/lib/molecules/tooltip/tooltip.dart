import 'package:better_design_system/molecules/tooltip/tooltip_alignment.dart';
import 'package:better_design_system/molecules/tooltip/tooltip_size.dart';
import 'package:better_design_system/molecules/tooltip/tooltip_trigger.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
export 'tooltip_size.dart';
export 'tooltip_alignment.dart';
export 'tooltip_trigger.dart';
part 'tooltip_triangle_painter.dart';

typedef BetterTooltip = AppTooltip;

class AppTooltip extends StatefulWidget {
  const AppTooltip({
    super.key,
    required this.title,
    required this.child,
    this.size = TooltipSize.small,
    this.icon,
    this.subtitle,
    this.primaryButton,
    this.secondaryButton,
    this.width = 280,
    this.alignment = TooltipAlignment.bottom,
    this.trigger = TooltipTrigger.click,
    this.showCloseButton = false,
  }) : assert(
         trigger != TooltipTrigger.hover ||
             (primaryButton == null && secondaryButton == null),
         'When trigger is hover, only title must be provided, and all other fields should be null '
         'because actions in the tooltip cannot be used while hovering.',
       );

  final String title;
  final Widget child;
  final String? subtitle;
  final IconData? icon;
  final TooltipSize size;
  final double width;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final TooltipAlignment alignment;
  final TooltipTrigger trigger;
  final bool showCloseButton;

  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends State<AppTooltip> {
  final controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  @override
  Widget build(BuildContext context) {
    if (widget.trigger == TooltipTrigger.always) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          controller.show();
        }
      });
    }

    return widget.trigger == TooltipTrigger.hover
        ? MouseRegion(
            onEnter: (_) => controller.show(),
            onExit: (_) => controller.hide(),
            child: _getTooltip(context),
          )
        : _getTooltip(context);
  }

  Widget _getTooltip(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.trigger == TooltipTrigger.click
              ? () {
                  if (widget.trigger != TooltipTrigger.always) {
                    controller.hide();
                  }
                }
              : null,
          onTapDown: widget.trigger == TooltipTrigger.drag
              ? (details) {
                  controller.show();
                }
              : null,
          onTapUp: widget.trigger == TooltipTrigger.drag
              ? (details) {
                  controller.hide();
                }
              : null,
          child: CompositedTransformFollower(
            link: _link,
            targetAnchor: widget.alignment.getTargetAnchor(),
            followerAnchor: widget.alignment.getFollowerAnchor(),
            offset: widget.alignment.getTooltipOffset(),
            child: Animate(
              effects: [
                const FadeEffect(
                  duration: Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                ),
              ],
              child: Stack(
                alignment: _getAlignment,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width:
                        widget.size == TooltipSize.large &&
                            widget.trigger != TooltipTrigger.hover
                        ? widget.width
                        : null,
                    padding: widget.size.padding,
                    decoration: BoxDecoration(
                      borderRadius: widget.size.borderRadius,
                      color: context.colors.surface,
                      border: Border.all(
                        width: 1,
                        color: context.colors.outline,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.shadow.withValues(alpha: 0.16),
                          offset: const Offset(0, 8),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: widget.subtitle != null
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          mainAxisSize: widget.size == TooltipSize.large
                              ? widget.trigger == TooltipTrigger.click ||
                                        widget.trigger == TooltipTrigger.always
                                    ? MainAxisSize.max
                                    : MainAxisSize.min
                              : MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                if (_getIcon(context) != null) ...[
                                  _getIcon(context)!,
                                  const SizedBox(width: 12),
                                ],
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: widget.size == TooltipSize.large
                                          ? context.textTheme.labelLarge
                                                ?.copyWith(
                                                  color:
                                                      context.colors.onSurface,
                                                )
                                          : context.textTheme.labelMedium
                                                ?.copyWith(
                                                  color:
                                                      context.colors.onSurface,
                                                ),
                                    ),
                                    if (widget.subtitle != null &&
                                        widget.size == TooltipSize.large) ...[
                                      const SizedBox(height: 6),
                                      SizedBox(
                                        width: 254,
                                        child: Text(
                                          widget.subtitle!,
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                                color: context
                                                    .colors
                                                    .onSurfaceVariant,
                                              ),
                                          maxLines: 4,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            if (widget.showCloseButton)
                              if (widget.size == TooltipSize.large &&
                                  widget.trigger != TooltipTrigger.hover) ...[
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    controller.hide();
                                  },
                                  minimumSize: const Size(0, 0),
                                  child: Icon(
                                    BetterIcons.cancel01Outline,
                                    size: 24,
                                    color: context.colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                          ],
                        ),
                        if ((widget.primaryButton != null ||
                                widget.secondaryButton != null) &&
                            widget.size == TooltipSize.large) ...[
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                if (widget.secondaryButton != null)
                                  Expanded(child: widget.secondaryButton!),
                                if (widget.primaryButton != null &&
                                    widget.secondaryButton != null)
                                  const SizedBox(width: 8),
                                if (widget.primaryButton != null)
                                  Expanded(child: widget.primaryButton!),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _getTriangle(context),
                ],
              ),
            ),
          ),
        );
      },
      child: CompositedTransformTarget(
        link: _link,
        child: GestureDetector(
          onTap: widget.trigger == TooltipTrigger.click
              ? () {
                  controller.show();
                }
              : null,
          child: widget.child,
        ),
      ),
    );
  }

  Widget _getTriangle(BuildContext context) {
    Widget triangle = CustomPaint(
      size: const Size(8, 9),
      painter: _TooltipTrianglePainter(
        fillColor: context.colors.surface,
        borderColor: context.colors.outline,
        alignment: _getAlignment,
      ),
    );

    switch (widget.alignment) {
      case TooltipAlignment.bottom:
        return Transform.translate(
          offset: const Offset(0, -8),
          child: triangle,
        );
      case TooltipAlignment.top:
        return Transform.translate(offset: const Offset(0, 8), child: triangle);

      case TooltipAlignment.left:
        return Transform.translate(offset: const Offset(7, 0), child: triangle);
      case TooltipAlignment.right:
        return Transform.translate(
          offset: const Offset(-7, 0),
          child: triangle,
        );
    }
  }

  Alignment get _getAlignment {
    switch (widget.alignment) {
      case TooltipAlignment.top:
        return Alignment.bottomCenter;
      case TooltipAlignment.left:
        return Alignment.centerRight;
      case TooltipAlignment.right:
        return Alignment.centerLeft;
      case TooltipAlignment.bottom:
        return Alignment.topCenter;
    }
  }

  Widget? _getIcon(BuildContext context) {
    if (widget.size == TooltipSize.large && widget.icon != null) {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: context.isDark
              ? context.colors.surfaceVariantLow
              : context.colors.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          widget.icon,
          size: 20,
          color: context.colors.onSurfaceVariant,
        ),
      );
    } else {
      return null;
    }
  }
}
