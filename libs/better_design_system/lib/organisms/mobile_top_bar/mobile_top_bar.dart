import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

enum MobileTopBarChildAlignment { start, center }

typedef BetterMobileTopBar = AppMobileTopBar;

class AppMobileTopBar extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? subtitle;
  final bool isFilled;
  final Function()? onBackPressed;
  final List<Widget> suffixActions;
  final List<Widget> prefixActions;
  final MobileTopBarChildAlignment childAlignment;
  final EdgeInsets padding;

  /// Controls whether the system back navigation is allowed.
  /// When false, the system back button/gesture is intercepted and
  /// [onBackPressed] is called instead.
  /// Defaults to true for backward compatibility.
  final bool canPop;

  const AppMobileTopBar({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.isFilled = false,
    this.onBackPressed,
    this.suffixActions = const [],
    this.prefixActions = const [],
    this.childAlignment = MobileTopBarChildAlignment.center,
    this.padding = const EdgeInsets.all(0),
    this.canPop = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          onBackPressed?.call();
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isFilled ? context.colors.surface : context.colors.transparent,
        ),

        child: Padding(
          padding: padding,
          child: Stack(
            children: [
              if (childAlignment == MobileTopBarChildAlignment.start)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    spacing: 8,
                    children: [
                      if (prefixActions.isNotEmpty || onBackPressed != null)
                        _prefixActions,
                      if (prefixActions.isEmpty && onBackPressed == null)
                        const SizedBox(height: 48),
                      // _prefixActions,
                      if (child != null || title != null)
                        Expanded(child: _child(context)),
                      if (child == null && title == null) const Spacer(),
                    ],
                  ),
                ),
              if (childAlignment == MobileTopBarChildAlignment.center) ...[
                if (child != null || title != null)
                  Positioned.fill(child: Center(child: _child(context))),
                Align(alignment: Alignment.centerLeft, child: _prefixActions),
              ],
              if (suffixActions.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Row(spacing: 8, children: suffixActions),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _prefixActions => Row(
    spacing: 8,
    mainAxisSize: MainAxisSize.min,
    children: [
      if (onBackPressed != null)
        AppIconButton(
          icon: BetterIcons.arrowLeft02Outline,
          style: IconButtonStyle.ghost,
          onPressed: onBackPressed,
        ),
      if (onBackPressed == null && prefixActions.isEmpty)
        const SizedBox(height: 36),
      ...prefixActions,
    ],
  );

  Widget _child(BuildContext context) => child != null
      ? child!
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(title!, style: context.textTheme.titleSmall),
            if (subtitle != null)
              Text(
                subtitle!,
                style: context.textTheme.bodySmall?.variant(context),
              ),
          ],
        );
}
