import 'package:better_design_system/atoms/input_fields/base_components/input_label.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

part 'toggle_switch_button_group_option.dart';

/// Size variants for the toggle switch button group
enum ToggleSwitchButtonGroupSize {
  small,
  medium,
  large;

  /// Icon size for this size variant
  double get iconSize => switch (this) {
    ToggleSwitchButtonGroupSize.small => 16,
    ToggleSwitchButtonGroupSize.medium => 18,
    ToggleSwitchButtonGroupSize.large => 20,
  };

  /// Container padding for this size variant
  double get containerPadding => switch (this) {
    ToggleSwitchButtonGroupSize.small => 2,
    ToggleSwitchButtonGroupSize.medium => 3,
    ToggleSwitchButtonGroupSize.large => 4,
  };

  /// Spacing between icon and label for this size variant
  double get iconLabelSpacing => switch (this) {
    ToggleSwitchButtonGroupSize.small => 4,
    ToggleSwitchButtonGroupSize.medium => 6,
    ToggleSwitchButtonGroupSize.large => 8,
  };

  /// Padding for icon-only buttons
  EdgeInsets get iconOnlyPadding => switch (this) {
    ToggleSwitchButtonGroupSize.small => const EdgeInsets.all(4),
    ToggleSwitchButtonGroupSize.medium => const EdgeInsets.all(5),
    ToggleSwitchButtonGroupSize.large => const EdgeInsets.all(6),
  };

  /// Padding for buttons with labels
  EdgeInsets get labelPadding => switch (this) {
    ToggleSwitchButtonGroupSize.small => const EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 6,
    ),
    ToggleSwitchButtonGroupSize.medium => const EdgeInsets.symmetric(
      vertical: 3,
      horizontal: 8,
    ),
    ToggleSwitchButtonGroupSize.large => const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 10,
    ),
  };
}

/// A toggle switch button group widget that allows selecting one option from multiple choices.
/// Supports rounded corners, expanded mode (buttons fill available width), and custom icons/labels.
typedef BetterToggleSwitchButtonGroup = AppToggleSwitchButtonGroup;

class AppToggleSwitchButtonGroup<T> extends StatefulWidget {
  /// List of toggle options with label, icon, and value
  final List<ToggleSwitchButtonGroupOption> options;

  /// Whether the toggle buttons should have rounded corners
  final bool isRounded;

  /// Callback when an option is selected
  final Function(T value)? onChanged;

  /// Currently selected value
  final T? selectedValue;

  /// Optional title above the toggle group
  final String? title;

  /// Optional subtitle below the title
  final String? subtitle;

  /// If true, buttons expand to fill the width equally
  final bool isExpanded;

  /// Size variant for the toggle button group
  final ToggleSwitchButtonGroupSize size;

  const AppToggleSwitchButtonGroup({
    super.key,
    this.isRounded = false,
    required this.options,
    required this.onChanged,
    this.selectedValue,
    this.title,
    this.subtitle,
    this.isExpanded = false,
    this.size = ToggleSwitchButtonGroupSize.large,
  });

  @override
  State<AppToggleSwitchButtonGroup<T>> createState() =>
      _AppToggleSwitchButtonGroupState<T>();
}

class _AppToggleSwitchButtonGroupState<T>
    extends State<AppToggleSwitchButtonGroup<T>> {
  /// Currently hovered button index for hover effects
  int hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show title and subtitle if provided
        if (widget.title != null)
          AppInputLabel(label: widget.title!, sublabel: widget.subtitle),
        LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final itemCount = widget.options.length;

            double buttonSize = 0;
            double leftPosition = 0;

            // Calculate the size and position of the selected toggle highlight
            if (widget.selectedValue != null && itemCount > 0) {
              int selectedIndex = widget.options.indexWhere(
                (element) => element.value == widget.selectedValue,
              );
              if (selectedIndex >= 0) {
                if (widget.isExpanded) {
                  // In expanded mode, buttons share equal width with small gaps
                  buttonSize =
                      (totalWidth - (itemCount - 1) * 2) / itemCount - 4;
                  leftPosition =
                      selectedIndex * (buttonSize + (itemCount == 2 ? 2 : 4));
                } else {
                  // In normal mode, calculate width based on label + icon size
                  buttonSize = _calculateButtonWidth(
                    widget.options[selectedIndex],
                    selectedIndex,
                  );
                  leftPosition = _calculateLeftPosition(selectedIndex);
                }
              }
            }

            return Container(
              padding: EdgeInsets.all(widget.size.containerPadding),
              decoration: BoxDecoration(
                borderRadius: widget.isRounded
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(4),
                color: context.colors.surfaceVariant,
              ),
              child: Stack(
                children: [
                  // Animated highlight behind selected toggle button
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    left: leftPosition,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: buttonSize,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            color: context.colors.shadow,
                            blurRadius: 4,
                          ),
                        ],
                        color: context.colors.surface,
                        borderRadius: widget.isRounded
                            ? BorderRadius.circular(100)
                            : BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  // Row of toggle buttons
                  Row(
                    mainAxisSize: widget.isExpanded
                        ? MainAxisSize.max
                        : MainAxisSize.min,
                    children: List.generate(widget.options.length, (index) {
                      // Each button is Expanded if in expanded mode
                      return widget.isExpanded
                          ? Expanded(child: _getToggleButton(context, index))
                          : _getToggleButton(context, index);
                    }).separated(separator: const SizedBox(width: 2)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  /// Builds individual toggle button with icon and label, handling hover and selected states
  Widget _getToggleButton(BuildContext context, int index) {
    ToggleSwitchButtonGroupOption toggleItem = widget.options[index];
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => widget.onChanged?.call(toggleItem.value as T),
        minimumSize: Size.zero,
        child: Padding(
          padding: _getPadding(index),
          child: Row(
            mainAxisAlignment: widget.isExpanded
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (toggleItem.icon != null)
                Icon(
                  _isSelected(index)
                      ? toggleItem.selectedIcon ?? toggleItem.icon
                      : toggleItem.icon,
                  size: widget.size.iconSize,
                  color: _getForegroundColor(context, index),
                ),
              if (toggleItem.label != null && toggleItem.icon != null)
                SizedBox(width: widget.size.iconLabelSpacing),

              if (toggleItem.label != null)
                Text(
                  toggleItem.label!,
                  style: _getTextStyle(
                    context,
                  )?.copyWith(color: _getForegroundColor(context, index)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Calculate left position of toggle highlight by summing widths of previous buttons + spacing
  double _calculateLeftPosition(int index) {
    double position = 0;
    for (int i = 0; i < index; i++) {
      position += _calculateButtonWidth(widget.options[i], i);
      position += 2; // spacing between buttons
    }
    return position;
  }

  /// Calculate the width of a button based on text label and icon widths plus padding and spacing
  double _calculateButtonWidth(
    ToggleSwitchButtonGroupOption option,
    int index,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(text: option.label ?? "", style: _getTextStyle(context)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    double textWidth = textPainter.width;
    double iconWidth = option.icon != null ? widget.size.iconSize : 0;
    double padding = _getPadding(index).horizontal;
    double spacing = (option.icon != null && option.label != null)
        ? widget.size.iconLabelSpacing
        : 0;

    return textWidth + iconWidth + padding + spacing;
  }

  /// Returns foreground color depending on selected and hovered states
  Color _getForegroundColor(BuildContext context, int index) {
    if (_isSelected(index) && hoveredIndex != index) {
      return context.colors.onSurface;
    } else if (!_isSelected(index) && hoveredIndex != index) {
      return context.colors.onSurfaceVariantLow;
    } else {
      // hovered state
      return context.colors.onSurfaceVariant;
    }
  }

  /// Returns padding for toggle button: smaller padding if only icon, bigger if label present
  EdgeInsetsGeometry _getPadding(int index) {
    ToggleSwitchButtonGroupOption toggleItem = widget.options[index];
    return toggleItem.icon != null && toggleItem.label == null
        ? widget.size.iconOnlyPadding
        : widget.size.labelPadding;
  }

  /// Returns text style based on size variant
  TextStyle? _getTextStyle(BuildContext context) => switch (widget.size) {
    ToggleSwitchButtonGroupSize.small => context.textTheme.bodySmall,
    ToggleSwitchButtonGroupSize.medium => context.textTheme.bodySmall,
    ToggleSwitchButtonGroupSize.large => context.textTheme.bodyMedium,
  };

  /// Checks if the button at index is currently selected
  bool _isSelected(int index) {
    return widget.options[index].value == widget.selectedValue;
  }
}
