import 'package:admin_frontend/core/components/charts/chart_series_data.dart';

class WalletBalanceItem {
  final String currency;
  final double balance;

  WalletBalanceItem({required this.currency, required this.balance});
}

extension ListWalletBalanceX on List<WalletBalanceItem> {
  List<ChartSeriesData> toChartSeriesData() {
    return map(
      (e) => ChartSeriesData(name: e.currency, value: e.balance),
    ).toList();
  }
}
