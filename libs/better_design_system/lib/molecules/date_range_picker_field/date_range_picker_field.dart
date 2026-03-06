import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/input_fields/date_range_input/date_range_input.dart';
import 'package:better_design_system/atoms/input_fields/text_field_density.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/date_picker/date_picker.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterDateRangePickerField = AppDateRangePickerField;

class AppDateRangePickerField extends StatefulWidget {
  final String? datePickerTitle;
  final String? hint;
  final (DateTime, DateTime)? activeDate;
  final ValueChanged<(DateTime, DateTime)>? onChanged;
  final List<(DateTime, DateTime)>? disabledDates;
  final List<DateTime>? events;
  final bool pickTime;
  final DateRangePickerFieldStyle style;
  final bool isFilled;
  final String? label;

  final String? helpText;
  final SemanticColor helpTextColor;
  final bool isDisabled;
  final TextFieldDensity density;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final bool isRequired;
  const AppDateRangePickerField({
    super.key,

    this.activeDate,
    required this.onChanged,

    this.disabledDates,
    this.events,
    this.pickTime = false,
    this.hint,
    this.style = DateRangePickerFieldStyle.overlay,
    this.isFilled = true,
    this.label,

    this.helpText,
    this.helpTextColor = SemanticColor.primary,
    this.isDisabled = false,
    this.density = TextFieldDensity.responsive,
    this.suffixIcon,
    this.validator,
    this.isRequired = false,
    this.datePickerTitle,
  });
  @override
  State<AppDateRangePickerField> createState() =>
      _AppDateRangePickerFieldState();
}

class _AppDateRangePickerFieldState extends State<AppDateRangePickerField>
    with SingleTickerProviderStateMixin {
  final controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  bool _showAbove = false;
  bool _isHiding = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  (DateTime, DateTime)? editingDate = (DateTime.now(), DateTime.now());
  (DateTime, DateTime)? confirmedDate;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isValidDateRange((DateTime, DateTime) range) {
    final (start, end) = range;
    // Check for invalid dates (year 0 or before, which indicates parsing failure)
    if (start.year <= 0 || end.year <= 0) return false;
    // Check that start is not after end
    if (start.isAfter(end)) return false;
    // Check that it's actually a range (not the same moment)
    if (start.isAtSameMomentAs(end)) return false;
    return true;
  }

  void _calculatePosition() {
    final RenderBox? renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    const overlayHeight = 500.0;
    final spaceBelow = screenHeight - (position.dy + size.height);
    final spaceAbove = position.dy;

    _showAbove = spaceBelow < overlayHeight && spaceAbove > spaceBelow;
  }

  bool _shouldUseBottomSheet() {
    final RenderBox? renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return false;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    const overlayHeight = 500.0;
    final spaceBelow = screenHeight - (position.dy + size.height);
    final spaceAbove = position.dy;

    return spaceBelow < overlayHeight && spaceAbove < overlayHeight;
  }

  Future<void> _hideOverlay() async {
    _isHiding = true;
    await _animationController.reverse();
    controller.hide();
    _isHiding = false;
  }

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
                  _hideOverlay();
                },
                child: Container(),
              ),
            ),
            CompositedTransformFollower(
              offset: Offset(0, _showAbove ? -10 : 10),
              targetAnchor: _showAbove
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              followerAnchor: _showAbove
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              link: _link,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  alignment: _showAbove
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
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

                    child: AppDatePicker(
                      onChanged: (_) {},
                      onRangeChanged: (start, end) {
                        // Skip if already hiding
                        if (_isHiding) return;

                        editingDate = (start, end);
                        // Auto-dismiss when a valid range is selected
                        if (_isValidDateRange((start, end))) {
                          // Hide overlay first, then update state after animation completes
                          _hideOverlay().then((_) {
                            if (mounted) {
                              widget.onChanged!(editingDate!);
                              setState(() {
                                confirmedDate = editingDate;
                              });
                            }
                          });
                        }
                      },
                      title: widget.datePickerTitle,
                      rangeDate: confirmedDate ?? widget.activeDate,
                      selectionMode: DatePickerSelectionMode.range,
                      disabledDates: widget.disabledDates,
                      events: widget.events,
                      pickTime: widget.pickTime,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: CompositedTransformTarget(
        key: _fieldKey,
        link: _link,
        child: AppDateRangeInput(
          isRequired: widget.isRequired,
          helpText: widget.helpText,
          helpTextColor: widget.helpTextColor,
          isDisabled: widget.isDisabled,
          label: widget.label,
          density: widget.density,
          validator: widget.validator != null
              ? (value) {
                  // Use the confirmed date for validation if available, otherwise use the text input
                  final dateToValidate = confirmedDate ?? widget.activeDate;
                  if (dateToValidate != null) {
                    // Convert the date range to a string representation for validation
                    final dateString =
                        '${dateToValidate.$1.toString()} - ${dateToValidate.$2.toString()}';
                    return widget.validator!(dateString);
                  }
                  return widget.validator!(value);
                }
              : null,
          isFilled: widget.isFilled,
          onChanged: (date) {
            if (_isValidDateRange(date)) {
              widget.onChanged!(date);
              setState(() {
                confirmedDate = date;
              });
            }
          },
          initialValue: confirmedDate ?? widget.activeDate,
          suffixIcon: AppIconButton(
            onPressed: widget.isDisabled
                ? null
                : () async {
                    if (widget.style == DateRangePickerFieldStyle.dialog ||
                        _shouldUseBottomSheet()) {
                      await showDialog(
                        context: context,

                        builder: (dialogContext) => AppResponsiveDialog(
                          defaultDialogType: DialogType.bottomSheet,
                          desktopDialogType: DialogType.dialog,
                          contentPadding: EdgeInsets.zero,
                          maxWidth: 350,
                          child: AppDatePicker(
                            onChanged: (_) {},
                            onRangeChanged: (start, end) {
                              // Auto-dismiss when a valid range is selected
                              if (_isValidDateRange((start, end))) {
                                Navigator.pop(dialogContext);
                                // Update state after dialog is closed
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  if (mounted) {
                                    widget.onChanged!((start, end));
                                    setState(() {
                                      confirmedDate = (start, end);
                                    });
                                  }
                                });
                              }
                            },
                            title: widget.datePickerTitle,
                            rangeDate: confirmedDate ?? widget.activeDate,
                            selectionMode: DatePickerSelectionMode.range,
                            disabledDates: widget.disabledDates,
                            events: widget.events,
                            pickTime: widget.pickTime,
                          ),
                        ),
                      );
                    } else {
                      _calculatePosition();
                      controller.show();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _animationController.forward();
                      });
                    }
                  },
            icon: widget.suffixIcon ?? BetterIcons.calendar01Outline,
          ),
        ),
      ),
    );
  }
}

enum DateRangePickerFieldStyle { overlay, dialog }
