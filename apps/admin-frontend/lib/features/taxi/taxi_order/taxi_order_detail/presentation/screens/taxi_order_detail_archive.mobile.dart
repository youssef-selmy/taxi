part of 'taxi_order_detail_screen.dart';

class TaxiOrderDetailArchiveScreenMobile extends StatefulWidget {
  const TaxiOrderDetailArchiveScreenMobile({super.key, required this.id});

  final String id;

  @override
  State<TaxiOrderDetailArchiveScreenMobile> createState() =>
      _TaxiOrderDetailArchiveScreenMobileState();
}

class _TaxiOrderDetailArchiveScreenMobileState
    extends State<TaxiOrderDetailArchiveScreenMobile>
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
                  context.router.replace(TaxiOrderArchiveListRoute()),
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
                          const TaxiOrderDetailNotesScreen(),
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
