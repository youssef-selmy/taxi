import 'package:admin_frontend/build_info.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CopyrightNotice extends StatelessWidget {
  const CopyrightNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "© 2018–2025 Lume Agency. All rights reserved.",
          style: context.textTheme.labelSmall?.variantLow(context),
        ),
        const SizedBox(height: 8),
        FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) => Text(
            "v${snapshot.hasData ? snapshot.data?.version : '1.0.0'} (Built ${buildTime.toTimeAgo})",
            style: context.textTheme.labelSmall?.variantLow(context),
          ),
        ),
        const SizedBox(height: 8),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              launchUrlString("https://bettersuite.io");
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Powered by ",
                    style: context.textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: "BetterSuite",
                    style: context.textTheme.labelMedium?.apply(
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ),
        ),
      ],
    );
  }
}
