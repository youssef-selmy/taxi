import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/input_fields/date_input/date_input.dart';
import 'package:better_design_system/atoms/input_fields/text_field_density.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/date_picker/date_picker.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterDatePickerField = AppDatePickerField;

class AppDatePickerField extends StatefulWidget {
  final String? title;
  final String? hint;
  final DateTime? initialValue;
  final ValueChanged<DateTime?> onChanged;
  final List<(DateTime, DateTime)>? disabledDates;
  final List<DateTime>? events;
  final bool pickTime;
  final DatePickerFieldStyle style;
  final bool isFilled;
  final String? label;
  final String? helpText;
  final SemanticColor helpTextColor;
  final bool isDisabled;
  final TextFieldDensity density;
  final IconData? suffixIcon;
  final String? Function(DateTime?)? validator;
  final Function(DateTime?)? onSaved;
  final bool isRequired;

  const AppDatePickerField({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.disabledDates,
    this.events,
    this.pickTime = false,
    this.hint,
    this.style = DatePickerFieldStyle.overlay,
    this.isFilled = true,
    this.label,
    this.helpText,
    this.helpTextColor = SemanticColor.primary,
    this.isDisabled = false,
    this.density = TextFieldDensity.responsive,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.isRequired = false,
    this.title,
  });
  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

class _AppDatePickerFieldState extends State<AppDatePickerField>
    with SingleTickerProviderStateMixin {
  final controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  bool _showAbove = false;
  bool _isHiding = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

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

  DateTime? _tryParseDate(String input) {
    try {
      final parts = input.split('/');
      if (parts.length != 3) return null;

      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);

      if (day == null || month == null || year == null) return null;
      if (month < 1 || month > 12) return null;
      if (day < 1 || day > 31) return null;

      final maxDay = DateTime(year, month + 1, 0).day;
      if (day > maxDay) return null;

      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      validator: widget.validator,
      builder: (state) {
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
                          onChanged: (date) {
                            // Skip if already hiding
                            if (_isHiding) return;

                            // Hide overlay first, then update state after animation completes
                            _hideOverlay().then((_) {
                              if (mounted) {
                                state.didChange(date);
                                widget.onChanged(date);
                              }
                            });
                          },
                          title: widget.title,
                          activeDate: widget.initialValue,
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
            child: AppDateInput(
              isRequired: widget.isRequired,
              helpText: widget.helpText,
              helpTextColor: widget.helpTextColor,
              isDisabled: widget.isDisabled,
              label: widget.label,
              density: widget.density,
              isFilled: widget.isFilled,
              errorText: state.errorText,

              onChanged: (input) {
                final trimmed = input?.trim();

                if (trimmed?.length == 10) {
                  final parsed = _tryParseDate(trimmed!);
                  if (parsed != null) {
                    state.didChange(parsed);

                    widget.onChanged(parsed);
                  }
                }
              },

              validator: (value) {
                final trimmed = value?.trim() ?? '';

                if (trimmed.length < 10) {
                  return 'Date must be 10 characters long';
                }

                final parsed = _tryParseDate(trimmed);
                if (parsed == null) return 'Invalid date format';

                return null;
              },
              initialValue: state.value,
              suffixIcon: AppIconButton(
                onPressed: widget.isDisabled
                    ? null
                    : () async {
                        if (widget.style == DatePickerFieldStyle.dialog ||
                            _shouldUseBottomSheet()) {
                          await showDialog(
                            context: context,
                            builder: (dialogContext) => AppResponsiveDialog(
                              defaultDialogType: DialogType.bottomSheet,
                              desktopDialogType: DialogType.dialog,
                              maxWidth: 400,
                              contentPadding: EdgeInsets.zero,
                              child: AppDatePicker(
                                onChanged: (date) {
                                  Navigator.pop(dialogContext);
                                  // Update state after dialog is closed
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    state.didChange(date);
                                    widget.onChanged(date);
                                  });
                                },
                                title: widget.title,
                                activeDate: widget.initialValue,
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
      },
    );
  }
}

enum DatePickerFieldStyle { overlay, dialog }
