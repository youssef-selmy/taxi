import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.dart';

extension TaxiPayoutSessionDetailX on Fragment$taxiPayoutSessionDetail {
  int get drivers => driversCount.fold<int>(
    0,
    (previousValue, element) => previousValue + (element.count?.id ?? 0),
  );
  // int get shops => shopsCount.fold<int>(0, (previousValue, element) => previousValue + (element.count?.id ?? 0));
  // int get parkings => parkingsCount.fold<int>(0, (previousValue, element) => previousValue + (element.count?.id ?? 0));

  int get totalUsersCount => drivers;

  double get driversPaid => paidDrivers.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );

  // double get shopsPaid =>
  //     paidShops.fold<double>(0, (previousValue, element) => previousValue + (element.sum?.amount ?? 0));

  // double get parkingsPaid =>
  //     paidParkings.fold<double>(0, (previousValue, element) => previousValue + (element.sum?.amount ?? 0));

  double get totalPaid => driversPaid;

  double get driversPending => unpaidDrivers.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );

  // double get shopsPending =>
  //     unpaidShops.fold<double>(0, (previousValue, element) => previousValue + (element.sum?.amount ?? 0));

  // double get parkingsPending =>
  //     unpaidParkings.fold<double>(0, (previousValue, element) => previousValue + (element.sum?.amount ?? 0));

  double get totalPending => driversPending;

  double get totalAmount => totalPaid + totalPending;
}

extension DriverPayoutSessionPayoutMethodDetailX
    on Fragment$taxiPayoutSessionPayoutMethodDetail {
  int get totalUsers => statistics.fold<int>(
    0,
    (previousValue, element) => previousValue + (element.count?.id ?? 0),
  );

  double get totalAmount => statistics.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );
}
