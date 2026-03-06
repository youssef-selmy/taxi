import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generic_map/interfaces/center_marker.dart';
import 'package:generic_map/interfaces/marker.dart';
import 'package:latlong2/latlong.dart';

export 'package:latlong2/latlong.dart';
export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterRodMarker = AppRodMarker;

class AppRodMarker extends StatelessWidget {
  final SemanticColor color;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? imageUrl;
  final bool isIconProminent;

  const AppRodMarker({
    super.key,
    required this.color,
    required this.title,
    this.subtitle,
    this.icon,
    this.imageUrl,
    this.isIconProminent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 4, left: 4, bottom: 4, right: 8),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: context.colors.shadow,
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isIconProminent
                        ? color.main(context)
                        : color.containerColor(context),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isIconProminent
                        ? color.onColor(context)
                        : color.main(context),
                    size: 16,
                  ),
                ),
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: 24,
                    height: 24,
                  ),
                ),
              Padding(
                padding: imageUrl == null && icon == null
                    ? const EdgeInsets.only(left: 4)
                    : EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: context.textTheme.labelMedium),
                    if (subtitle != null)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 80),
                        // To prevent overflow in narrow markers
                        child: Text(
                          subtitle!,
                          style: context.textTheme.labelSmall?.variant(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 12,
          decoration: BoxDecoration(color: context.colors.outlineBold),
        ),
        Container(
          width: 8,
          height: 2,
          decoration: ShapeDecoration(
            color: context.colors.onSurfaceDisabled,
            shape: const OvalBorder(),
          ),
        ),
      ],
    );
  }

  static CustomMarker marker({
    required String id,
    required LatLng position,
    required String title,
    String? subtitle,
    String? imageUrl,
    IconData? iconData,
    SemanticColor color = SemanticColor.primary,
    bool isIconProminent = false,
  }) => CustomMarker(
    id: id,
    fallbackAssetPath: Assets.images.markers.rodPin.path,
    fallbackAssetPackage: Assets.package,
    position: position,
    alignment: Alignment.topCenter,
    width: 150,
    height: 50,
    widget: AppRodMarker(
      imageUrl: imageUrl,
      icon: iconData,
      color: color,
      title: title,
      subtitle: subtitle,
      isIconProminent: isIconProminent,
    ),
  );

  static CenterMarker centerMarker({
    required Key key,
    required String title,
    String? subtitle,
    String? imageUrl,
    IconData? iconData,
    SemanticColor color = SemanticColor.primary,
    bool isIconProminent = false,
  }) => CenterMarker(
    alignment: Alignment.topCenter,
    size: const Size(150, 46),
    widget: AppRodMarker(
      key: key,
      imageUrl: imageUrl,
      icon: iconData,
      color: color,
      title: title,
      subtitle: subtitle,
      isIconProminent: isIconProminent,
    ),
  );
}
