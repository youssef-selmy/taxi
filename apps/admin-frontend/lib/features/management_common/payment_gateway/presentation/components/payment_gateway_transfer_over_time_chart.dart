import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';

class PaymentGatewayTransferOverTimeChart extends StatelessWidget {
  const PaymentGatewayTransferOverTimeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: context.tr.transferOverTime,
      subtitle: context.tr.totalTransferAmountOverTime,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: const Text("Chart Here"),
      ),
    );
  }
}
