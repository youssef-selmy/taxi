import 'package:flutter/material.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:better_localization/localizations.dart';

class PaymentGatewaysInsightsPage extends StatelessWidget {
  const PaymentGatewaysInsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      rowGap: 16,
      columnGap: 16,
      columnSizes: [1.fr, 1.fr, 1.fr],
      rowSizes: const [auto, auto],
      children: [
        Container(
          color: Colors.purple,
          child: Center(child: Text(context.tr.header)),
        ).withGridPlacement(columnSpan: 3),
        Container(
          color: Colors.red,
          child: Center(child: Text(context.tr.first)),
        ).withGridPlacement(columnSpan: 1),
        Container(
          color: Colors.green,
          child: Center(child: Text(context.tr.second)),
        ).withGridPlacement(columnSpan: 2),
      ],
    );
  }
}
