import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generic_map/interfaces/marker.dart';
import 'package:latlong2/latlong.dart';

export 'package:latlong2/latlong.dart';
export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterDotPin = AppDotPin;

class AppDotPin extends StatelessWidget {
  final String? imageUrl;
  final IconData? iconData;
  final SemanticColor? color;

  const AppDotPin({super.key, this.imageUrl, this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 34,
      child: Stack(
        children: [
          Assets.images.shapes.dotPin.svg(
            colorFilter: ColorFilter.mode(
              color?.main(context) ?? context.colors.surface,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 34,
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
    height: 34,
    widget: AppDotPin(imageUrl: imageUrl, iconData: iconData, color: color),
    fallbackAssetPath: Assets.images.markers.dotPin.path,
    fallbackAssetPackage: Assets.package,
  );
}
