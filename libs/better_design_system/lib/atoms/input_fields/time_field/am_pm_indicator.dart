import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AmPmIndicator extends StatefulWidget {
  final DayPeriod? defaultValue;
  final ValueChanged<DayPeriod> onSelected;

  const AmPmIndicator({
    super.key,
    required this.defaultValue,
    required this.onSelected,
  });

  @override
  State<AmPmIndicator> createState() => _AmPmIndicatorState();
}

class _AmPmIndicatorState extends State<AmPmIndicator> {
  late DayPeriod dayPeriod;

  @override
  void initState() {
    dayPeriod = widget.defaultValue ?? DayPeriod.am;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelected(isAm ? DayPeriod.pm : DayPeriod.am);
        setState(() {
          dayPeriod = isAm ? DayPeriod.pm : DayPeriod.am;
        });
      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: context.colors.surfaceVariant,
        ),
        padding: const EdgeInsets.all(4),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: isAm ? Alignment.centerLeft : Alignment.centerRight,
                curve: Curves.easeInOutCubic,
                child: Container(
                  width: 42,
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'AM',
                    style: context.textTheme.bodyMedium?.apply(
                      color: isAm
                          ? context.colors.onSurface
                          : context.colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'PM',
                    style: context.textTheme.bodyMedium?.apply(
                      color: !isAm
                          ? context.colors.onSurface
                          : context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isAm => dayPeriod == DayPeriod.am;
}
