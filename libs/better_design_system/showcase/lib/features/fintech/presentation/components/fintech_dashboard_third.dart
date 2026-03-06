import 'package:better_design_showcase/features/home/presentation/components/exchange.dart';
import 'package:better_design_showcase/features/home/presentation/components/spending_summary.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:flutter/material.dart';
import 'fintech_credit_score_card.dart';
import 'fintech_dashboard_navbar.dart';
import 'fintech_my_cards.dart';
import 'fintech_my_subscriptions_card.dart';
import 'fintech_recent_transaction.dart';
import 'fintech_sidebar.dart';
import 'fintech_total_expenses_card.dart';

class FintechDashboardThird extends StatelessWidget {
  final Widget? header;
  const FintechDashboardThird({super.key, this.header});

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 24,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: FintechMyCards(
                                          style: FintechMyCardsStyle.styleB,
                                        ),
                                      ),
                                      Expanded(child: AppSpendingSummary()),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 24,
                                    children: [
                                      Expanded(
                                        child: FintechRecentTransaction(
                                          recentTracsactionTabs: [
                                            'Incoming',
                                            'Outgoing',
                                            'Pending',
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: FintechMySubscriptionsCard(),
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
                                  FintechTotalExpensesCard(
                                    style: FintechTotalExpensesStyle.styleB,
                                  ),
                                  FintechCreditScoreCard(),
                                  AppExchange(),
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
