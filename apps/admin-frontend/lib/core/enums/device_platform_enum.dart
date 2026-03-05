import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension DevicePlatformEnumExtension on Enum$DevicePlatform {
  String name(BuildContext context) {
    switch (this) {
      case Enum$DevicePlatform.Android:
        return "Android";
      case Enum$DevicePlatform.Ios:
        return "iOS";
      case Enum$DevicePlatform.Web:
        return context.tr.web;
      case Enum$DevicePlatform.MacOS:
        return "macOS";
      case Enum$DevicePlatform.Windows:
        return "Windows";
      case Enum$DevicePlatform.Linux:
        return "Linux";
      default:
        return context.tr.unknown;
    }
  }

  Color get color {
    switch (this) {
      case Enum$DevicePlatform.Android:
        return const Color(0xFFFFC300);
      case Enum$DevicePlatform.Ios:
        return const Color(0xFFE80054);
      case Enum$DevicePlatform.Web:
        return const Color(0xFF00D5FF);
      case Enum$DevicePlatform.MacOS:
        return const Color(0xFF4A90E2);
      case Enum$DevicePlatform.Windows:
        return const Color(0xFF0078D4);
      case Enum$DevicePlatform.Linux:
        return const Color(0xFF61BD4F);
      default:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (this) {
      case Enum$DevicePlatform.Android:
        return BetterIcons.smartPhone01Filled;
      case Enum$DevicePlatform.Ios:
        return BetterIcons.smartPhone01Filled;
      case Enum$DevicePlatform.Web:
        return BetterIcons.computerFilled;
      case Enum$DevicePlatform.MacOS:
        return Icons.desktop_mac;
      case Enum$DevicePlatform.Windows:
        return Icons.desktop_windows;
      case Enum$DevicePlatform.Linux:
        return Icons.laptop;
      default:
        return Icons.device_unknown;
    }
  }
}
