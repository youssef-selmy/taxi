import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text(context.tr.home, style: context.textTheme.headlineLarge),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${context.tr.helloTodayIs} ",
              style: context.textTheme.bodyLarge?.variant(context),
            ),
            Text(
              DateFormat(
                context.isDesktop ? 'MMMM d, yyyy' : 'MMM d',
              ).format(DateTime.now()),
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
