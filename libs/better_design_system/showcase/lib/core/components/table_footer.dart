import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class AppTableFooter extends StatelessWidget {
  const AppTableFooter({super.key, this.isMobile = false});

  final bool isMobile;

  Widget _buildPaginationButton(
    BuildContext context,
    String text, {
    bool isActive = false,
  }) {
    return SizedBox(
      width: 40,
      child: AppOutlinedButton(
        onPressed: () {},
        text: text,
        size: ButtonSize.medium,
        color: SemanticColor.neutral,
        backgroundColor: isActive ? context.colors.surfaceVariant : null,
      ),
    );
  }

  Widget _buildPaginationButtons(BuildContext context) {
    final spacing = isMobile ? 10.0 : 8.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPaginationButton(context, '1'),
        SizedBox(width: spacing),
        _buildPaginationButton(context, '2', isActive: true),
        SizedBox(width: spacing),
        _buildPaginationButton(context, '3'),
        SizedBox(width: spacing),
        _buildPaginationButton(context, '...'),
        SizedBox(width: spacing),
        _buildPaginationButton(context, '10'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIconButton(
            icon: BetterIcons.arrowLeft01Outline,
            style: IconButtonStyle.outline,
            size: ButtonSize.medium,
          ),
          const SizedBox(width: 20.5),
          _buildPaginationButtons(context),
          const SizedBox(width: 20.5),
          AppIconButton(
            icon: BetterIcons.arrowRight01Outline,
            style: IconButtonStyle.outline,
            size: ButtonSize.medium,
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(
          'Page 2 of 21',
          style: context.textTheme.labelMedium!.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        AppIconButton(
          icon: BetterIcons.arrowLeft01Outline,
          style: IconButtonStyle.outline,
          size: ButtonSize.medium,
        ),
        const SizedBox(width: 16),
        _buildPaginationButtons(context),
        const SizedBox(width: 16),
        AppIconButton(
          icon: BetterIcons.arrowRight01Outline,
          style: IconButtonStyle.outline,
          size: ButtonSize.medium,
        ),
      ],
    );
  }
}
