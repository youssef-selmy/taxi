part of 'shop_order_list_screen.dart';

class ShopOrderListScreenMobile extends StatelessWidget {
  const ShopOrderListScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.pagePadding,
      color: context.colors.surface,
      child: SingleChildScrollView(
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
            const SizedBox(height: 550, child: ShopOrderListTable()),
          ],
        ),
      ),
    );
  }
}
