import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

typedef BetterTimePickerSpinner = AppTimePickerSpinner;

class AppTimePickerSpinner extends StatefulWidget {
  final void Function(DateTime time) onTimeChange;
  final DateTime? initialValue;
  const AppTimePickerSpinner({
    super.key,
    required this.onTimeChange,
    this.initialValue,
  });

  @override
  State<AppTimePickerSpinner> createState() => _AppTimePickerSpinnerState();
}

class _AppTimePickerSpinnerState extends State<AppTimePickerSpinner> {
  FixedExtentScrollController _hourController = FixedExtentScrollController(
    initialItem: 1200,
  );
  FixedExtentScrollController _minuteController = FixedExtentScrollController(
    initialItem: 600,
  );

  @override
  void initState() {
    super.initState();

    final initialHour = widget.initialValue?.hour ?? 0;
    final initialMinute = widget.initialValue?.minute ?? 0;

    _selectedPeriod = initialHour >= 12 ? 'PM' : 'AM';

    _hourController = FixedExtentScrollController(
      initialItem: widget.initialValue != null ? initialHour % 12 : 1200,
    );
    _minuteController = FixedExtentScrollController(
      initialItem: widget.initialValue != null ? initialMinute : 600,
    );
  }

  @override
  void didUpdateWidget(covariant AppTimePickerSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != null) {
      final newHour = widget.initialValue!.hour;
      final newMinute = widget.initialValue!.minute;

      _selectedPeriod = newHour >= 12 ? 'PM' : 'AM';

      _hourController.jumpToItem(newHour % 12);
      _minuteController.jumpToItem(newMinute);
    }
  }

  DateTime get _selectedTime {
    int hour = _hourController.selectedItem % 12;
    if (_selectedPeriod == 'PM' && hour != 0) {
      hour += 12;
    }
    final minute = _minuteController.selectedItem % 60;
    return DateTime(0, 1, 1, hour, minute);
  }

  String _selectedPeriod = 'AM';

  void _onChanged(_) {
    setState(() {});
    widget.onTimeChange(_selectedTime);
  }

  void _increment(FixedExtentScrollController controller) {
    controller.animateToItem(
      controller.selectedItem + 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _decrement(FixedExtentScrollController controller) {
    controller.animateToItem(
      controller.selectedItem - 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildSpinner({
    required FixedExtentScrollController controller,
    required int max,
    bool hasColon = false,
  }) {
    return Column(
      crossAxisAlignment: hasColon
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      spacing: 13,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppLinkButton(
          color: SemanticColor.neutral,
          onPressed: () => _decrement(controller),
          prefixIcon: BetterIcons.arrowUp01Outline,
          size: ButtonSize.medium,
        ),
        SizedBox(
          height: 80,
          width: 40,
          child: ListWheelScrollView.useDelegate(
            clipBehavior: Clip.none,
            controller: controller,
            itemExtent: 30,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: _onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 100000,
              builder: (context, index) {
                final value = index % max;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 14,
                  children: [
                    Center(
                      child: Text(
                        value.toString().padLeft(2, '0'),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: controller.selectedItem == index
                              ? context.colors.onSurface
                              : context.colors.onSurfaceDisabled,
                        ),
                      ),
                    ),
                    if (hasColon)
                      Center(
                        child: Text(
                          ':',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: controller.selectedItem == index
                                ? context.colors.onSurfaceVariantLow
                                : context.colors.onSurfaceDisabled,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
        AppLinkButton(
          color: SemanticColor.neutral,
          onPressed: () => _increment(controller),
          prefixIcon: BetterIcons.arrowDown01Outline,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSpinner(controller: _hourController, max: 12, hasColon: true),
        _buildSpinner(controller: _minuteController, max: 60),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            spacing: 11,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    _selectedPeriod = 'AM';
                    widget.onTimeChange(_selectedTime);
                  });
                },
                minimumSize: const Size(0, 0),
                child: Text(
                  'AM',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: _selectedPeriod == 'AM'
                        ? context.colors.onSurface
                        : context.colors.onSurfaceDisabled,
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    _selectedPeriod = 'PM';
                    widget.onTimeChange(_selectedTime);
                  });
                },
                minimumSize: const Size(0, 0),
                child: Text(
                  'PM',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: _selectedPeriod == 'PM'
                        ? context.colors.onSurface
                        : context.colors.onSurfaceDisabled,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
