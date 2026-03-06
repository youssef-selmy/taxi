import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/molecules/date_picker/date_picker.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class TimeSheetDatePickerOverlay extends StatefulWidget {
  const TimeSheetDatePickerOverlay({
    super.key,
    required this.title,
    required this.onConfirmed,
    this.activeWeek,
  });

  final void Function(DateTime start, DateTime end) onConfirmed;
  final (DateTime, DateTime)? activeWeek;
  final String title;
  @override
  State<TimeSheetDatePickerOverlay> createState() =>
      _TimeSheetDatePickerOverlayState();
}

class _TimeSheetDatePickerOverlayState
    extends State<TimeSheetDatePickerOverlay> {
  final controller = OverlayPortalController();
  final LayerLink _link = LayerLink();

  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  controller.hide();
                },
                child: Container(),
              ),
            ),
            CompositedTransformFollower(
              offset: const Offset(0, 10),
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              link: _link,

              child: Container(
                constraints: const BoxConstraints(maxWidth: 362),
                width: 362,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.colors.surface,
                  border: Border.all(color: context.colors.outline),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.shadow,
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppDatePicker.range(
                      onChanged: (start, end) {
                        setState(() {
                          startDate = start;
                          endDate = end;
                        });
                      },
                      selectionMode: DatePickerSelectionMode.week,
                      disabledDates: [],
                      rangeDate: widget.activeWeek,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: context.colors.outline,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: AppOutlinedButton(
                              onPressed: () {
                                controller.hide();
                              },
                              text: context.strings.cancel,
                              color: SemanticColor.neutral,
                            ),
                          ),
                          Expanded(
                            child: AppFilledButton(
                              onPressed: () {
                                if (startDate != null && endDate != null) {
                                  widget.onConfirmed(startDate!, endDate!);
                                }
                                controller.hide();
                              },
                              text: context.strings.confirm,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      child: CompositedTransformTarget(
        link: _link,
        child: AppTextButton(
          color: SemanticColor.neutral,
          onPressed: () {
            controller.show();
          },
          text: widget.title,
          suffixIcon: BetterIcons.arrowDown01Outline,
        ),
      ),
    );
  }
}
