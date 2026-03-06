import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/table/components/table_customers_card.dart';
import 'package:better_design_showcase/features/table/components/table_transaction_records_card.dart';
import 'package:better_design_showcase/features/table/components/table_transactions_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(currentTitle: 'Table', previousTitle: 'Blocks'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Table',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1603,
                maxHeight: 840,
                title: 'Transactions Card',
                desktopSourceCode: 'blocks/table/table_transactions_card.txt',
                desktopWidget: const TableTransactionsCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1603,
                maxHeight: 840,
                title: 'Customers Card',
                desktopSourceCode: 'blocks/table/table_customers_card.txt',
                desktopWidget: const TableCustomersCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1603,
                maxHeight: 828,
                title: 'Transaction Records Card',
                desktopSourceCode:
                    'blocks/table/table_transaction_records_card.txt',
                desktopWidget: const TableTransactionRecordsCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
