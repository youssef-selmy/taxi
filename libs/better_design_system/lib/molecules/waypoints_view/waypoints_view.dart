import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/map_pin/destination_point.dart';
import 'package:better_design_system/atoms/map_pin/pickup_point.dart';
import 'waypoint_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

export 'waypoint_item.dart';

typedef BetterWaypointsView = AppWaypointsView;

class AppWaypointsView extends StatelessWidget {
  final List<WaypointItem> waypoints;

  const AppWaypointsView({super.key, required this.waypoints});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: waypoints.mapIndexed((index, e) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Row(
              children: [
                _dot(index),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _title(context, index, e),
                        style: context.textTheme.bodyMedium?.variant(context),
                      ),
                      const SizedBox(height: 2),
                      Text(e.address, style: context.textTheme.bodyLarge),
                    ],
                  ),
                ),
                if (e.dateTime != null)
                  Text(
                    e.dateTime!.formatTime,
                    style: context.textTheme.bodySmall?.variant(context),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            if (index != waypoints.length - 1)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Container(
                  width: 1,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [context.colors.primary, context.colors.tertiary],
                    ),
                  ),
                ),
              ),
          ],
        );
      }).toList(),
    );
  }

  String _title(BuildContext context, int index, WaypointItem e) {
    if (e.title != null) {
      return e.title!;
    }
    if (index == 0) {
      return context.strings.pickupPoint;
    } else if (index == waypoints.length - 1) {
      return context.strings.dropoffPoint;
    }
    return '';
  }

  StatelessWidget _dot(int index) {
    if (waypoints[index].imageUrl != null) {
      return AppAvatar(
        imageUrl: waypoints[index].imageUrl,
        size: AvatarSize.xxl24px,
        enabledBorder: true,
      );
    }
    return index == 0 ? const AppPickupPoint() : const AppDestinationPoint();
  }
}
