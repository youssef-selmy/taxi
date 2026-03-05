part of 'shop_order_detail_screen.dart';

class ShopOrderDetailScreenMobile extends StatefulWidget {
  const ShopOrderDetailScreenMobile({super.key, required this.shopOrderId});

  final String shopOrderId;

  @override
  State<ShopOrderDetailScreenMobile> createState() =>
      _ShopOrderDetailScreenMobileState();
}

class _ShopOrderDetailScreenMobileState
    extends State<ShopOrderDetailScreenMobile>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        return Container(
          margin: context.pagePadding,
          color: context.colors.surface,
          child: SingleChildScrollView(
            child: Skeletonizer(
              enabled: state.shopOrderDetailState.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const PageHeader(
                    title: 'Order Details',
                    showBackButton: true,
                  ),
                  const SizedBox(height: 16),
                  Column(
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
                        children: const <Widget>[
                          ShopOrderDetailHistoryBox(),
                          ShopOrderDetailItem(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const ShopOrderDetailCustomerAndShopDetailBox(),
                      const SizedBox(height: 16),
                      ShopOrderDetailTabBar(tabController: _tabController),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 550,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            const ShopOrderDetailNotesScreen(),
                            ShopOrderDetailTransactionsScreen(
                              orderId: widget.shopOrderId,
                            ),
                            ShopOrderDetailReviewsScreen(
                              shopOrderId: widget.shopOrderId,
                            ),
                            ShopOrderDetailComplaintsScreen(
                              shopOrderId: widget.shopOrderId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
