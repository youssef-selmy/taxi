part of 'taxi_order_detail_screen.dart';

class TaxiOrderDetailActiveScreenMobile extends StatefulWidget {
  const TaxiOrderDetailActiveScreenMobile({super.key, required this.id});

  final String id;

  @override
  State<TaxiOrderDetailActiveScreenMobile> createState() =>
      _TaxiOrderDetailActiveScreenMobileState();
}

class _TaxiOrderDetailActiveScreenMobileState
    extends State<TaxiOrderDetailActiveScreenMobile>
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
      margin: context.pagePadding,
      color: context.colors.surface,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.orderDetails,
              showBackButton: true,
              onBackButtonPressed: () =>
                  context.router.replace(TaxiOrderListRoute()),
            ),
            const SizedBox(height: 16),
            BlocBuilder<TaxiOrderDetailBloc, TaxiOrderDetailState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const TaxiOrderRideHistories(),
                    const SizedBox(height: 16),
                    const TaxiOrderRideDetailBox(),
                    const SizedBox(height: 16),
                    const TaxiOrderCustomersAndDriverBox(),
                    const SizedBox(height: 16),
                    TaxiOrderDetailTabBar(tabController: _tabController),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 550,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          const TaxiOrderDetailNotesScreen(borderless: true),
                          TaxiOrderDetailTransactionsScreen(
                            taxiOrderId: widget.id,
                          ),
                          TaxiOrderDetailReviwsScreen(taxiOrderId: widget.id),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
