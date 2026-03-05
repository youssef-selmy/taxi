part of 'taxi_order_detail_screen.dart';

class TaxiOrderDetailActiveScreenDesktop extends StatefulWidget {
  final String id;

  const TaxiOrderDetailActiveScreenDesktop({super.key, required this.id});

  @override
  State<TaxiOrderDetailActiveScreenDesktop> createState() =>
      _TaxiOrderDetailActiveScreenDesktopState();
}

class _TaxiOrderDetailActiveScreenDesktopState
    extends State<TaxiOrderDetailActiveScreenDesktop>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
            child: PageHeader(
              title: context.tr.orderDetails,
              showBackButton: true,
              onBackButtonPressed: () =>
                  context.router.replace(TaxiOrderListRoute()),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    child: TaxiOrderRideDetailMap(
                      padding: EdgeInsets.only(
                        left: 500,
                        top: 100,
                        bottom: 100,
                        right: 100,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 500,
                    padding: const EdgeInsets.only(
                      left: 44,
                      right: 44,
                      top: 48,
                      bottom: 48,
                    ),
                    child: AppClickableCard(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SingleChildScrollView(
                            padding: EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            child: TaxiOrderDetailTabBar(
                              tabController: _tabController,
                              hasDetailsTab: true,
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 16,
                                    children: [
                                      TaxiOrderRideDetailBox(borderless: true),
                                      const TaxiOrderCustomersAndDriverBox(
                                        borderLess: true,
                                      ),
                                    ],
                                  ),
                                ),
                                TaxiOrderDetailNotesScreen(borderless: true),
                                TaxiOrderDetailTransactionsScreen(
                                  taxiOrderId: widget.id,
                                ),
                                TaxiOrderDetailReviwsScreen(
                                  taxiOrderId: widget.id,
                                ),
                                TaxiOrderDetailComplaintsScreen(
                                  taxiOrderId: widget.id,
                                ),
                                TaxiOrderDetailChatHistoriesScreen(
                                  taxiOrderId: widget.id,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
