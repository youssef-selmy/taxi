import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

typedef BetterDateRangeInput = AppDateRangeInput;

class AppDateRangeInput extends StatefulWidget {
  final String? label;
  final bool isRequired;
  final String? helpText;
  final SemanticColor helpTextColor;
  final bool isFilled;
  final bool isDisabled;
  final (DateTime, DateTime)? initialValue;
  final void Function(DateTime?)? onSaved;
  final String? Function(String?)? validator;
  final void Function((DateTime, DateTime))? onChanged;
  final Widget? suffixIcon;
  final TextFieldDensity density;

  const AppDateRangeInput({
    super.key,
    this.label,
    this.isRequired = false,
    this.helpText,
    this.helpTextColor = SemanticColor.neutral,
    this.initialValue,
    this.isFilled = true,
    this.isDisabled = false,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.density = TextFieldDensity.responsive,
  });

  @override
  State<AppDateRangeInput> createState() => _AppDateRangeInputState();
}

class _AppDateRangeInputState extends State<AppDateRangeInput> {
  late TextEditingController _controller;
  (DateTime, DateTime)? _currentValue;
  final DateFormat _defaultFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();

    _currentValue = widget.initialValue;
    _controller = TextEditingController(
      text: _currentValue != null
          ? '${_formatDate(_currentValue!.$1)} → ${_formatDate(_currentValue!.$2)}'
          : '',
    );
  }

  String _formatDate(DateTime date) {
    return _defaultFormat.format(date);
  }

  DateTime? _tryParseDate(String input) {
    try {
      return _defaultFormat.parseStrict(input);
    } catch (_) {
      return null;
    }
  }

  @override
  void didUpdateWidget(covariant AppDateRangeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _currentValue = widget.initialValue;
      _controller.text = _currentValue != null
          ? '${_formatDate(_currentValue!.$1)} → ${_formatDate(_currentValue!.$2)}'
          : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      validator: widget.validator,
      hint: 'Start date → End date',
      controller: _controller,
      helpText: widget.helpText,
      isDisabled: widget.isDisabled,
      isFilled: widget.isFilled,
      isRequired: widget.isRequired,
      iconPadding: const EdgeInsets.all(2),
      onChanged: (value) {
        final parts = value.split('→').map((e) => e.trim()).toList();

        final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
        final isComplete = digitsOnly.length == 16;

        if (parts.length == 2) {
          final start = _tryParseDate(parts[0]);
          final end = _tryParseDate(parts[1]);

          if (start != null && end != null) {
            setState(() => _currentValue = (start, end));

            if (isComplete) {
              widget.onChanged?.call(_currentValue!);
            }
          }
        }
      },

      helpTextColor: widget.helpTextColor,
      label: widget.label,
      density: widget.density,
      suffixIcon: widget.suffixIcon,
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
          final buffer = StringBuffer();

          int i = 0;
          while (i < digitsOnly.length && i < 16) {
            if (i == 8) {
              buffer.write(' → ');
            }

            buffer.write(digitsOnly[i]);

            if (((i == 1 || i == 3) || (i == 9 || i == 11)) &&
                i != digitsOnly.length - 1) {
              buffer.write('/');
            }

            i++;
          }

          final newText = buffer.toString();
          return TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }),
      ],
    );
  }
}
