part of 'parking_order_detail_screen.dart';

class ParkingOrderDetailScreenDesktop extends StatefulWidget {
  const ParkingOrderDetailScreenDesktop({
    super.key,
    required this.parkingOrderId,
  });

  final String parkingOrderId;

  @override
  State<ParkingOrderDetailScreenDesktop> createState() =>
      _ParkingOrderDetailScreenDesktopState();
}

class _ParkingOrderDetailScreenDesktopState
    extends State<ParkingOrderDetailScreenDesktop>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOrderDetailBloc, ParkingOrderDetailState>(
      builder: (context, state) {
        return Container(
          color: context.colors.surface,
          child: SingleChildScrollView(
            padding: context.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PageHeader(
                  title: context.tr.orderDetails,
                  showBackButton: true,
                ),
                const SizedBox(height: 16),
                Skeletonizer(
                  enabled: state.parkingOrderDetailState.isLoading,
                  enableSwitchAnimation: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      LayoutGrid(
                        columnSizes: context.responsive(
                          [1.fr],
                          lg: [1.fr, 1.fr, 1.fr, 1.fr],
                        ),
                        rowGap: 16,
                        columnGap: 16,
                        rowSizes: const [auto, auto],
                        children: <Widget>[
                          const ParkingOrderDetailBookingDetail()
                              .withGridPlacement(
                                columnSpan: context.responsive(1, lg: 3),
                              ),
                          const ParkingOrderDetailHistories(),
                        ],
                      ),
                      const ParkingOrderDetailCustomerDetail(),
                      const SizedBox(height: 16),
                      ParkingOrderDetailTabBar(tabController: _tabController),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 550,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            const ParkingOrderDetailNotesScreen(),
                            ParkingOrderDetailTransactionScreen(
                              parkingOrderId: widget.parkingOrderId,
                            ),
                            ParkingOrderDetailReviewScreen(
                              parkingOrderId: widget.parkingOrderId,
                            ),
                            ParkingOrderDetailComplaintScreen(
                              parkingOrderId: widget.parkingOrderId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
