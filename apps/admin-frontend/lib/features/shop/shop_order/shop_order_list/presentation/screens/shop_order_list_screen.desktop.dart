part of 'shop_order_list_screen.dart';

class ShopOrderListScreenDesktop extends StatelessWidget {
  const ShopOrderListScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.pagePadding,
      color: context.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: context.tr.orders,
            subtitle: context.tr.listOfShopOrders,
          ),
          const SizedBox(height: 16),
          const ShopOrderListStatisticsBox(),
          const SizedBox(height: 32),
          const ShopOrderListTabBar(),
          const SizedBox(height: 16),
          const Expanded(child: ShopOrderListTable()),
        ],
      ),
    );
  }
}
