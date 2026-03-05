import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension CancelReasonGQLX on Fragment$cancelReason {
  int get timesUsed {
    return ordersAggregate.firstOrNull?.count?.id ?? 0;
  }
}

extension CancelReasonListGQLX on List<Fragment$cancelReason> {
  List<Fragment$cancelReason> get customerReasons {
    return where(
      (element) => element.userType == Enum$AnnouncementUserType.Rider,
    ).toList();
  }

  List<Fragment$cancelReason> get driverReasons {
    return where(
      (element) => element.userType == Enum$AnnouncementUserType.Driver,
    ).toList();
  }

  List<Fragment$cancelReason> get enabledReasons {
    return where((element) => element.isEnabled).toList();
  }

  int get totalTimesUsed {
    return fold(
      0,
      (previousValue, element) => previousValue + element.timesUsed,
    );
  }
}
