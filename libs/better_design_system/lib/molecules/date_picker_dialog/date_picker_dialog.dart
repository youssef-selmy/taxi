import 'package:better_design_system/molecules/date_picker/date_picker.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterDatePickerDialog = AppDatePickerDialog;

class AppDatePickerDialog extends StatefulWidget {
  final String? title;
  final DateTime? activeDate;
  final ValueChanged<DateTime?> onChanged;
  final ValueChanged<(DateTime, DateTime)>? onChangedRange;
  final List<(DateTime, DateTime)>? disabledDates;
  final List<DateTime>? events;
  final bool pickTime;
  final (DateTime, DateTime)? rangeDate;
  final bool isRangeMode;
  const AppDatePickerDialog({
    super.key,
    this.title,
    this.activeDate,
    required this.onChanged,
    this.onChangedRange,
    this.disabledDates,
    this.events,
    this.pickTime = false,
    this.rangeDate,
    this.isRangeMode = false,
  }) : assert(
         !isRangeMode || onChangedRange != null,
         'onChangedRange must not be null when isRangeMode is true',
       );

  @override
  State<AppDatePickerDialog> createState() => _AppDatePickerDialogState();
}

class _AppDatePickerDialogState extends State<AppDatePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      maxWidth: context.isDesktop ? 400 : null,
      defaultDialogType: DialogType.bottomSheet,
      desktopDialogType: DialogType.dialog,
      contentPadding: EdgeInsets.zero,
      child: AppDatePicker(
        onChanged: (date) {
          if (!widget.isRangeMode) {
            Navigator.pop(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onChanged(date);
            });
          }
        },
        onRangeChanged: (start, end) {
          // Auto-dismiss when a complete range is selected (start != end)
          if (widget.isRangeMode && !start.isAtSameMomentAs(end)) {
            Navigator.pop(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onChangedRange!((start, end));
            });
          }
        },
        title: widget.title,
        activeDate: widget.activeDate,
        selectionMode: widget.isRangeMode
            ? DatePickerSelectionMode.range
            : DatePickerSelectionMode.day,
        disabledDates: widget.disabledDates,
        events: widget.events,
        pickTime: widget.pickTime,
        rangeDate: widget.rangeDate,
      ),
    );
  }
}
