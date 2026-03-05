import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/pie_chart_thin.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class WalletBalanceCard extends StatelessWidget {
  final Widget? header;
  final ApiResponse<List<WalletBalanceItem>> items;

  const WalletBalanceCard({super.key, required this.items, this.header});

  @override
  Widget build(BuildContext context) {
    return switch (items) {
      ApiResponseInitial() => const SizedBox.shrink(),
      ApiResponseError(:final message) => Center(child: Text(message)),
      ApiResponseLoading() || ApiResponseLoaded() => Skeletonizer(
        enabled: items.isLoading,
        enableSwitchAnimation: true,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (header != null) ...[header!, const SizedBox(height: 16)],
                if (header == null) ...[
                  Text(
                    context.tr.walletSummary,
                    style: context.textTheme.bodyMedium?.variant(context),
                  ),
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  height: 200,
                  child: Row(
                    children: [
                      PieChartThin(data: items.data?.toChartSeriesData() ?? []),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:
                              (items.data ??
                                      [
                                        WalletBalanceItem(
                                          currency: "USD",
                                          balance: 0,
                                        ),
                                        WalletBalanceItem(
                                          currency: "EUR",
                                          balance: 0,
                                        ),
                                        WalletBalanceItem(
                                          currency: "GBP",
                                          balance: 0,
                                        ),
                                      ])
                                  .mapIndexed(
                                    (index, item) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              pieChartThinColors[index %
                                                      pieChartThinColors.length]
                                                  .withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 8),
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color:
                                                    pieChartThinColors[index %
                                                        pieChartThinColors
                                                            .length],
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8,
                                                ),
                                                child: Text(
                                                  item.currency,
                                                  style: context
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                item.balance.formatCurrency(
                                                  item.currency,
                                                ),
                                                style: context
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    };
  }
}
