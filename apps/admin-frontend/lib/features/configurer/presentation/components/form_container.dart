import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class FormContainer extends StatelessWidget {
  final Widget child;

  const FormContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.isDesktop ? 40 : 16,
        left: context.isDesktop ? 24 : 16,
        right: context.isDesktop ? 24 : 16,
        bottom: context.isDesktop ? 24 : 16,
      ),
      child: child,
    );
  }
}
