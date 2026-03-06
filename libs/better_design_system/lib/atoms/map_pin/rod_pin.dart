import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generic_map/interfaces/center_marker.dart';
import 'package:generic_map/interfaces/marker.dart';
import 'package:latlong2/latlong.dart';

export 'package:latlong2/latlong.dart';
export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterRodPin = AppRodPin;

class AppRodPin extends StatelessWidget {
  final String? imageUrl;
  final IconData? iconData;
  final SemanticColor? color;

  const AppRodPin({super.key, this.imageUrl, this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 39,
      child: Stack(
        children: [
          Assets.images.shapes.rodPin.svg(
            colorFilter: ColorFilter.mode(
              color?.main(context) ?? context.colors.surface,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 39,
          ),
          if (imageUrl != null)
            Positioned(
              top: 2,
              left: 2,
              right: 2,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          if (iconData != null)
            Positioned(
              top: 4,
              left: 4,
              right: 4,
              child: Icon(
                iconData,
                color: color?.onColor(context) ?? context.colors.onSurface,
                size: 16,
              ),
            ),
          if (imageUrl == null && iconData == null)
            Positioned(
              top: 7,
              left: 7,
              right: 7,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color?.onColor(context) ?? context.colors.onSurface,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  factory AppRodPin.pickupPin() => const AppRodPin(
    imageUrl: null,
    iconData: BetterIcons.gps01Filled,
    color: SemanticColor.tertiary,
  );

  factory AppRodPin.destinationPin() => const AppRodPin(
    imageUrl: null,
    iconData: null,
    color: SemanticColor.primary,
  );

  static CustomMarker marker({
    required String id,
    required LatLng position,
    String? imageUrl,
    IconData? iconData,
    SemanticColor color = SemanticColor.primary,
  }) => CustomMarker(
    id: id,
    position: position,
    alignment: Alignment.topCenter,
    width: 24,
    height: 39,
    widget: AppRodPin(imageUrl: imageUrl, iconData: iconData, color: color),
    fallbackAssetPath: Assets.images.markers.rodPin.path,
    fallbackAssetPackage: Assets.package,
  );

  static CenterMarker centerMarker({
    required Key key,
    String? imageUrl,
    IconData? iconData,
    SemanticColor color = SemanticColor.primary,
  }) => CenterMarker(
    alignment: Alignment.topCenter,
    size: const Size(24, 39),
    widget: AppRodPin(
      key: key,
      imageUrl: imageUrl,
      iconData: iconData,
      color: color,
    ),
  );

  static CenterMarker centerMarkerDestination({required Key key}) =>
      CenterMarker(
        alignment: Alignment.topCenter,
        size: const Size(24, 39),
        widget: AppRodPin(key: key, color: SemanticColor.primary),
      );

  static CenterMarker centerMarkerPickup({required Key key}) => CenterMarker(
    alignment: Alignment.topCenter,
    size: const Size(24, 39),
    widget: AppRodPin(
      key: key,
      color: SemanticColor.tertiary,
      iconData: BetterIcons.gps01Filled,
    ),
  );

  static CustomMarker markerDestination({
    required String id,
    required LatLng position,
    String? imageUrl,
    IconData? iconData,
  }) => CustomMarker(
    id: id,
    position: position,
    alignment: Alignment.topCenter,
    fallbackAssetPath: Assets.images.markers.rodPin.path,
    fallbackAssetPackage: Assets.package,
    width: 24,
    height: 39,
    widget: AppRodPin(
      imageUrl: imageUrl,
      iconData: iconData,
      color: SemanticColor.primary,
    ),
  );

  static CustomMarker markerPickup({
    required String id,
    required LatLng position,
    String? imageUrl,
    IconData? iconData,
  }) => CustomMarker(
    id: id,
    position: position,
    alignment: Alignment.topCenter,
    fallbackAssetPath: Assets.images.markers.pickupRod.path,
    fallbackAssetPackage: Assets.package,
    width: 24,
    height: 39,
    widget: AppRodPin(
      imageUrl: imageUrl,
      iconData: iconData,
      color: SemanticColor.tertiary,
    ),
  );
}
