import 'package:better_design_system/theme/theme.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

typedef BetterThemeItem = AppThemeItem;

class AppThemeItem extends StatelessWidget {
  final BetterThemes theme;
  final Function() onPressed;
  final bool isSelected;

  const AppThemeItem({
    super.key,
    required this.theme,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 0),
      onPressed: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(56),
          color: _backgroundColor(context),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BetterTheme.fromBetterTheme(
                  theme,
                  context.isDesktop,
                  context.isDark,
                ).primaryColor,
              ),
              child: isSelected
                  ? Icon(
                      BetterIcons.checkmarkCircle02Filled,
                      color: context.colors.onPrimary,
                      size: 20,
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(theme.name, style: context.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }

  Color _backgroundColor(BuildContext context) {
    if (isSelected) {
      return context.colors.primaryVariantLow;
    }
    return context.colors.surfaceVariantLow;
  }
}
