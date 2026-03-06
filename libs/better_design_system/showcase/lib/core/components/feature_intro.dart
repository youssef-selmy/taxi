import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppFeatureIntro extends StatelessWidget {
  final SvgPicture? icon;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final String title;
  final String description;

  const AppFeatureIntro({
    super.key,
    this.icon,
    this.iconBackgroundColor,
    this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 16,
          children: [
            if (icon != null)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    iconColor ?? context.colors.onSurface,
                    BlendMode.srcIn,
                  ),
                  child: icon,
                ),
              ),

            Text(title, style: context.textTheme.displaySmall),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          description,
          maxLines: 3,
          style: context.textTheme.bodyMedium?.variant(context),
        ),
      ],
    ).animate().slideX(duration: 300.ms, curve: Curves.easeIn);
  }
}
