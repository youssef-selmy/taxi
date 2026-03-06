import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

typedef BetterDateInput = AppDateInput;

class AppDateInput extends StatefulWidget {
  final String? label;

  final bool isRequired;
  final String? helpText;
  final SemanticColor helpTextColor;
  final bool isFilled;
  final bool isDisabled;
  final DateTime? initialValue;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final Widget? suffixIcon;
  final TextFieldDensity density;
  final String? errorText;

  const AppDateInput({
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
    this.errorText,
    this.density = TextFieldDensity.responsive,
  });

  @override
  State<AppDateInput> createState() => _AppDateInputState();
}

class _AppDateInputState extends State<AppDateInput> {
  late TextEditingController _controller;
  DateTime? _currentValue;
  final DateFormat _defaultFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();

    _currentValue = widget.initialValue;
    _controller = TextEditingController(
      text: _currentValue != null ? _formatDate(_currentValue!) : '',
    );
  }

  String _formatDate(DateTime date) {
    return _defaultFormat.format(date);
  }

  // DateTime? _tryParseDate(String input) {
  //   try {
  //     final parts = input.split('/');
  //     if (parts.length != 3) return null;

  //     final day = int.tryParse(parts[0]);
  //     final month = int.tryParse(parts[1]);
  //     final year = int.tryParse(parts[2]);

  //     if (day == null || month == null || year == null) return null;
  //     if (month < 1 || month > 12) return null;

  //     final maxDay = _daysInMonth(year, month);
  //     if (day < 1 || day > maxDay) return null;

  //     return DateTime(year, month, day);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // int _daysInMonth(int year, int month) {
  //   final nextMonth =
  //       month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
  //   final lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));
  //   return lastDayOfMonth.day;
  // }

  @override
  void didUpdateWidget(covariant AppDateInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      _currentValue = widget.initialValue;
      _controller.text = _currentValue != null
          ? _formatDate(_currentValue!)
          : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hint: 'Enter date',
      controller: _controller,
      helpText: widget.helpText,
      isDisabled: widget.isDisabled,
      isFilled: widget.isFilled,
      isRequired: widget.isRequired,
      errorText: widget.errorText,
      onChanged: (value) {
        widget.onChanged?.call(value);
      },

      onSaved: widget.onSaved,
      validator: widget.validator,
      helpTextColor: widget.helpTextColor,
      label: widget.label,
      density: widget.density,
      suffixIcon: widget.suffixIcon,
      iconPadding: const EdgeInsets.all(2),
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
          final buffer = StringBuffer();
          for (int i = 0; i < digitsOnly.length && i < 8; i++) {
            buffer.write(digitsOnly[i]);
            if ((i == 1 || i == 3) && i != digitsOnly.length - 1) {
              buffer.write('/');
            }
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
