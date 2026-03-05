import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  final bool disableBottomPadding;

  const PageContainer({
    super.key,
    required this.child,
    this.disableBottomPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        padding: context.pagePadding.copyWith(
          bottom: disableBottomPadding ? 0 : context.pagePadding.bottom,
        ),
        color: context.colors.surface,
        child: child,
      ),
    );
  }
}
