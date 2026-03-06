import 'package:better_design_showcase/features/home/presentation/components/spending_summary.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:flutter/material.dart';
import 'fintech_dashboard_navbar.dart';
import 'fintech_my_cards.dart';

import 'fintech_saved_actions.dart';
import 'fintech_sidebar.dart';
import 'fintech_recent_transactions_table.dart';

class FintechDashboardFourth extends StatelessWidget {
  final Widget? header;
  const FintechDashboardFourth({super.key, this.header});

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
                        child: Column(
                          spacing: 24,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 24,
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    height: 490,
                                    child: FintechMyCards(
                                      style: FintechMyCardsStyle.styleB,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 490,
                                    child: FintechSavedActions(),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 490,
                                    child: AppSpendingSummary(),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: FintechRecentTransactionsTable(),
                                ),
                              ],
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
