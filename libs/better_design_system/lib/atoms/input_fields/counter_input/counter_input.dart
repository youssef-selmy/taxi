import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/input_fields/counter_input/counter_input_size.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
export 'package:better_design_system/atoms/input_fields/text_field_density.dart';
export 'counter_input_size.dart';

typedef BetterCounterInput = AppCounterInput;

class AppCounterInput extends StatefulWidget {
  final String? label;
  final String? sublabel;
  final bool isRequired;
  final String? helpText;
  final SemanticColor helpTextColor;
  final int initialValue;
  final int min;
  final int max;
  final bool isFilled;
  final bool isDisabled;
  final String? Function(int?)? validator;
  final void Function(int?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final void Function(int)? onChanged;
  final CounterInputSize size;
  final String Function(int)? labelBuilder;

  const AppCounterInput({
    super.key,
    this.label,
    this.sublabel,
    this.isRequired = false,
    this.helpText,
    this.helpTextColor = SemanticColor.neutral,
    this.initialValue = 0,
    this.isFilled = true,
    this.isDisabled = false,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.onChanged,
    this.min = 0,
    this.max = 100,
    this.size = CounterInputSize.medium,
    this.labelBuilder,
  });

  @override
  createState() => _AppCounterInputState();
}

class _AppCounterInputState extends State<AppCounterInput> {
  FocusNode focusNode = FocusNode();
  late TextEditingController controller;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    final currentValue = widget.min < widget.initialValue
        ? widget.initialValue
        : widget.min;
    controller = TextEditingController(text: currentValue.toString());

    // When focus is lost, restore minimum value if field is empty
    focusNode.addListener(() {
      if (!focusNode.hasFocus && controller.text.isEmpty) {
        controller.text = widget.min.toString();
      }
    });
  }

  @override
  void didUpdateWidget(covariant AppCounterInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      final newValue = widget.initialValue.clamp(widget.min, widget.max);
      controller.text = newValue.toString();
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      enabled: !widget.isDisabled,
      initialValue: widget.initialValue,
      validator: widget.validator,
      onSaved: (newValue) => widget.onSaved?.call(newValue),
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              textAlign: TextAlign.center,
              label: widget.label,
              sublabel: widget.sublabel,
              readOnly: widget.isDisabled,
              focusNode: focusNode,
              controller: controller,
              isDisabled: widget.isDisabled,
              isRequired: widget.isRequired,
              onChanged: (value) {
                if (value.isEmpty) {
                  state.didChange(null);
                  return;
                }
                final parsedValue = int.tryParse(value);
                if (parsedValue != null) {
                  state.didChange(parsedValue);
                  widget.onChanged?.call(parsedValue);
                }
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TextInputFormatter.withFunction((oldValue, newValue) {
                  // Allow empty text so users can clear and type new value
                  if (newValue.text.isEmpty) return newValue;

                  final int? value = int.tryParse(newValue.text);
                  if (value == null || value > widget.max) {
                    return oldValue;
                  }
                  if (value < widget.min) {
                    return oldValue;
                  }
                  return newValue;
                }),
              ],

              isFilled: widget.isFilled,
              keyboardType: TextInputType.number,
              iconPadding: const EdgeInsets.all(2),
              prefixIcon: AppIconButton(
                isCircular: true,
                onPressed: widget.isDisabled
                    ? null
                    : () {
                        final currentValue =
                            int.tryParse(controller.text) ?? widget.min;
                        if (currentValue > widget.min) {
                          final newValue = currentValue - 1;
                          controller.text = newValue.toString();
                          state.didChange(newValue);
                          widget.onChanged?.call(newValue);
                        }
                      },
                icon: BetterIcons.removeCircleFilled,
              ),
              suffixIcon: AppIconButton(
                onPressed: widget.isDisabled
                    ? null
                    : () {
                        final currentValue =
                            int.tryParse(controller.text) ?? widget.min;
                        if (currentValue < widget.max) {
                          final newValue = currentValue + 1;
                          controller.text = newValue.toString();
                          state.didChange(newValue);
                          widget.onChanged?.call(newValue);
                        }
                      },
                icon: BetterIcons.addCircleFilled,
                isCircular: true,
              ),

              helpText: widget.helpText,
            ),

            if (state.errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                state.errorText!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
