part of 'taxi_order_detail_screen.dart';

class TaxiOrderDetailArchiveScreenDesktop extends StatefulWidget {
  final String id;

  const TaxiOrderDetailArchiveScreenDesktop({super.key, required this.id});

  @override
  State<TaxiOrderDetailArchiveScreenDesktop> createState() =>
      _TaxiOrderDetailArchiveScreenDesktopState();
}

class _TaxiOrderDetailArchiveScreenDesktopState
    extends State<TaxiOrderDetailArchiveScreenDesktop>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      child: SingleChildScrollView(
        padding: context.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            PageHeader(
              title: context.tr.orderDetails,
              showBackButton: true,
              onBackButtonPressed: () =>
                  context.router.replace(TaxiOrderArchiveListRoute()),
            ),
            TaxiOrderRideHistories(),
            Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    spacing: 16,
                    children: [
                      TaxiOrderRideDetailBox(),
                      const TaxiOrderCustomersAndDriverBox(),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(height: 600, child: TaxiOrderRideDetailMap()),
                ),
              ],
            ),
            TaxiOrderDetailTabBar(tabController: _tabController),
            SizedBox(
              height: 600,
              child: TabBarView(
                controller: _tabController,
                children: [
                  TaxiOrderDetailNotesScreen(),
                  TaxiOrderDetailTransactionsScreen(taxiOrderId: widget.id),
                  TaxiOrderDetailReviwsScreen(taxiOrderId: widget.id),
                  TaxiOrderDetailComplaintsScreen(taxiOrderId: widget.id),
                  TaxiOrderDetailChatHistoriesScreen(taxiOrderId: widget.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
