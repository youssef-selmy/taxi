import 'package:better_assets/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:generic_map/interfaces/marker.dart';
import 'package:latlong2/latlong.dart';

typedef BetterBikeTopView = AppBikeTopView;

class AppBikeTopView extends StatelessWidget {
  const AppBikeTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.images.markers.bikeTopView.image(width: 50, height: 50);
  }

  static CustomMarker marker({
    required String id,
    required LatLng position,
    int rotation = 0,
  }) => CustomMarker(
    id: id,
    position: position,
    alignment: Alignment.topCenter,
    width: 50,
    height: 50,
    rotation: rotation,
    widget: const AppBikeTopView(),
    fallbackAssetPath: Assets.images.markers.bikeTopView.path,
    fallbackAssetPackage: Assets.package,
  );
}
