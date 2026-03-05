import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/customer_status_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomerStatusView extends StatelessWidget {
  final Enum$RiderStatus status;

  const CustomerStatusView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Text(
      status.text(context),
      style: context.textTheme.labelMedium?.copyWith(
        color: _color(context),
        letterSpacing: 0.2,
      ),
    );
  }

  Color _color(BuildContext context) {
    switch (status) {
      case Enum$RiderStatus.Enabled:
        return context.colors.primary;
      case Enum$RiderStatus.Disabled:
        return context.colors.error;
      default:
        return context.colors.onSurfaceVariant;
    }
  }
}
