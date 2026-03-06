import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_primary.dart';
import '../../sales_and_marketing_sidebar.dart';
import '../components/sales_and_marketing_conversion_card.dart';
import '../components/sales_and_marketing_dashboard_waiting_list_tiny_card.dart';
import '../components/sales_and_marketing_waiting_list_card.dart';
import '../components/sales_and_marketing_wating_list_sales_card.dart';

class SalesAndMarketingDashboardWaitingListScreenDesktop
    extends StatelessWidget {
  final Widget? header;
  const SalesAndMarketingDashboardWaitingListScreenDesktop({
    super.key,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SalesAndMarketingSidebar(
                selectedPage: SalesAndMarketingDashboardPage.waitingList,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: SalesAndMarketingDashboardNavbarPrimary(
                          title: Text(
                            'Waiting List',
                            style: context.textTheme.headlineSmall,
                          ),
                        ),
                      ),
                      AppDivider(),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          spacing: 24,
                          children: [
                            Row(
                              spacing: 24,
                              children: [
                                ...SalesAndMarketingDashboardWaitingListTinyCard
                                    .tinyStatCards
                                    .map((card) => Expanded(child: card)),
                              ],
                            ),
                            Row(
                              spacing: 24,
                              children: [
                                Expanded(
                                  flex: 73,
                                  child: SizedBox(
                                    height: 380,
                                    child:
                                        SalesAndMarketingWaitingListSalesCard(),
                                  ),
                                ),
                                Expanded(
                                  flex: 35,
                                  child: SizedBox(
                                    height: 380,
                                    child: SalesAndMarketingConversionCard(),
                                  ),
                                ),
                              ],
                            ),

                            SalesAndMarketingWaitingListCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
