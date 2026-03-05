part of 'taxi_order_list_screen.dart';

class TaxiOrderListScreenDesktop extends StatelessWidget {
  const TaxiOrderListScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrdersListBloc, TaxiOrdersListState>(
      builder: (context, state) {
        return Container(
          color: context.colors.surface,
          child: SingleChildScrollView(
            padding: context.pagePadding,
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageHeader(
                    title: "Order Tracker",
                    subtitle: "Live order tracker for active orders",
                  ),
                  const SizedBox(height: 24),
                  TaxiActiveOrderSummaryDesktop(),
                  const SizedBox(height: 24),
                  TaxiActiveOrdersTable(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
