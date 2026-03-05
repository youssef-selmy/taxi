part of 'parking_order_list_screen.dart';

class ParkingOrderListScreenMobile extends StatelessWidget {
  const ParkingOrderListScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: context.tr.orders,
            subtitle: context.tr.parkingOrdersList,
          ),
          const SizedBox(height: 16),
          const ParkingOrderLiStstatisticsBox(),
          const SizedBox(height: 32),
          const ParkingOrderListTabBar(),
          const SizedBox(height: 16),
          SafeArea(
            top: false,
            child: const SizedBox(height: 550, child: ParkingOrderListTable()),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
