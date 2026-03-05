// import 'package:admin_frontend/core/enums/device_platform_enum.dart';
// import 'package:admin_frontend/core/widgets/session_device/session_device.dart';
// import 'package:flutter/material.dart';

// import 'customer_session.graphql.dart';

// extension FragmentCustomerSessionX on Fragment$customerSession {
//   Widget view(BuildContext context) => SessionDevice(
//         platformName: devicePlatform.name(context),
//         location: ipLocation ?? "",
//         platform: devicePlatform,
//         lastUsed: lastActivityAt,
//       );

//   bool get isOnline =>
//       lastActivityAt != null &&
//       lastActivityAt!.isAfter(
//         DateTime.now().subtract(
//           const Duration(
//             minutes: 5,
//           ),
//         ),
//       );
// }
