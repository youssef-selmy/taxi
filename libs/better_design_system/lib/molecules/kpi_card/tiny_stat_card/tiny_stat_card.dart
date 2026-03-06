import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

typedef BetterTinyStatCard = AppTinyStatCard;

class AppTinyStatCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final SemanticColor iconColor;
  const AppTinyStatCard({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = SemanticColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.outline, width: 1),
      ),
      child: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor.main(context), size: 24),
          Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
