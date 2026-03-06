import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

typedef BetterPasswordStrength = AppPasswordStrength;

class AppPasswordStrength extends StatefulWidget {
  final String? password;
  final String? confirmPassword;
  final bool isObscure;
  final Function(int strength)? onStrengthChanged;

  const AppPasswordStrength({
    super.key,
    required this.password,
    required this.confirmPassword,
    this.isObscure = true,
    this.onStrengthChanged,
  });

  @override
  State<AppPasswordStrength> createState() => _AppPasswordStrengthState();
}

class _AppPasswordStrengthState extends State<AppPasswordStrength> {
  int? _previousStrength;

  @override
  void initState() {
    super.initState();
    _previousStrength = passwordStrength;
  }

  @override
  void didUpdateWidget(AppPasswordStrength oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.password != widget.password ||
        oldWidget.confirmPassword != widget.confirmPassword) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _notifyStrengthChange();
      });
    }
  }

  void _notifyStrengthChange() {
    final currentStrength = passwordStrength;
    if (_previousStrength != currentStrength) {
      _previousStrength = currentStrength;
      widget.onStrengthChanged?.call(currentStrength);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: switch (passwordStrength) {
                    0 => context.colors.outline,
                    1 => context.colors.error,
                    2 => context.colors.error,
                    3 => context.colors.warning,
                    4 => context.colors.success,
                    _ => context.colors.success,
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: switch (passwordStrength) {
                    >= 2 && < 3 => context.colors.error,
                    3 => context.colors.warning,
                    >= 4 => context.colors.success,
                    _ => context.colors.outline,
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: switch (passwordStrength) {
                    3 => context.colors.warning,
                    >= 4 => context.colors.success,
                    _ => context.colors.outline,
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: switch (passwordStrength) {
                    >= 4 => context.colors.success,
                    _ => context.colors.outline,
                  },
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            _passwordStrengthText(context),
            style: context.textTheme.labelMedium?.apply(
              color: _strengthColor(context),
            ),
          ),
        ),
        if (widget.isObscure) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _icon(context, isPasswordMatch),
              const SizedBox(width: 8),
              Text(
                isPasswordMatch
                    ? context.strings.passwordsMatch
                    : context.strings.passwordsDoNotMatch,
                style: context.textTheme.labelSmall?.variant(context),
              ),
            ],
          ),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _icon(context, isPasswordLengthValid),
            const SizedBox(width: 8),
            Text(
              isPasswordLengthValid
                  ? context.strings.passwordLengthIsValid
                  : context.strings.passwordRuleLength,
              style: context.textTheme.labelSmall?.variant(context),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _icon(context, isPasswordSecure),
            const SizedBox(width: 8),
            Text(
              isPasswordSecure
                  ? context.strings.passwordIsSecure
                  : context.strings.passwordRuleDescription,
              style: context.textTheme.labelSmall?.variant(context),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '• ${context.strings.passwordRuleUpperCase}\n• ${context.strings.passwordRuleLowerCase}\n• ${context.strings.passwordRuleNumber}\n• ${context.strings.passwordRuleSpecialCharacter}',
            style: context.textTheme.labelSmall?.variant(context),
          ),
        ),
      ],
    );
  }

  Icon _icon(BuildContext context, bool isValid) => Icon(
    BetterIcons.checkmarkCircle02Filled,
    color: iconColor(context, isValid),
    size: 16,
  );

  Color iconColor(BuildContext context, bool isValid) =>
      isValid ? context.colors.success : context.colors.onSurfaceVariantLow;

  bool get isPasswordMatch =>
      (widget.isObscure == false ||
      (widget.password?.isNotEmpty ?? false) &&
          widget.password == widget.confirmPassword);

  bool get isPasswordLengthValid =>
      widget.password != null &&
      widget.password!.length >= 8 &&
      widget.password!.length <= 20;
  bool get doesPasswordContainNumber =>
      widget.password != null && RegExp(r'\d').hasMatch(widget.password!);
  bool get doesPasswordContainSpecialCharacter =>
      widget.password != null &&
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(widget.password!);
  bool get doesPasswordContainUppercase =>
      widget.password != null && RegExp(r'[A-Z]').hasMatch(widget.password!);
  bool get doesPasswordContainLowercase =>
      widget.password != null && RegExp(r'[a-z]').hasMatch(widget.password!);

  bool get isPasswordSecure =>
      [
        doesPasswordContainLowercase,
        doesPasswordContainUppercase,
        doesPasswordContainSpecialCharacter,
        doesPasswordContainNumber,
      ].where((element) => element).length >=
      2;

  bool get isPasswordValid =>
      isPasswordMatch && isPasswordLengthValid && isPasswordSecure;

  int get passwordStrength {
    if (widget.password == null) return 0;
    if (widget.password!.isEmpty) return 0;
    return [
      isPasswordLengthValid,
      doesPasswordContainLowercase,
      doesPasswordContainUppercase,
      doesPasswordContainSpecialCharacter,
      doesPasswordContainNumber,
    ].where((element) => element).length;
  }

  String _passwordStrengthText(BuildContext context) {
    switch (passwordStrength) {
      case 0:
        return context.strings.passwordStrengthNone;
      case 1:
        return context.strings.passwordStrengthWeak;
      case 2:
        return context.strings.passwordStrengthMedium;
      case 3:
        return context.strings.passwordStrengthStrong;
      case 4:
        return context.strings.passwordStrengthVeryStrong;
      default:
        return context.strings.passwordStrengthNone;
    }
  }

  Color _strengthColor(BuildContext context) {
    if (passwordStrength <= 2) {
      return context.colors.error;
    } else if (passwordStrength == 3) {
      return context.colors.warning;
    } else {
      return context.colors.success;
    }
  }
}
