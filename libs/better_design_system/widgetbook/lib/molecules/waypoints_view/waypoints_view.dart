import 'package:better_design_system/molecules/waypoints_view/waypoints_view.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:time/time.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppWaypointsView)
Widget defaultWaypointsView(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppWaypointsView(
      waypoints: [
        WaypointItem(
          title: 'Pickup Point',
          address: '30th St, New York, NY 10001',
          dateTime: 30.minutes.ago,
        ),
        WaypointItem(
          title: 'Dropoff Point',
          address: '40th St, New York, NY 10001',
          dateTime: 15.minutes.fromNow,
        ),
      ],
    ),
  );
}

@UseCase(name: 'Shop Delivery', type: AppWaypointsView)
Widget shopDeliverytWaypointsView(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppWaypointsView(
      waypoints: [
        WaypointItem(
          title: "Master Chef",
          address: '30th St, New York, NY 10001',
          dateTime: 30.minutes.ago,
          imageUrl: ImageFaker().shop.logo.masterChef,
        ),
        WaypointItem(
          title: "Target Store",
          address: '40th St, New York, NY 10001',
          dateTime: 15.minutes.fromNow,
          imageUrl: ImageFaker().shop.logo.targetStore,
        ),
        WaypointItem(
          title: 'Delivery Location',
          address: '50th St, New York, NY 10001',
          dateTime: 15.minutes.fromNow,
        ),
      ],
    ),
  );
}
