import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class WarningTextWidget extends StatelessWidget {
  const WarningTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            const Icon(BetterIcons.alert02Filled, color: Color(0xffea740c)),
            const SizedBox(width: 8),
            Text(
              context.tr.warning,
              style: context.textTheme.bodyMedium?.copyWith(
                color: const Color(0xffea740c),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            context.tr.fleetExclusivityAreaWarning,
            maxLines: 2,
            style: context.textTheme.labelMedium?.copyWith(
              color: const Color(0xff637381),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
