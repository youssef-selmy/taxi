import 'package:flutter/material.dart';

import '_shared/navbar_common_widgets.dart';

/// Secondary navigation bar for the next 4 Sales & Marketing dashboards.
///
/// This navbar differs from the primary navbar by:
/// - Removing the filter button
/// - Adding two additional action buttons
/// - In mobile mode: displaying the two action buttons below the navbar
///
/// Example:
/// ```dart
/// SalesAndMarketingDashboardNavbarSecondary(
///   title: Text('Analytics Dashboard'),
///   isMobile: context.isMobile,
///   actionButton1: AppButton(text: 'Export'),
///   actionButton2: AppButton(text: 'Share'),
/// )
/// ```
class SalesAndMarketingDashboardNavbarSecondary extends StatelessWidget {
  /// The title widget displayed in the navbar.
  final Widget title;

  /// Whether the navbar is displayed in mobile mode.
  /// In mobile mode, action buttons are displayed below the navbar.
  final bool isMobile;

  /// Creates a [SalesAndMarketingDashboardNavbarSecondary].
  const SalesAndMarketingDashboardNavbarSecondary({
    super.key,
    required this.title,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: isMobile ? 16 : 0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          spacing: !isMobile ? 12 : 8,
          children: [
            if (isMobile) const SalesAndMarketingNavbarMenuButton(),
            title,
            const Spacer(),
            if (!isMobile) const SalesAndMarketingNavbarSearchField(),

            if (!isMobile) ...[
              SalesAndMarketingCalendarDropdown(),
              SalesAndMarketingSalesDropdown(),
            ],

            if (isMobile) SalesAndMarketingSearchButton(),

            const SalesAndMarketingNavbarNotificationButton(),
            const SalesAndMarketingNavbarProfileButton(),
          ],
        ),

        if (isMobile)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 12,
            children: [
              SalesAndMarketingCalendarDropdown(),
              SalesAndMarketingSalesDropdown(),
            ],
          ),
      ],
    );
  }
}
