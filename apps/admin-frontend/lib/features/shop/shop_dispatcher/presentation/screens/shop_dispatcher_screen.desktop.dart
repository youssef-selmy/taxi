part of 'shop_dispatcher_screen.dart';

class ShopDispatcherScreenDesktop extends StatelessWidget {
  const ShopDispatcherScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: context.isDesktop ? 48 : 16),
        Padding(
          padding: context.pagePaddingHorizontal,
          child: Text(
            context.tr.dispatcher,
            style: context.textTheme.headlineLarge,
          ),
        ),
        SizedBox(height: context.isDesktop ? 32 : 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: context.pagePaddingHorizontal,
            child: BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
              builder: (context, state) {
                return AppHorizontalStepIndicator(
                  connectorStyle: ConnectorStyle.line,
                  style: StepIndicatorItemStyle.circular,
                  items: [
                    StepIndicatorItem(
                      label: context.tr.customer,
                      value: 0,
                      description: context.tr.shopSelectCustomerSubtitle,
                    ),
                    StepIndicatorItem(
                      label: context.tr.location,
                      value: 1,
                      description: context.tr.shopSelectLocationSubtitle,
                    ),
                    StepIndicatorItem(
                      label: context.tr.addItems,
                      value: 2,
                      description: context.tr.shopAddItemsSubtitle,
                    ),
                    StepIndicatorItem(
                      label: context.tr.checkoutOptions,
                      value: 3,
                      description: context.tr.shopCheckoutOptionsSubtitle,
                    ),
                  ],
                  selectedStep: state.currentStep,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
            builder: (context, state) {
              return IndexedStack(
                index: state.currentStep,
                children: [
                  SelectCustomer(
                    onCustomerSelected: context
                        .read<ShopDispatcherBloc>()
                        .onCustomerSelected,
                  ),
                  const SelectLocation(),
                  const SelectItems(),
                  const CheckoutOptions(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
