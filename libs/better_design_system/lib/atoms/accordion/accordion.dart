import 'package:better_design_system/atoms/accordion/accordion_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
export 'accordion_style.dart';

typedef BetterAccordion = AppAccordion;

class AppAccordion extends StatefulWidget {
  const AppAccordion({
    super.key,
    this.initiallyExpanded = false,
    required this.title,
    required this.subtitle,
    this.icon,
    this.style = AccordionStyle.outline,
  });

  final bool initiallyExpanded;
  final String title;
  final String subtitle;
  final IconData? icon;
  final AccordionStyle style;

  @override
  State<AppAccordion> createState() => _AppAccordionState();
}

class _AppAccordionState extends State<AppAccordion>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (_isExpanded) _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      onTap: () => setState(() {
        _isExpanded = !_isExpanded;
        if (_isExpanded) _controller.forward();
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: BorderRadius.circular(8.0),
          border: _hasBorder
              ? Border.all(width: 1, color: _getBorderColor(context))
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: 16,
                        color: context.colors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.title,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                  ],
                ),

                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  turns: _isExpanded ? 0.5 : 0,
                  child: Icon(
                    BetterIcons.arrowDown01Outline,
                    color: context.colors.onSurfaceVariant,
                    size: 16,
                  ),
                ),
              ],
            ),
            if (_isExpanded)
              SizeTransition(
                sizeFactor: _heightAnimation,
                child: AnimatedOpacity(
                  opacity: _isExpanded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left: widget.icon == null ? 0 : 24,
                      right: widget.icon == null ? 16 : 24,
                    ),
                    child: Text(
                      widget.subtitle,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (widget.style) {
      case AccordionStyle.outline:
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else {
          return context.colors.surface;
        }
      case AccordionStyle.soft:
        if (_isExpanded) {
          return context.colors.surfaceVariant;
        } else {
          return context.colors.surfaceVariantLow;
        }
      case AccordionStyle.ghost:
        if (_isExpanded) {
          return context.colors.surfaceVariant;
        } else if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else {
          return null;
        }
    }
  }

  bool get _hasBorder {
    switch (widget.style) {
      case AccordionStyle.outline:
        return true;
      case AccordionStyle.soft:
        if (_isHovered && !_isExpanded) {
          return true;
        } else {
          return false;
        }
      case AccordionStyle.ghost:
        return false;
    }
  }

  Color _getBorderColor(BuildContext context) {
    switch (widget.style) {
      case AccordionStyle.outline:
        if (_isExpanded) {
          return context.colors.outlineVariant;
        } else {
          return context.colors.outline;
        }
      case AccordionStyle.ghost:
      case AccordionStyle.soft:
        return context.colors.outline;
    }
  }
}
