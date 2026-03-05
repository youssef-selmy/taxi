import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';

extension ShopPayoutSessionDetailX on Fragment$shopPayoutSessionDetail {
  int get shops => shopsCount.fold<int>(
    0,
    (previousValue, element) => previousValue + (element.count?.id ?? 0),
  );

  double get shopsPaid => paidShops.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );

  double get shopsPending => unpaidShops.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );

  double get totalAmount => shopsPaid + shopsPending;
}

extension DriverPayoutSessionPayoutMethodDetailX
    on Fragment$shopPayoutSessionPayoutMethodDetail {
  int get totalUsers => statistics.fold<int>(
    0,
    (previousValue, element) => previousValue + (element.count?.id ?? 0),
  );

  double get totalAmount => statistics.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );
}
