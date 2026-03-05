import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';

class DriverAccountingListHeader extends StatelessWidget {
  const DriverAccountingListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: context.tr.driversWallet,
      subtitle: context.tr.listOfAllDriversWallets,
    );
  }
}
