part of 'parking_dispatcher_screen.dart';

class ParkingDispatcherScreenDesktop extends StatelessWidget {
  const ParkingDispatcherScreenDesktop({super.key});

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
        Padding(
          padding: context.pagePaddingHorizontal,
          child: BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
            builder: (context, state) {
              return AppHorizontalStepIndicator(
                connectorStyle: ConnectorStyle.line,
                style: StepIndicatorItemStyle.circular,
                items: [
                  StepIndicatorItem(
                    label: context.tr.customer,
                    value: 0,
                    description: context.tr.parkingSelectCustomerSubtitle,
                  ),
                  StepIndicatorItem(
                    label: context.tr.locationAndDate,
                    value: 1,
                    description: context.tr.parkingSelectLocationSubtitle,
                  ),
                  StepIndicatorItem(
                    label: context.tr.selectSpot,
                    value: 2,
                    description: context.tr.parkingSelectSpotSubtitle,
                  ),
                ],
                selectedStep: state.currentStep,
              );
            },
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
            builder: (context, state) {
              return IndexedStack(
                index: state.currentStep,
                children: [
                  SelectCustomer(
                    onCustomerSelected: context
                        .read<ParkingDispatcherBloc>()
                        .onCustomerSelected,
                  ),
                  const LocationAndDate(),
                  const SelectSpot(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
