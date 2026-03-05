part of 'dispatcher_taxi_screen.dart';

class DispatcherTaxiScreenDesktop extends StatefulWidget {
  const DispatcherTaxiScreenDesktop({super.key});

  @override
  State<DispatcherTaxiScreenDesktop> createState() =>
      _DispatcherTaxiScreenDesktopState();
}

class _DispatcherTaxiScreenDesktopState
    extends State<DispatcherTaxiScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 48),
        Padding(
          padding: context.pagePaddingHorizontal,
          child: Text(
            context.tr.dispatcher,
            style: context.textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 32),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: context.pagePaddingHorizontal,
            child: BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
              builder: (context, state) {
                return AppHorizontalStepIndicator(
                  connectorStyle: ConnectorStyle.line,
                  style: StepIndicatorItemStyle.circular,
                  items: [
                    StepIndicatorItem(
                      label: context.tr.customer,
                      value: 0,
                      description: context.tr.taxiSelectCustomerSubtitle,
                    ),
                    StepIndicatorItem(
                      label: context.tr.location,
                      value: 1,
                      description: context.tr.taxiSelectLocationSubtitle,
                    ),
                    StepIndicatorItem(
                      label: context.tr.service,
                      value: 2,
                      description: context.tr.taxiSelectServiceSubtitle,
                    ),
                    StepIndicatorItem(
                      label: context.tr.searching,
                      value: 3,
                      description: context.tr.taxiSearchingForDriverSubtitle,
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
          child: BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
            builder: (context, state) {
              return IndexedStack(
                index: state.currentStep,
                children: [
                  SelectCustomer(
                    onCustomerSelected: context
                        .read<DispatcherTaxiBloc>()
                        .onCustomerSelected,
                  ),
                  const SelectLocation(),
                  const SelectService(),
                  const SearchingForDriver(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
