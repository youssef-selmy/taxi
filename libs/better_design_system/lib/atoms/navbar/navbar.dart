import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/widgets.dart';
export 'navbar_action_item.dart';

typedef BetterNavbar = AppNavbar;

class AppNavbar extends StatelessWidget {
  const AppNavbar({
    super.key,
    this.actions = const [],
    this.prefix,
    this.suffix,
    this.padding,
    this.showDivider = true,
  });
  final Widget? prefix;
  final List<Widget> actions;
  final Widget? suffix;
  final EdgeInsetsGeometry? padding;
  final bool? showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showDivider == true
            ? Border(
                bottom: BorderSide(color: context.colors.outline, width: 1),
              )
            : null,
      ),
      padding: padding ?? const EdgeInsets.fromLTRB(24, 12, 32, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (prefix != null) prefix!,
              if (actions.isNotEmpty) ...[
                const SizedBox(width: 8),
                ...actions.separated(separator: const SizedBox(width: 6)),
              ],
            ],
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
