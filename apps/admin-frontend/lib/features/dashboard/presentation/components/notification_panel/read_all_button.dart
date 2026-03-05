import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class ReadAllButton extends StatelessWidget {
  const ReadAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      minimumSize: Size(0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(context.tr.readAll, style: context.textTheme.labelMedium),
          const SizedBox(width: 8),
          const Icon(BetterIcons.checkmarkCircle02Outline, size: 20),
        ],
      ),
    );
  }
}
