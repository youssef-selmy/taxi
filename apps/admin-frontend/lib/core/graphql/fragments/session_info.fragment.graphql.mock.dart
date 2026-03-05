import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockSessionInfo1 = Fragment$sessionInfo(
  createdAt: DateTime.now().subtract(Duration(days: 1)),
  lastActivityAt: DateTime.now().subtract(Duration(seconds: 50)),
  appType: Enum$AppType.Parking,
  devicePlatform: Enum$DevicePlatform.MacOS,
  deviceType: Enum$DeviceType.DESKTOP,
  token: 'token1',
);

final mockSessionInfo2 = Fragment$sessionInfo(
  createdAt: DateTime.now().subtract(Duration(days: 2)),
  lastActivityAt: DateTime.now().subtract(Duration(days: 50)),
  appType: Enum$AppType.Parking,
  devicePlatform: Enum$DevicePlatform.Web,
  deviceType: Enum$DeviceType.MOBILE,
  token: 'token2',
);

final mockSessionInfo3 = Fragment$sessionInfo(
  createdAt: DateTime.now().subtract(Duration(days: 3)),
  lastActivityAt: DateTime.now().subtract(Duration(hours: 2)),
  appType: Enum$AppType.Taxi,
  devicePlatform: Enum$DevicePlatform.Android,
  deviceType: Enum$DeviceType.MOBILE,
  token: 'token3',
);
