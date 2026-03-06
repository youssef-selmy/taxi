import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';

// A customizable toggle switch button widget with support for labels, icons, and hover states.
// The [AppToggleSwitchButton] can be styled with different visual appearances based on selection and hover states.
// It supports optional icons, labels, and can be disabled or rounded.
typedef BetterToggleSwitchButton = AppToggleSwitchButton;

class AppToggleSwitchButton extends StatefulWidget {
  /// The current state of the toggle button.
  final bool value;

  /// Whether the toggle button is disabled.
  final bool isDisabled;

  /// Callback to notify the parent widget when the toggle value changes.
  final ValueChanged<bool>? onChanged;

  /// The label text displayed on the button.
  final String? label;

  /// The icon to be displayed on the button.
  final IconData? icon;

  /// Whether the button should have rounded corners.
  final bool isRounded;

  const AppToggleSwitchButton({
    super.key,
    this.value = false,
    this.onChanged,
    this.isDisabled = false,
    this.label,
    this.icon,
    this.isRounded = false,
  });

  @override
  State<AppToggleSwitchButton> createState() => _AppToggleSwitchButtonState();
}

class _AppToggleSwitchButtonState extends State<AppToggleSwitchButton> {
  late bool isSelected;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.value;
  }

  /// Toggles the button's selected state and calls the onChanged callback if provided.
  void _toggle() {
    setState(() {
      isSelected = !isSelected;
    });

    widget.onChanged?.call(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // Handles hover state changes to adjust appearance
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            // Only allows interaction if the button is not disabled
            onPressed: widget.isDisabled ? () {} : _toggle,
            minimumSize: const Size(0, 0),
            child: _getToggleButton(context),
          ),
        ],
      ),
    );
  }

  /// Returns the toggle button widget with animation and dynamic styling based on selection and hover states.
  Widget _getToggleButton(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: widget.isRounded
            ? BorderRadius.circular(100)
            : BorderRadius.circular(4),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: context.colors.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
        color: _getBackgroundColor(context),
      ),
      child: Padding(
        padding: _getPadding,
        child: Row(
          children: [
            // Displays the icon if available
            if (widget.icon != null)
              Icon(
                BetterIcons.moon02Outline,
                size: 20,
                color: _getForegroundColor(context),
              ),
            if (widget.icon != null && widget.label != null)
              const SizedBox(width: 8),

            // Displays the label if available
            if (widget.label != null)
              Text(
                'Label',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: _getForegroundColor(context),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Returns the foreground color based on the selection, hover, and disabled states.
  Color _getForegroundColor(BuildContext context) {
    if (widget.isDisabled && !isHovered) {
      return context.colors.onSurfaceDisabled;
    } else if (isSelected && !isHovered) {
      return context.colors.onSurface;
    } else if (!isSelected && !isHovered) {
      return context.colors.onSurfaceVariantLow;
    } else if (isHovered) {
      return context.colors.onSurfaceVariant;
    } else {
      return context.colors.onSurfaceVariantLow;
    }
  }

  /// Returns the background color of the toggle button based on the selected state.
  Color _getBackgroundColor(BuildContext context) {
    if (isSelected) {
      return context.colors.surface;
    } else {
      return context.colors.surfaceVariant;
    }
  }

  /// Returns the padding based on the presence of an icon and label.
  EdgeInsetsGeometry get _getPadding {
    if (widget.icon != null && widget.label == null) {
      return const EdgeInsets.all(4);
    } else {
      return const EdgeInsets.symmetric(vertical: 4, horizontal: 10);
    }
  }
}
