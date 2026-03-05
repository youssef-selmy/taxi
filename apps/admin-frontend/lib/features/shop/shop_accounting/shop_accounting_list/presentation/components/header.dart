import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';

class ShopAccountingListHeader extends StatelessWidget {
  const ShopAccountingListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: context.tr.shopsWallet,
      subtitle: context.tr.listOfAllShopsWallets,
    );
  }
}
