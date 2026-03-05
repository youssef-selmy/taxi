import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/components/driver_profile/driver_profile_medium.dart';
import 'package:admin_frontend/core/components/user_info/user_number_view.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';

class DriverLocationCard extends StatelessWidget {
  final Fragment$DriverLocation driverLocation;
  final bool isSelected;
  final Function(Fragment$DriverLocation) onTap;

  const DriverLocationCard({
    super.key,
    required this.driverLocation,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppListItem(
      onTap: (value) => onTap(driverLocation),
      isSelected: isSelected,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DriverProfileMedium(
                  imageUrl: driverLocation.avatarUrl,
                  fullName: driverLocation.fullName,
                  rating: driverLocation.rating?.toInt(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserNumberView(
                      number: driverLocation.mobileNumber.formatPhoneNumber(
                        null,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "${context.tr.lastActivity}: ",
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          driverLocation.lastUpdatedAt.toTimeAgo,
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
