import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BlocksHeader extends StatelessWidget {
  const BlocksHeader({super.key, this.onSearchChanged});

  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border.all(color: context.colors.outline),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                'Components & Blocks',
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
            SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 484),
              child: Text(
                'Building Blocks For Your Applications',
                style:
                    context.isDesktop
                        ? context.textTheme.displayLarge
                        : context.textTheme.displayMedium,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 484),
              child: Text(
                'Explore a variety of pre-designed components and blocks to accelerate your development process.',
                style: context.textTheme.bodyMedium?.variant(context),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ).animate().fade(delay: 300.ms).slideY(curve: Curves.easeIn, begin: -0.5),

        SizedBox(height: context.isDesktop ? 32 : 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: AppTextField(
                density: TextFieldDensity.dense,
                hint: 'Search',
                onChanged: onSearchChanged,
                prefixIcon: Icon(
                  BetterIcons.search01Filled,
                  color: context.colors.onSurfaceVariant,
                  size: 20,
                ),
              )
              .animate()
              .fade(delay: 300.ms)
              .slideY(curve: Curves.easeIn, begin: 0.5),
        ),
        SizedBox(height: context.isDesktop ? 48 : 24),
      ],
    );
  }
}
