import 'package:better_design_showcase/features/home/presentation/components/exchange.dart';
import 'package:better_design_showcase/features/home/presentation/components/spending_summary.dart'
    show AppSpendingSummary;
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:flutter/material.dart';

import 'fintech_budget_overview.dart';
import 'fintech_dashboard_navbar.dart';
import 'fintech_my_cards.dart';
import 'fintech_recent_transaction.dart';
import 'fintech_sidebar.dart';

class FintechDashboardFirst extends StatelessWidget {
  final Widget? header;
  const FintechDashboardFirst({super.key, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FintechSidebar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FintechDashboardNavbar(),
                      AppDivider(),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          spacing: 24,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 73,
                              child: Column(
                                spacing: 24,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FintechBudgetOverview(),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 24,
                                    children: [
                                      Expanded(child: AppSpendingSummary()),
                                      Expanded(child: AppExchange()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 36,
                              child: Column(
                                spacing: 24,
                                children: [
                                  FintechMyCards(),
                                  FintechRecentTransaction(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
