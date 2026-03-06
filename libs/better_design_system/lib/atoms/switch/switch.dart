import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum AppSwitchSize { small, medium, large }

typedef BetterSwitch = AppSwitch;

class AppSwitch extends StatefulWidget {
  final bool isSelected;
  final void Function(bool)? onChanged;
  final bool isDisabled;
  final AppSwitchSize size;
  final SemanticColor color;
  final SemanticColor? offColor;

  const AppSwitch({
    super.key,
    required this.isSelected,
    required this.onChanged,
    this.size = AppSwitchSize.medium,
    this.isDisabled = false,
    this.color = SemanticColor.primary,
    this.offColor,
  });

  @override
  createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  late bool _isSelected;

  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSwitch oldWidget) {
    if (oldWidget.isSelected != widget.isSelected) {
      setState(() {
        _isSelected = widget.isSelected;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isDisabled
          ? null
          : () {
              widget.onChanged?.call(!widget.isSelected);
              setState(() {
                _isSelected = !_isSelected;
              });
            },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: _isSelected
              ? widget.color.main(context)
              : widget.offColor?.main(context) ??
                    context.colors.onSurfaceVariantLow,
        ),
        width: (_effectiveSize() * 2) + 4,
        height: _effectiveSize() + 4,
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: _isSelected ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Container(
            margin: const EdgeInsets.all(2),
            width: _effectiveSize(),
            height: _effectiveSize(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.surface,
            ),
          ),
        ),
      ),
    );
  }

  double _effectiveSize() => switch (widget.size) {
    AppSwitchSize.small => 12,
    AppSwitchSize.medium => 16,
    AppSwitchSize.large => 20,
  };
}
