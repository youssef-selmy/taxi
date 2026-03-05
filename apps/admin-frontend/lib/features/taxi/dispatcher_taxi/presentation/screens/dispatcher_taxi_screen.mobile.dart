part of 'dispatcher_taxi_screen.dart';

class DispatcherTaxiScreenMobile extends StatelessWidget {
  const DispatcherTaxiScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      image: Assets.images.emptyStates.dataSynchronization,
      title: context.tr.featureOnlyAvailableInDesktop,
    );
  }
}
