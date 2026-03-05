import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class EmailProviderParentScreen extends StatelessWidget {
  const EmailProviderParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
