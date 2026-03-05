part of 'taxi_order_archive_list_screen.dart';

class TaxiOrderArchiveListScreenDesktop extends StatelessWidget {
  const TaxiOrderArchiveListScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrdersArchiveListBloc, TaxiOrdersArchiveListState>(
      builder: (context, state) {
        return Container(
          margin: context.pagePadding,
          color: context.colors.surface,
          child: AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(
                  title: context.tr.orders,
                  subtitle: context.tr.listOfAllTaxiOrders,
                  showBackButton: true,
                  onBackButtonPressed: () =>
                      context.router.replace(TaxiOrderListRoute()),
                ),
                const SizedBox(height: 16),
                const ArchiveOrdersSummary(),
                const SizedBox(height: 16),
                const Expanded(child: ArchiveOrdersTable()),
              ],
            ),
          ),
        );
      },
    );
  }
}
