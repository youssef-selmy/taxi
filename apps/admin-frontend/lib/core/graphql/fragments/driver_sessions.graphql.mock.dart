import 'package:admin_frontend/core/graphql/fragments/driver_sessions.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockDriverSessions1 = Fragment$driverSessions(
  id: '1',
  driverId: '1',
  sessionInfo: Fragment$sessionInfo(
    token: '123',
    appType: Enum$AppType.Taxi,
    deviceName: "iPhone 15 Pro Max",
    ipLocation: "Germany, Berlin",
    lastActivityAt: DateTime.now().subtract(const Duration(minutes: 56)),
    devicePlatform: Enum$DevicePlatform.Ios,
    deviceType: Enum$DeviceType.MOBILE,
    createdAt: DateTime.now().subtract(const Duration(days: 24)),
  ),
);

final mockDriverSessions2 = Fragment$driverSessions(
  id: '2',
  driverId: '2',
  sessionInfo: Fragment$sessionInfo(
    token: '123',
    appType: Enum$AppType.Taxi,
    deviceName: "Safari 15, macOS Monterey",
    ipLocation: "Germany, Berlin",
    devicePlatform: Enum$DevicePlatform.Web,
    deviceType: Enum$DeviceType.DESKTOP,
    createdAt: DateTime.now().subtract(const Duration(days: 24)),
    lastActivityAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
);

final mockDriverSessions3 = Fragment$driverSessions(
  id: '2',
  driverId: '2',
  sessionInfo: Fragment$sessionInfo(
    token: '123',
    appType: Enum$AppType.Taxi,
    deviceName: "Samsung Galaxy S21",
    ipLocation: "Germany, Berlin",
    devicePlatform: Enum$DevicePlatform.Android,
    deviceType: Enum$DeviceType.MOBILE,
    createdAt: DateTime.now().subtract(const Duration(days: 45)),
    lastActivityAt: DateTime.now(),
  ),
);

final mockDriverSessionsList = [
  mockDriverSessions1,
  mockDriverSessions2,
  mockDriverSessions3,
];
