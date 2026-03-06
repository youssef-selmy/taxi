import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'am_pm_indicator.dart';

typedef BetterTimeField = AppTimeField;

class AppTimeField extends StatefulWidget {
  final TimeOfDay? defaultValue;
  final ValueChanged<TimeOfDay?>? onChanged;
  final Function(TimeOfDay?)? onSaved;
  // validator
  final String? Function(TimeOfDay?)? validator;
  final String? label;

  const AppTimeField({
    super.key,
    this.defaultValue,
    required this.onChanged,
    this.onSaved,
    this.validator,
    this.label,
  });

  @override
  State<AppTimeField> createState() => _AppTimeFieldState();
}

class _AppTimeFieldState extends State<AppTimeField> {
  bool hasFocus = false;
  final FocusNode _hourFocusNode = FocusNode();
  final FocusNode _minuteFocusNode = FocusNode();

  TimeOfDay? _timeOfDayFromInternal(InternalTimeOfDay? value) {
    if (value == null ||
        value.$1 == null ||
        value.$2 == null ||
        value.$3 == null) {
      return null;
    }
    return TimeOfDay(hour: value.$1!, minute: value.$2!);
  }

  InternalTimeOfDay? _internalTimeOfDayFromTimeOfDay(TimeOfDay? value) {
    if (value == null) return null;
    return (value.hour % 12, value.minute, value.period);
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (focus) {
        setState(() {
          hasFocus = focus;
        });
      },
      child: FormField<(int?, int?, DayPeriod?)>(
        validator: (value) {
          if (widget.validator != null) {
            final timeOfDay = _timeOfDayFromInternal(value);
            return widget.validator!(timeOfDay);
          }
          return null;
        },
        initialValue: _internalTimeOfDayFromTimeOfDay(widget.defaultValue),
        onSaved: (value) {
          final timeOfDay = _timeOfDayFromInternal(value);
          widget.onSaved?.call(timeOfDay);
        },
        builder: (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: context.theme.inputDecorationTheme.labelStyle,
              ),
              const SizedBox(height: 4),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: hasFocus
                        ? context.colors.primaryContainer
                        : context.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: Row(
                    spacing: 6,
                    children: [
                      SizedBox(
                        width: _textWidth,
                        child: TextField(
                          decoration: _inputDecoration(context),
                          focusNode: _hourFocusNode,
                          onChanged: (p0) {
                            state.didChange((
                              int.tryParse(p0) ?? 0,
                              state.value?.$2,
                              state.value?.$3,
                            ));
                            widget.onChanged?.call(
                              _timeOfDayFromInternal(state.value),
                            );
                            if (p0.length == 2) {
                              _minuteFocusNode.requestFocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-5]?[0-9]?$'),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        ':',
                        style: context.textTheme.bodyMedium?.variant(context),
                      ),
                      SizedBox(
                        width: _textWidth,
                        child: TextField(
                          decoration: _inputDecoration(context),
                          focusNode: _minuteFocusNode,
                          onChanged: (p0) {
                            state.didChange((
                              state.value?.$1,
                              int.tryParse(p0) ?? 0,
                              state.value?.$3,
                            ));
                            widget.onChanged?.call(
                              _timeOfDayFromInternal(state.value),
                            );
                            if (p0.length == 2) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                hasFocus = false;
                              });
                            }
                            if (p0.isEmpty) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-5]?[0-9]?$'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                AmPmIndicator(
                  defaultValue: state.value?.$3,
                  onSelected: (value) {
                    state.didChange((state.value?.$1, state.value?.$2, value));
                    widget.onChanged?.call(_timeOfDayFromInternal(state.value));
                  },
                ),
              ],
            ),
            if (state.errorText != null) ...[
              const SizedBox(height: 4),
              Text(
                state.errorText!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: '00',
      hintStyle: context.theme.inputDecorationTheme.hintStyle,
      isDense: true,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }

  double get _textWidth => 25;
}

typedef InternalTimeOfDay = (int?, int?, DayPeriod?);
