part of 'parking_order_list_screen.dart';

class ParkingOrderListScreenDesktop extends StatelessWidget {
  const ParkingOrderListScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Expanded(child: ParkingOrderListTable()),
      ],
    );
  }
}
