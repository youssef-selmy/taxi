import 'package:flutter/material.dart';

import '_shared/navbar_common_widgets.dart';

/// Primary navigation bar for the first 4 Sales & Marketing dashboards.
///
/// This navbar includes:
/// - Menu icon (mobile only)
/// - Dynamic title widget
/// - Search field (desktop only)
/// - Filter button
/// - Notification button
/// - Profile button
///
/// Example:
/// ```dart
/// SalesAndMarketingDashboardNavbarPrimary(
///   title: Text('Sales Dashboard'),
///   isMobile: context.isMobile,
/// )
/// ```
class SalesAndMarketingDashboardNavbarPrimary extends StatelessWidget {
  /// The title widget displayed in the navbar.
  final Widget title;

  /// Whether the navbar is displayed in mobile mode.
  /// In mobile mode, the menu icon is shown and search field is hidden.
  final bool isMobile;

  /// Creates a [SalesAndMarketingDashboardNavbarPrimary].
  const SalesAndMarketingDashboardNavbarPrimary({
    super.key,
    required this.title,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: !isMobile ? 12 : 8,
      children: [
        if (isMobile) SalesAndMarketingNavbarMenuButton(),
        title,
        const Spacer(),
        if (!isMobile) const SalesAndMarketingNavbarSearchField(),
        const SalesAndMarketingNavbarFilterButton(),
        const SalesAndMarketingNavbarNotificationButton(),

        Row(
          children: [
            if (!isMobile) SizedBox(width: 4),
            const SalesAndMarketingNavbarProfileButton(),
          ],
        ),
      ],
    );
  }
}
