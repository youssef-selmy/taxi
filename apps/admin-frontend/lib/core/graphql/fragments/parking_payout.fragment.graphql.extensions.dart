import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.dart';

extension ParkingPayoutSessionDetailX on Fragment$parkingPayoutSessionDetail {
  int get parkings => parkingCount.fold<int>(
    0,
    (previousValue, element) => previousValue + (element.count?.id ?? 0),
  );

  double get parkingsPaid => paidParkings.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );

  double get parkingsPending => unpaidParkings.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );

  double get totalAmount => parkingsPaid + parkingsPending;
}

extension ParkingPayoutSessionPayoutMethodDetailX
    on Fragment$parkingPayoutSessionPayoutMethodDetail {
  int get totalUsers => statistics.fold<int>(
    0,
    (previousValue, element) => previousValue + (element.count?.id ?? 0),
  );

  double get totalAmount => statistics.fold<double>(
    0,
    (previousValue, element) => previousValue + (element.sum?.amount ?? 0),
  );
}
