import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class DesktopPageContainer extends StatelessWidget {
  final Widget child;

  const DesktopPageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceVariantLow,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 1440),
                padding: EdgeInsets.only(
                  left: context.isDesktop ? 0 : 16,
                  right: context.isDesktop ? 0 : 16,
                  top: 80,
                  bottom: 40,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
