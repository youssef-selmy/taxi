import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TaxiOrderStatusX on Enum$OrderStatus {
  String name(BuildContext context) {
    return switch (this) {
      Enum$OrderStatus.WaitingForPostPay => context.tr.waitingForPostPay,
      Enum$OrderStatus.Requested => context.tr.requested,
      Enum$OrderStatus.NotFound => context.tr.notFound,
      Enum$OrderStatus.NoCloseFound => context.tr.noCloseFound,
      Enum$OrderStatus.Found => context.tr.found,
      Enum$OrderStatus.DriverAccepted => context.tr.accepted,
      Enum$OrderStatus.Booked => context.tr.booked,
      Enum$OrderStatus.Finished => context.tr.finished,
      Enum$OrderStatus.Arrived => context.tr.arrived,
      Enum$OrderStatus.WaitingForPrePay => context.tr.waitingForPrePay,
      Enum$OrderStatus.DriverCanceled => context.tr.driverCanceled,
      Enum$OrderStatus.RiderCanceled => context.tr.riderCanceled,
      Enum$OrderStatus.Started => context.tr.started,
      Enum$OrderStatus.WaitingForReview => context.tr.waitingForReview,
      Enum$OrderStatus.Expired => context.tr.expired,
      Enum$OrderStatus.$unknown => context.tr.unknown,
      Enum$OrderStatus.WaitingForDriverFee => "Waiting for Driver Fee",
    };
  }

  SemanticColor get semanticColor {
    return switch (this) {
      Enum$OrderStatus.WaitingForPostPay => SemanticColor.warning,
      Enum$OrderStatus.Requested => SemanticColor.warning,
      Enum$OrderStatus.NotFound => SemanticColor.error,
      Enum$OrderStatus.NoCloseFound => SemanticColor.error,
      Enum$OrderStatus.Found => SemanticColor.warning,
      Enum$OrderStatus.DriverAccepted => SemanticColor.warning,
      Enum$OrderStatus.Booked => SemanticColor.info,
      Enum$OrderStatus.Finished => SemanticColor.success,
      Enum$OrderStatus.Arrived => SemanticColor.info,
      Enum$OrderStatus.WaitingForPrePay => SemanticColor.warning,
      Enum$OrderStatus.DriverCanceled => SemanticColor.error,
      Enum$OrderStatus.RiderCanceled => SemanticColor.error,
      Enum$OrderStatus.Started => SemanticColor.info,
      Enum$OrderStatus.WaitingForReview => SemanticColor.success,
      Enum$OrderStatus.WaitingForDriverFee => SemanticColor.warning,
      Enum$OrderStatus.Expired => SemanticColor.error,
      Enum$OrderStatus.$unknown => SemanticColor.error,
    };
  }

  IconData get icon {
    final chipType = semanticColor;
    return switch (chipType) {
      SemanticColor.neutral ||
      SemanticColor.primary ||
      SemanticColor.secondary ||
      SemanticColor.info ||
      SemanticColor.warning => BetterIcons.loading03Outline,
      SemanticColor.success => BetterIcons.checkmarkCircle02Filled,
      SemanticColor.error => BetterIcons.cancelCircleFilled,
      _ => BetterIcons.cancelCircleFilled,
    };
  }

  bool get isSearching => switch (this) {
    Enum$OrderStatus.Requested => true,
    Enum$OrderStatus.NoCloseFound => true,
    Enum$OrderStatus.NotFound => true,
    Enum$OrderStatus.Found => true,
    _ => false,
  };

  TaxiOrderStatusGrouped get statusGrouped {
    return switch (this) {
      Enum$OrderStatus.Requested ||
      Enum$OrderStatus.Found ||
      Enum$OrderStatus.NoCloseFound ||
      Enum$OrderStatus.Arrived ||
      Enum$OrderStatus.NotFound ||
      Enum$OrderStatus.Started ||
      Enum$OrderStatus.WaitingForPostPay ||
      Enum$OrderStatus.WaitingForPrePay ||
      Enum$OrderStatus.WaitingForReview ||
      Enum$OrderStatus.WaitingForDriverFee ||
      Enum$OrderStatus.DriverAccepted => TaxiOrderStatusGrouped.inProgress,
      Enum$OrderStatus.DriverCanceled ||
      Enum$OrderStatus.RiderCanceled ||
      Enum$OrderStatus.Expired => TaxiOrderStatusGrouped.error,
      Enum$OrderStatus.Finished => TaxiOrderStatusGrouped.completed,
      Enum$OrderStatus.Booked => TaxiOrderStatusGrouped.booked,
      Enum$OrderStatus.$unknown => TaxiOrderStatusGrouped.error,
    };
  }

  Widget chip(BuildContext context) {
    return AppTag(text: name(context), color: semanticColor, prefixIcon: icon);
  }
}

extension TaxiOrderStatusXX on Enum$TaxiOrderStatus {
  String name(BuildContext context) => switch (this) {
    Enum$TaxiOrderStatus.Canceled => context.tr.canceled,
    Enum$TaxiOrderStatus.SearchingForDriver => context.tr.searching,
    Enum$TaxiOrderStatus.OnTrip => context.tr.onTrip,
    Enum$TaxiOrderStatus.Scheduled => context.tr.scheduled,
    Enum$TaxiOrderStatus.Completed => context.tr.completed,
    Enum$TaxiOrderStatus.Expired => context.tr.expired,
    Enum$TaxiOrderStatus.$unknown => throw UnimplementedError(),
  };
}

extension TaxiOrderStatusListX on List<Enum$OrderStatus> {
  List<FilterItem<Enum$OrderStatus>> toFilterItems(BuildContext context) {
    return where((e) => e != Enum$OrderStatus.$unknown)
        .map((status) => FilterItem(label: status.name(context), value: status))
        .toList();
  }
}

extension TaxiOrderStatusListXX on List<Enum$TaxiOrderStatus> {
  List<FilterItem<Enum$TaxiOrderStatus>> toFilterItems(BuildContext context) {
    return where((e) => e != Enum$TaxiOrderStatus.$unknown)
        .map((status) => FilterItem(label: status.name(context), value: status))
        .toList();
  }
}

enum TaxiOrderStatusGrouped { inProgress, completed, booked, error }
