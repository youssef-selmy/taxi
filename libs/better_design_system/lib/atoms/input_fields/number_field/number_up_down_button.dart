import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

class NumberUpDownButton extends StatelessWidget {
  final Function() onUp;
  final Function() onDown;

  const NumberUpDownButton({
    super.key,
    required this.onUp,
    required this.onDown,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: onUp,
          minimumSize: const Size(0, 0),
          child: Icon(
            BetterIcons.arrowUp01Outline,
            size: 12,
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: onDown,
          minimumSize: const Size(0, 0),
          child: Icon(
            BetterIcons.arrowDown01Outline,
            size: 12,
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
