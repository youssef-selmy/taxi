import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:admin_frontend/core/components/parking_facility_view.dart';
import 'package:admin_frontend/core/components/user_info/user_number_view.dart';
import 'package:admin_frontend/core/enums/park_spot_facility.dart';
import 'package:admin_frontend/core/enums/park_spot_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:better_icons/better_icons.dart';

class ParkingListItem extends StatelessWidget {
  final Fragment$parkSpotDetail item;
  final Fragment$Place? selectedDestination;
  final bool isSelected;
  final Function(Fragment$parkSpotDetail)? onSelected;

  const ParkingListItem({
    super.key,
    required this.item,
    this.selectedDestination,
    this.isSelected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppListItem(
      padding: const EdgeInsets.all(16),

      isSelected: isSelected,
      child: Row(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.mainImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: item.mainImage!.address,
                height: 170,
                width: 191,
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name!, style: context.textTheme.labelMedium),
                const SizedBox(height: 8),
                if (item.phoneNumber != null) ...[
                  UserNumberView(number: item.phoneNumber!),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      item.type.icon,
                      color: context.colors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.type.name(context),
                      style: context.textTheme.labelMedium,
                    ),
                    const Spacer(),
                    Icon(
                      BetterIcons.gps01Filled,
                      color: context.colors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${context.formatDistance(((selectedDestination?.point.distanceFrom(item.location) ?? 0) / 1000))} away",
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...item.facilities.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ParkingFacilityView(
                            iconData: e.icon,
                            title: e.name(context),
                          ),
                        );
                      }),
                      if (item.carSpaces > 0) ...[
                        ParkingFacilityView(
                          iconData: BetterIcons.car05Filled,
                          title: context.tr.numberOfCarSpaces(item.carSpaces),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (item.bikeSpaces > 0) ...[
                        ParkingFacilityView(
                          iconData: BetterIcons.bicycle01Filled,
                          title: context.tr.numberOfBikeSpaces(item.bikeSpaces),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (item.truckSpaces > 0) ...[
                        ParkingFacilityView(
                          iconData: BetterIcons.truckFilled,
                          title: context.tr.numberOfTruckSpaces(
                            item.truckSpaces,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if ((item.ratingAggregate.reviewCount) > 0) ...[
                        ParkingFacilityView(
                          iconData: BetterIcons.starFilled,
                          title:
                              "${item.ratingAggregate.rating}% (${item.ratingAggregate.reviewCount} reviews)",
                          iconColor: ParkingFacilityIconColor.orange,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      BetterIcons.clock01Filled,
                      color: context.colors.onSurfaceVariant,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${item.openHour} - ${item.closeHour}",
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${item.carPrice?.formatCurrency(item.currency) ?? 0}/hr",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // value: item,
      // onSelected: onSelected,
    );
  }
}
