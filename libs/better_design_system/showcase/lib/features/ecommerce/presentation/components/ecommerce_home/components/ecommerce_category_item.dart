import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

class EcommerceCategoryItem extends StatefulWidget {
  final String label;
  final SvgPicture svgPicture;
  final bool isMobile;

  const EcommerceCategoryItem({
    super.key,
    required this.label,
    required this.svgPicture,
    this.isMobile = false,
  });

  @override
  State<EcommerceCategoryItem> createState() => _EcommerceCategoryItemState();
}

class _EcommerceCategoryItemState extends State<EcommerceCategoryItem> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 0 : 28.89),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FocusableActionDetector(
            mouseCursor: SystemMouseCursors.click,
            onShowHoverHighlight: (isHovered) {
              setState(() => _isHovered = isHovered);
            },
            onShowFocusHighlight: (isFocused) {
              setState(() => _isFocused = isFocused);
            },
            onFocusChange: (isFocused) {
              setState(() => _isFocused = isFocused);
            },
            child: GestureDetector(
              onTapDown: (_) {
                setState(() => _isPressed = true);
              },
              onTapUp: (_) {
                setState(() => _isPressed = false);
              },
              onTapCancel: () {
                setState(() => _isPressed = false);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _getBackgroundColor(context),
                  border: _getBorder(context),
                  boxShadow: _getBoxShadow(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [widget.svgPicture],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style:
                (_isHovered || _isPressed || _isFocused)
                    ? context.textTheme.labelMedium!
                    : context.textTheme.bodySmall!,
            child: Text(widget.label),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (_isPressed) {
      return context.colors.surfaceVariant;
    }
    if (_isHovered || _isFocused) {
      return context.colors.surface;
    }
    return context.colors.surfaceVariant;
  }

  Border? _getBorder(BuildContext context) {
    if (_isHovered || _isPressed || _isFocused) {
      return Border.all(color: context.colors.outline);
    }
    return null;
  }

  List<BoxShadow> _getBoxShadow(BuildContext context) {
    if (_isPressed) {
      return [];
    }
    if (_isHovered || _isFocused) {
      return [BetterShadow.shadow16.toBoxShadow(context)];
    }
    return [];
  }
}
