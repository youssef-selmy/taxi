import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/breadcrumb/breadcrumb.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppBreadcrumbHeader extends StatelessWidget {
  final String previousTitle;
  final String currentTitle;
  const AppBreadcrumbHeader({
    super.key,
    required this.currentTitle,
    required this.previousTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIconButton(
          icon: BetterIcons.arrowLeft02Outline,
          onPressed: () {
            context.router.pop();
          },
          size: ButtonSize.small,
        ),
        const SizedBox(width: 8),
        AppBreadcrumb(
          items: List<BreadcrumbOption>.of([
            BreadcrumbOption(title: previousTitle, value: 1, icon: null),
            BreadcrumbOption(title: currentTitle, value: 2, icon: null),
          ]),
          style: BreadcrumbStyle.ghost,
          separator: BreadcrumbSeparator.arrow,
          onPressed: (value) {
            if (value == 1) {
              context.router.pop();
            }
          },
        ),
      ],
    ).animate().slideX(duration: 300.ms, curve: Curves.easeIn);
  }
}
