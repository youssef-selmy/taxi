import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';

class ParkingAccountingListHeader extends StatelessWidget {
  const ParkingAccountingListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: context.tr.parkingsWallet,
      subtitle: context.tr.listOfAllParkingsWallets,
    );
  }
}
