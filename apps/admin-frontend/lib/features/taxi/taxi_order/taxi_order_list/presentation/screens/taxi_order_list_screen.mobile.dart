part of 'taxi_order_list_screen.dart';

class TaxiOrderListScreenMobile extends StatelessWidget {
  const TaxiOrderListScreenMobile({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrdersListBloc, TaxiOrdersListState>(
      builder: (context, state) {
        return Container(
          margin: context.pagePadding,
          color: context.colors.surface,
          child: AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageHeader(
                    title: context.tr.orders,
                    subtitle: context.tr.listOfAllTaxiOrders,
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 650, child: TaxiActiveOrdersTable()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
