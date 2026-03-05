import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension RequestActivityX on Enum$RequestActivityType {
  String toName(BuildContext context) => switch (this) {
    Enum$RequestActivityType.RequestedByRider => context.tr.rideRequested,
    Enum$RequestActivityType.DriverAccepted => context.tr.accepted,
    Enum$RequestActivityType.RequestedByOperator =>
      context.tr.operatorRequested,
    Enum$RequestActivityType.BookedByOperator => context.tr.operatorBooked,
    Enum$RequestActivityType.BookedByRider => context.tr.riderBooked,
    Enum$RequestActivityType.ArrivedToPickupPoint => context.tr.arrived,
    Enum$RequestActivityType.CanceledByDriver => context.tr.driverCanceled,
    Enum$RequestActivityType.CanceledByRider => context.tr.riderCanceled,
    Enum$RequestActivityType.CanceledByOperator => context.tr.operatorCanceled,
    Enum$RequestActivityType.Started => context.tr.started,
    Enum$RequestActivityType.ArrivedToDestination => context.tr.completed,
    Enum$RequestActivityType.Paid => context.tr.paid,
    Enum$RequestActivityType.Reviewed => context.tr.reviewed,
    Enum$RequestActivityType.Expired => context.tr.expired,
    Enum$RequestActivityType.$unknown => context.tr.unknown,
  };

  List<Enum$RequestActivityType> get tripNextSteps {
    const tripNextStepsMap = {
      Enum$RequestActivityType.ArrivedToPickupPoint: [
        Enum$RequestActivityType.Started,
        Enum$RequestActivityType.ArrivedToDestination,
      ],
      Enum$RequestActivityType.Started: [
        Enum$RequestActivityType.ArrivedToDestination,
      ],
      Enum$RequestActivityType.RequestedByRider: [
        Enum$RequestActivityType.DriverAccepted,
      ],
    };
    return tripNextStepsMap[this] ?? [];
  }

  Color foregroundColor(BuildContext context) => switch (this) {
    Enum$RequestActivityType.RequestedByRider =>
      context.colors.primaryContainer,
    Enum$RequestActivityType.DriverAccepted => context.colors.primaryContainer,
    Enum$RequestActivityType.RequestedByOperator =>
      context.colors.primaryContainer,
    Enum$RequestActivityType.BookedByOperator =>
      context.colors.primaryContainer,
    Enum$RequestActivityType.BookedByRider => context.colors.primaryContainer,
    Enum$RequestActivityType.ArrivedToPickupPoint =>
      context.colors.primaryContainer,
    Enum$RequestActivityType.CanceledByDriver ||
    Enum$RequestActivityType.CanceledByRider ||
    Enum$RequestActivityType.Expired ||
    Enum$RequestActivityType.CanceledByOperator ||
    Enum$RequestActivityType.$unknown => context.colors.error,
    Enum$RequestActivityType.Started => context.colors.primaryContainer,
    Enum$RequestActivityType.ArrivedToDestination =>
      context.colors.primaryContainer,
    Enum$RequestActivityType.Paid => context.colors.primaryContainer,
    Enum$RequestActivityType.Reviewed => context.colors.primaryContainer,
  };

  Widget icon(BuildContext context) => switch (this) {
    Enum$RequestActivityType.RequestedByRider => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.DriverAccepted => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.$unknown => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.RequestedByOperator => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.BookedByOperator => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.BookedByRider => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.ArrivedToPickupPoint => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.CanceledByDriver => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.CanceledByRider => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.CanceledByOperator => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.Started => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.ArrivedToDestination => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.Paid => Icon(
      BetterIcons.tick02Filled,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.Reviewed => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
    Enum$RequestActivityType.Expired => Icon(
      BetterIcons.bookOpen01Outline,
      color: context.colors.primary,
      size: 20,
    ),
  };
}
