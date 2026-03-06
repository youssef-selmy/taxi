import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterSheet = AppSheet;

class AppSheet extends StatefulWidget {
  final Widget child;
  final Widget? expandedChild;
  final Widget? footer;
  final bool showHandle;
  final bool hasDecoration;
  final bool initiallyExpanded;
  final Function(bool isExpanded)? onExpandedChanged;
  final EdgeInsetsGeometry? padding;

  const AppSheet({
    super.key,
    this.showHandle = false,
    required this.child,
    this.expandedChild,
    this.footer,
    this.hasDecoration = true,
    this.initiallyExpanded = false,
    this.onExpandedChanged,
    this.padding,
  });

  @override
  State<AppSheet> createState() => _AppSheetState();
}

class _AppSheetState extends State<AppSheet>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _dragExtent = 0;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      value: widget.initiallyExpanded ? 1.0 : 0.0,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    widget.onExpandedChanged?.call(_isExpanded);
  }

  void _handleDragStart(DragStartDetails details) {
    _dragExtent = 0;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent += details.primaryDelta ?? 0;
      // Calculate progress based on drag
      // Negative delta means dragging up (expanding), positive means dragging down (collapsing)
      double targetValue;

      if (_isExpanded) {
        // When expanded, dragging down should collapse
        // Positive _dragExtent = dragging down = should decrease from 1.0
        targetValue = (1.0 - (_dragExtent / 200)).clamp(0.0, 1.0);
      } else {
        // When collapsed, dragging up should expand
        // Negative _dragExtent = dragging up = should increase from 0.0
        targetValue = (-_dragExtent / 200).clamp(0.0, 1.0);
      }

      _animationController.value = targetValue;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    // Determine final state based on velocity and current position
    bool shouldExpand;

    if (velocity.abs() > 500) {
      // Fast swipe - use velocity direction
      shouldExpand = velocity < 0; // Negative velocity = upward swipe = expand
    } else {
      // Slow drag - use 50% threshold
      shouldExpand = _animationController.value > 0.5;
    }

    setState(() {
      _isExpanded = shouldExpand;
    });

    if (shouldExpand) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    widget.onExpandedChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      decoration: widget.hasDecoration
          ? BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              border: Border.all(
                color: context.colors.outline,
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colors.shadow,
                  offset: const Offset(2, 4),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            )
          : BoxDecoration(color: context.colors.surface),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.showHandle)
            GestureDetector(
              onTap: widget.expandedChild != null ? _toggleExpanded : null,
              onVerticalDragStart: widget.expandedChild != null
                  ? _handleDragStart
                  : null,
              onVerticalDragUpdate: widget.expandedChild != null
                  ? _handleDragUpdate
                  : null,
              onVerticalDragEnd: widget.expandedChild != null
                  ? _handleDragEnd
                  : null,
              child: Container(
                color: context.colors.transparent,
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: Center(
                  child: Container(
                    width: 60,
                    height: 3,
                    decoration: ShapeDecoration(
                      color: context.colors.outlineVariant,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (!widget.showHandle) const SizedBox(height: 16),
          widget.child,
          SizeTransition(
            sizeFactor: _animation,
            axisAlignment: -1,
            child: widget.expandedChild ?? const SizedBox.shrink(),
          ),
          if (widget.footer != null) ...[
            Container(
              decoration: !widget.hasDecoration
                  ? null
                  : BoxDecoration(
                      color: context.colors.surface,
                      border: Border(
                        top: BorderSide(
                          color: context.colors.outline,
                          width: 1,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.shadow,
                          offset: const Offset(2, 4),
                          blurRadius: 20,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
              child: widget.footer,
            ),
          ],
        ],
      ),
    );
  }
}
