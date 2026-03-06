import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'fintech_budget_overview.dart';
import 'fintech_credit_score_card.dart';
import 'fintech_dashboard_navbar.dart';
import 'fintech_major_expenses_card.dart';
import 'fintech_quick_transfer_card.dart';
import 'fintech_recent_transaction.dart';
import 'fintech_sidebar.dart';
import 'fintech_total_balance_card.dart';
import 'fintech_total_expenses_card.dart';

class FintechDashboardSecond extends StatelessWidget {
  final Widget? header;
  const FintechDashboardSecond({super.key, this.header});

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
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 75,
                              child: Column(
                                spacing: 24,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    spacing: 24,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: FintechTotalBalanceCard(),
                                      ),
                                      Expanded(
                                        child: FintechTotalExpensesCard(),
                                      ),
                                    ],
                                  ),
                                  FintechBudgetOverview(
                                    incomeColor: SemanticColor.error,
                                    expensesColor: SemanticColor.insight,
                                    scheduledColor: SemanticColor.info,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 24,
                                    children: [
                                      Expanded(child: FintechCreditScoreCard()),
                                      Expanded(
                                        child: FintechMajorExpensesCard(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 34,
                              child: Column(
                                spacing: 24,
                                children: [
                                  FintechQuickTransferCard(),
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
