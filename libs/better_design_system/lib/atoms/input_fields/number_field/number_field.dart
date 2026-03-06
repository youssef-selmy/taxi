import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'number_up_down_button.dart';
export '../text_field_density.dart';

typedef BetterNumberField = AppNumberField;

class AppNumberField extends StatefulWidget {
  final double? initialValue;
  final double minValue;
  final double? maxValue;
  final String? title;
  final String? sublabel;
  final String? subtitle;
  final String? hint;
  final String? errorText;
  final void Function(double?)? onChanged;
  final void Function(double?)? onSaved;
  final String? Function(double?)? validator;
  final bool onlyInteger;
  final TextFieldDensity density;
  final bool isDisabled;
  final bool isFilled;
  final List<TextInputFormatter> inputFormatters;
  final Widget? prefix;
  final Widget? suffix;
  final double step;
  final FocusNode? focusNode;
  final bool autofocus;
  final int decimalPlaces;

  const AppNumberField({
    super.key,
    this.initialValue,
    this.minValue = 0,
    this.maxValue,
    this.title,
    this.sublabel,
    this.hint,
    this.errorText,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.onlyInteger = false,
    this.density = TextFieldDensity.responsive,
    this.inputFormatters = const [],
    this.subtitle,
    this.isDisabled = false,
    this.isFilled = true,
    this.prefix,
    this.suffix,
    this.step = 1,
    this.focusNode,
    this.autofocus = false,
    this.decimalPlaces = 5,
  });

  @override
  State<AppNumberField> createState() => _AppNumberFieldState();

  factory AppNumberField.integer({
    Key? key,
    int? initialValue,
    int minValue = 0,
    int? maxValue,
    String? title,
    String? sublabel,
    String? hint,
    String? errorText,
    void Function(int?)? onChanged,
    void Function(int?)? onSaved,
    String? Function(int?)? validator,
    TextFieldDensity density = TextFieldDensity.responsive,
    bool isDisabled = false,
    bool isFilled = true,
    String? subtitle,
    double step = 1,
  }) => AppNumberField(
    key: key,
    initialValue: initialValue?.toDouble(),
    minValue: minValue.toDouble(),
    maxValue: maxValue?.toDouble(),
    title: title,
    sublabel: sublabel,
    hint: hint,
    errorText: errorText,
    onChanged: (value) => onChanged?.call(value?.toInt()),
    onSaved: (value) => onSaved?.call(value?.toInt()),
    validator: (value) => validator?.call(value?.toInt()),
    onlyInteger: true,
    density: density,
    isDisabled: isDisabled,
    isFilled: isFilled,
    subtitle: subtitle,
    step: step,
  );
}

class _AppNumberFieldState extends State<AppNumberField> {
  final _controller = TextEditingController();
  final _formFieldKey = GlobalKey<FormFieldState<double>>();
  FocusNode? _internalFocusNode;

  // AppTextField always disposes whatever FocusNode it receives, so we let it
  // own the lifecycle. We only track hasFocus here for suppressing reformats.
  bool get _hasFocus =>
      (widget.focusNode ?? _internalFocusNode)?.hasFocus ?? false;

  /// Rounds a value to avoid floating-point precision errors.
  /// The precision is determined by the number of decimal places in the step.
  double _roundToPrecision(double value) {
    final stepStr = widget.step.toString();
    final decimalIndex = stepStr.indexOf('.');
    if (decimalIndex == -1) return value.roundToDouble();
    final decimals = stepStr.length - decimalIndex - 1;
    final multiplier = _pow10(decimals);
    return (value * multiplier).round() / multiplier;
  }

  static double _pow10(int exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= 10;
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
    _setControllerText(widget.initialValue);
  }

  void _setControllerText(double? value) {
    _controller.text = widget.onlyInteger
        ? (value?.toStringAsFixed(0) ?? '')
        : (value?.toString() ?? '');
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  @override
  void didUpdateWidget(AppNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue && !_hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setControllerText(widget.initialValue);
        _formFieldKey.currentState?.didChange(widget.initialValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: _formFieldKey,
      initialValue: widget.initialValue,
      validator: widget.validator,
      onSaved: (newValue) => widget.onSaved?.call(newValue),
      builder: (state) {
        final normalizedText = _controller.text.replaceAll(',', '.');
        if (state.value != null &&
            double.tryParse(normalizedText) != state.value &&
            !_hasFocus) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _setControllerText(state.value);
            state.didChange(state.value);
          });
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              iconPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 0,
              ),
              label: widget.title,
              sublabel: widget.sublabel,
              keyboardType: TextInputType.numberWithOptions(
                decimal: !widget.onlyInteger,
                signed: false,
              ),
              focusNode: widget.focusNode ?? _internalFocusNode,
              autofocus: widget.autofocus,
              inputFormatters: [
                ...widget.inputFormatters,
                if (widget.onlyInteger)
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+'))
                else
                  FilteringTextInputFormatter.allow(
                    RegExp(
                      r'^\d+[.,]?\d{0,' +
                          widget.decimalPlaces.toString() +
                          r'}',
                    ),
                  ),
              ],
              prefixIcon: widget.prefix,

              controller: _controller,
              isFilled: widget.isFilled,
              density: widget.density,
              suffixIcon: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.suffix != null) widget.suffix!,
                  NumberUpDownButton(
                    onUp: () {
                      final number = double.tryParse(state.value.toString());
                      if (number == null) {
                        state.didChange(widget.minValue);
                        widget.onChanged?.call(widget.minValue);
                        return;
                      }

                      if (widget.maxValue != null &&
                          number >= widget.maxValue!) {
                        return;
                      }

                      final newValue = _roundToPrecision(number + widget.step);
                      state.didChange(newValue);
                      widget.onChanged?.call(newValue);
                    },
                    onDown: () {
                      final number = double.tryParse(state.value.toString());
                      if (number == null) {
                        state.didChange(widget.minValue);
                        widget.onChanged?.call(widget.minValue);
                        return;
                      }

                      if (number <= widget.minValue) {
                        return;
                      }

                      final newValue = _roundToPrecision(number - widget.step);
                      state.didChange(newValue);
                      widget.onChanged?.call(newValue);
                    },
                  ),
                ],
              ),
              hint: widget.hint,
              onChanged: (value) {
                if (value.isEmpty) {
                  state.didChange(null);
                  return;
                }

                // Normalize decimal separator (some locales use comma)
                final normalizedValue = value.replaceAll(',', '.');
                final number = double.tryParse(normalizedValue);
                if (number == null) {
                  state.didChange(null);
                  return;
                }

                if (widget.onlyInteger && !normalizedValue.contains('.')) {
                  state.didChange(number);
                  widget.onChanged?.call(number);
                  return;
                }

                if (number < widget.minValue) {
                  state.didChange(widget.minValue);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _setControllerText(widget.minValue);
                  });
                  return;
                }

                if (widget.maxValue != null && number > widget.maxValue!) {
                  state.didChange(widget.maxValue);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _setControllerText(widget.maxValue);
                  });
                  return;
                }

                state.didChange(number);
                widget.onChanged?.call(number);
              },
            ),
            if (widget.errorText != null || state.hasError) ...[
              const SizedBox(height: 8),
              Text(
                widget.errorText ?? state.errorText!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.error,
                ),
              ),
            ],
            if (widget.subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                widget.subtitle!,
                style: context.textTheme.bodyMedium?.variant(context),
              ),
            ],
          ],
        );
      },
    );
  }
}
