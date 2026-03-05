import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/text_button.dart';

import 'package:admin_frontend/core/enums/device_platform_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

class SessionDevice extends StatelessWidget {
  final DateTime? lastUsed;
  final String platformName;
  final String location;
  final Enum$DevicePlatform platform;
  final bool canBeTerminated;
  final Function() onTerminate;

  const SessionDevice({
    super.key,
    required this.lastUsed,
    required this.platformName,
    required this.location,
    required this.platform,
    this.canBeTerminated = true,
    required this.onTerminate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Icon(platform.icon, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(platformName, style: context.textTheme.labelMedium),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),
                ),
                if (!isOnline()) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        lastUsed?.toTimeAgo ?? context.tr.never,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lastUsed?.formatDateTime ?? "",
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),
                ],
                if (isOnline()) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        context.tr.online,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            if (canBeTerminated) ...[
              const SizedBox(height: 8),
              AppTextButton(
                onPressed: onTerminate,
                text: context.tr.terminateSession,
                color: SemanticColor.error,
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool isOnline() {
    return lastUsed != null &&
        lastUsed!.isAfter(DateTime.now().subtract(const Duration(minutes: 5)));
  }
}
