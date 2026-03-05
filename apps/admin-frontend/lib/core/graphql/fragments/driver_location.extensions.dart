import 'package:admin_frontend/core/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:generic_map/generic_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:better_icons/better_icons.dart';

extension LocationClusterMarker on Fragment$LocationCluster {
  CustomMarker marker(BuildContext context) => CustomMarker(
    id: 'h3_$h3Index',
    position: location.toLatLngLib(),
    width: 50,
    height: 50,
    widget: Container(
      decoration: BoxDecoration(
        color: context.colors.primary,
        shape: BoxShape.circle,
      ),
      child: Padding(padding: EdgeInsets.all(8), child: Text('$count')),
    ),
  );
}

extension LocationWithIdList on List<Fragment$LocationWithId> {
  List<CustomMarker> get markers => map((e) => e.marker).toList();
}

extension LocationWithId on Fragment$LocationWithId {
  CustomMarker get marker => point.driverMarker(driverId);
}

extension DriverLocationClusterFragmentExtensions
    on List<Fragment$LocationCluster> {
  List<CustomMarker> markers(BuildContext context) =>
      map((e) => e.marker(context)).toList();
}

extension DriverLocationsFragmentExtension on Fragment$DriverLocation {
  String get fullName => [(firstName ?? ''), (lastName ?? '')].join(' ').trim();

  CustomMarker get marker => location.driverMarker(id);

  CircleMarker circleMarker(BuildContext context) => CircleMarker(
    id: 'circle_$id',
    position: location.toLatLngLib(),
    color: const Color(0xFFE7EEFF).withValues(alpha: 0.6),
    borderColor: context.colors.primary,
    borderWidth: 2,
    radius: 100,
  );

  Widget listView(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          AppAvatar(imageUrl: avatarUrl, size: AvatarSize.size40px),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fullName, style: context.textTheme.labelLarge),
                RatingIndicator(rating: rating),
              ],
            ),
          ),
          const SizedBox(width: 8),
          AppTag(
            text: context.tr.online,
            prefixIcon: BetterIcons.checkmarkCircle02Filled,
            color: SemanticColor.success,
          ),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          AppLinkButton(
            prefixIcon: BetterIcons.call02Filled,
            text: mobileNumber.formatPhoneNumber(null),
            onPressed: () {
              launchUrlString('tel:+$mobileNumber');
            },
          ),
          Spacer(),
          AppTextButton(
            size: ButtonSize.small,
            color: SemanticColor.neutral,
            onPressed: () {
              context.navigateTo(DriverDetailRoute(driverId: id));
            },
            text: context.tr.viewProfile,
            suffixIcon: BetterIcons.arrowRight01Outline,
          ),
        ],
      ),
    ],
  );
}

extension DriverLocationListFragmentExtensions
    on List<Fragment$DriverLocation> {
  List<LatLng> get locations => map((e) => e.location.toLatLngLib()).toList();
  List<CustomMarker> get markers => map((e) => e.marker).toList();
}
