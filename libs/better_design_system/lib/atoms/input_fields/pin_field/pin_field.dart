import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

typedef BetterPinField = AppPinField;

class AppPinField extends StatefulWidget {
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final SemanticColor color;
  final int length;
  final String? initialValue;
  final bool isFilled;
  final bool autofocus;

  const AppPinField({
    super.key,
    this.onCompleted,
    this.onChanged,
    required this.length,
    this.initialValue,
    this.isFilled = true,
    this.autofocus = true,
    this.color = SemanticColor.primary,
  });

  @override
  State<AppPinField> createState() => _AppPinFieldState();
}

class _AppPinFieldState extends State<AppPinField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: widget.length,
      controller: _controller,
      autofocus: widget.autofocus,
      defaultPinTheme: PinTheme(
        padding: const EdgeInsets.all(16),
        textStyle: context.textTheme.titleLarge?.copyWith(
          color: widget.color.main(context),
        ),
        decoration: BoxDecoration(
          color: widget.isFilled
              ? widget.color.containerColor(context)
              : context.colors.surface,
          borderRadius:
              (context.theme.inputDecorationTheme.border as OutlineInputBorder)
                  .borderRadius,
          border: Border.all(
            color: widget.isFilled
                ? context.colors.surface
                : context.theme.inputDecorationTheme.border!.borderSide.color,
          ),
        ),
      ),
      focusedPinTheme: PinTheme(
        padding: const EdgeInsets.all(16),
        textStyle: context.textTheme.titleLarge,
        decoration: BoxDecoration(
          color: widget.isFilled
              ? context.colors.surfaceVariant
              : context.colors.surface,
          borderRadius:
              (context.theme.inputDecorationTheme.border as OutlineInputBorder)
                  .borderRadius,
          border: Border.all(
            color: widget.isFilled
                ? context.colors.surface
                : context.theme.inputDecorationTheme.border!.borderSide.color,
          ),
        ),
      ),
      followingPinTheme: PinTheme(
        padding: const EdgeInsets.all(16),
        textStyle: context.textTheme.titleLarge,
        decoration: BoxDecoration(
          color: widget.isFilled
              ? context.colors.surfaceVariant
              : context.colors.surface,
          borderRadius:
              (context.theme.inputDecorationTheme.border as OutlineInputBorder)
                  .borderRadius,
          border: Border.all(
            color: widget.isFilled
                ? context.colors.surface
                : context.theme.inputDecorationTheme.border!.borderSide.color,
          ),
        ),
      ),

      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
    );
  }
}
