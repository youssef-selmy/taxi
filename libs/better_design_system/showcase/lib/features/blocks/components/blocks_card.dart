import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BlocksCard extends StatefulWidget {
  final AssetGenImage image;
  final String componentName;
  final int blockCount;
  final PageRouteInfo route;

  const BlocksCard({
    super.key,
    required this.image,
    required this.componentName,
    required this.blockCount,
    required this.route,
  });

  @override
  State<BlocksCard> createState() => _BlocksCardState();
}

class _BlocksCardState extends State<BlocksCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (details) => setState(() => _isPressed = true),
        onTapUp: (details) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () {
          context.pushRoute(widget.route);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: context.isDesktop ? 240 : null,
          height: context.isDesktop ? 272 : null,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                _isHovered
                    ? context.colors.surface
                    : context.colors.transparent,
            boxShadow:
                _isHovered && !_isPressed
                    ? [BetterShadow.shadow24.toBoxShadow(context)]
                    : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child:
                    context.isDesktop
                        ? widget.image.image(
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        )
                        : AspectRatio(
                          aspectRatio: 16 / 9,
                          child: widget.image.image(
                            fit: BoxFit.cover,
                            height: 267,
                            width: double.infinity,
                          ),
                        ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.componentName,
                      style: context.textTheme.labelLarge,
                    ),
                    Text(
                      '${widget.blockCount} Blocks',
                      style: context.textTheme.bodySmall?.variant(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
