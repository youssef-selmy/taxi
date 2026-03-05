import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';

import 'package:admin_frontend/core/components/headers/header_tag.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class LargeHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final HeaderSize size;
  final bool showPointer;
  final Function()? onBackButtonPressed;
  final bool showBackButton;
  final int? counter;

  const LargeHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions = const [],
    this.size = HeaderSize.normal,
    this.counter,
    @Deprecated('No Longer used') this.showPointer = true,
    this.onBackButtonPressed,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) {
        if (onBackButtonPressed != null) {
          onBackButtonPressed!();
        } else {
          context.router.back();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showBackButton) ...[
                AppIconButton(
                  onPressed:
                      onBackButtonPressed ??
                      () {
                        context.router.back();
                      },
                  icon: BetterIcons.arrowLeft01Outline,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Row(
                  children: [
                    Text(title, style: titleStyle(context)),
                    if (counter != null) ...[
                      const SizedBox(width: 8),
                      HeaderTag(text: counter.toString()),
                    ],
                    Spacer(),
                  ],
                ),
              ),
              ...actions.map(
                (e) =>
                    Padding(padding: const EdgeInsets.only(left: 8), child: e),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ],
      ),
    );
  }

  double get pointerHeight => switch (size) {
    HeaderSize.small => 8,
    HeaderSize.normal => 16,
    HeaderSize.large => 40,
  };

  double get pointerWidth => switch (size) {
    HeaderSize.small => 4,
    HeaderSize.normal => 6,
    HeaderSize.large => 8,
  };

  TextStyle titleStyle(BuildContext context) => switch (size) {
    HeaderSize.small => context.textTheme.labelMedium,
    HeaderSize.normal => context.textTheme.labelLarge,
    HeaderSize.large => context.textTheme.headlineSmall,
  }!;
}

enum HeaderSize { small, normal, large }
