import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'status_badge_size.dart';
import 'status_badge_type.dart';

/// A widget representing a status badge with different types (online, offline, etc.).
///
/// This [AppStatusBadge] widget can represent various statuses such as 'online', 'offline',
/// 'away', and 'busy', with custom sizes for each type.
typedef BetterStatusBadge = AppStatusBadge;

class AppStatusBadge extends StatelessWidget {
  /// The type of status to be displayed on the badge.
  /// Defaults to [StatusBadgeType.online].
  final StatusBadgeType statusBadgeType;

  /// The size of the status badge.
  /// Defaults to [StatusBadgeSize.medium].
  final StatusBadgeSize statusBadgeSize;

  /// Creates a [AppStatusBadge].
  ///
  /// The [statusBadgeType] and [statusBadgeSize] are optional parameters with default values.
  const AppStatusBadge({
    super.key,
    this.statusBadgeType = StatusBadgeType.online,
    this.statusBadgeSize = StatusBadgeSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: statusBadgeSize.value, // Badge width based on the size.
      height: statusBadgeSize.value, // Badge height based on the size.
      decoration: BoxDecoration(
        color: _getBackgroundColor(
          context,
        ), // Background color based on the status.
        shape: BoxShape.circle, // The badge is a circle.
        border: statusBadgeType == StatusBadgeType.offline
            ? Border.all(
                width: 2,
                color: context
                    .colors
                    .onSurfaceVariantLow, // Border color for offline status.
              )
            : null, // No border for other status types.
      ),
      child: Padding(
        padding: _getIconPadding(),
        child: _getIcon(context),
      ), // Centering the icon based on the status.
    );
  }

  /// Returns the background color of the badge based on its status.
  ///
  /// Uses [SemanticColor] utility to retrieve the corresponding color for each status type.
  Color _getBackgroundColor(BuildContext context) {
    switch (statusBadgeType) {
      case StatusBadgeType.busy:
        return SemanticColor.error.main(context);
      case StatusBadgeType.away:
        return SemanticColor.warning.main(context);
      case StatusBadgeType.online:
        return SemanticColor.success.main(context);
      case StatusBadgeType.offline:
        return context.colors.surface;
      case StatusBadgeType.none:
        return context.colors.transparent;
    }
  }

  /// Returns the icon to be displayed inside the badge based on its status type.
  ///
  /// Different icons are shown for each status type (e.g., a clock for 'away', a line for 'busy').
  Widget _getIcon(BuildContext context) {
    switch (statusBadgeType) {
      case StatusBadgeType.busy:
        return Assets.images.shapes.underline.svg(
          colorFilter: ColorFilter.mode(
            context.colors.surface, // Color icon with the surface color.
            BlendMode.srcIn,
          ),
        );
      case StatusBadgeType.away:
        return Assets.images.shapes.clock.svg(
          colorFilter: ColorFilter.mode(
            context.colors.surface, // Color icon with the surface color.
            BlendMode.srcIn,
          ),
        );
      case StatusBadgeType.online:
        return const SizedBox(); // No icon for 'online' status.
      case StatusBadgeType.offline:
        return const SizedBox(); // No icon for 'offline' status.

      case StatusBadgeType.none:
        return const SizedBox(); // No icon for 'offline' status.
    }
  }

  /// This method ensures the icon size adjusts proportionally with the badge size.
  EdgeInsetsGeometry _getIconPadding() {
    switch (statusBadgeSize) {
      case StatusBadgeSize.extraSmall:
        return const EdgeInsets.symmetric(vertical: 1.4, horizontal: 1.4);
      case StatusBadgeSize.small:
        return const EdgeInsets.symmetric(vertical: 2.3, horizontal: 1.3);
      case StatusBadgeSize.regularSmall:
        return const EdgeInsets.symmetric(vertical: 3.2, horizontal: 2);
      case StatusBadgeSize.medium:
        return const EdgeInsets.symmetric(vertical: 4, horizontal: 2.4);
      case StatusBadgeSize.large:
        return const EdgeInsets.symmetric(vertical: 4.5, horizontal: 2.8);
    }
  }
}
