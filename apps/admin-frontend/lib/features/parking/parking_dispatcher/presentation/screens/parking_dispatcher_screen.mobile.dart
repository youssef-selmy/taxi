part of 'parking_dispatcher_screen.dart';

class ParkingDispatcherScreenMobile extends StatelessWidget {
  const ParkingDispatcherScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      image: Assets.images.emptyStates.dataSynchronization,
      title: context.tr.featureOnlyAvailableInDesktop,
    );
  }
}
