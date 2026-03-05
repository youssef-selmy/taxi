import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingOrderStatusX on Enum$ParkOrderStatus {
  String name(BuildContext context) {
    return switch (this) {
      Enum$ParkOrderStatus.PENDING => context.tr.pending,
      Enum$ParkOrderStatus.PAID => context.tr.paid,
      Enum$ParkOrderStatus.CANCELLED => context.tr.canceled,
      Enum$ParkOrderStatus.ACCEPTED => context.tr.accepted,
      Enum$ParkOrderStatus.REJECTED => context.tr.rejected,
      Enum$ParkOrderStatus.COMPLETED => context.tr.completed,
      Enum$ParkOrderStatus.$unknown => context.tr.unknown,
    };
  }

  SemanticColor chipType() {
    switch (this) {
      case Enum$ParkOrderStatus.PENDING:
        return SemanticColor.warning;

      case Enum$ParkOrderStatus.ACCEPTED:
        return SemanticColor.info;

      case Enum$ParkOrderStatus.PAID:
      case Enum$ParkOrderStatus.COMPLETED:
        return SemanticColor.success;

      case Enum$ParkOrderStatus.CANCELLED:
      case Enum$ParkOrderStatus.REJECTED:
        return SemanticColor.error;

      case Enum$ParkOrderStatus.$unknown:
        return SemanticColor.error;
    }
  }

  IconData icon() => switch (chipType()) {
    SemanticColor.neutral ||
    SemanticColor.primary ||
    SemanticColor.secondary ||
    SemanticColor.info ||
    SemanticColor.warning => BetterIcons.loading03Outline,
    SemanticColor.success => BetterIcons.checkmarkCircle02Filled,
    SemanticColor.error => BetterIcons.cancelCircleFilled,
    _ => BetterIcons.alert02Filled,
  };

  Widget iconChip(BuildContext context) {
    switch (this) {
      case Enum$ParkOrderStatus.ACCEPTED:
        return Icon(
          BetterIcons.tick02Filled,
          color: context.colors.primary,
          size: 20,
        );
      case Enum$ParkOrderStatus.CANCELLED:
        return Icon(
          BetterIcons.bookOpen01Outline,
          color: context.colors.primary,
          size: 20,
        );
      case Enum$ParkOrderStatus.$unknown:
        return Icon(
          BetterIcons.bookOpen01Outline,
          color: context.colors.primary,
          size: 20,
        );
      case Enum$ParkOrderStatus.COMPLETED:
        return Icon(
          BetterIcons.tick02Filled,
          color: context.colors.primary,
          size: 20,
        );
      case Enum$ParkOrderStatus.PAID:
        return Icon(
          BetterIcons.tick02Filled,
          color: context.colors.primary,
          size: 20,
        );
      case Enum$ParkOrderStatus.PENDING:
        return Icon(
          BetterIcons.car05Filled,
          color: context.colors.primary,
          size: 20,
        );
      case Enum$ParkOrderStatus.REJECTED:
        return Icon(
          BetterIcons.bookOpen01Outline,
          color: context.colors.primary,
          size: 20,
        );
    }
  }

  Color foregroundColor(BuildContext context) => switch (this) {
    Enum$ParkOrderStatus.PENDING => context.colors.primaryContainer,
    Enum$ParkOrderStatus.ACCEPTED => context.colors.primaryContainer,
    Enum$ParkOrderStatus.CANCELLED => context.colors.error,
    Enum$ParkOrderStatus.COMPLETED => context.colors.primaryContainer,
    Enum$ParkOrderStatus.PAID => context.colors.primaryContainer,
    Enum$ParkOrderStatus.REJECTED => context.colors.error,
    Enum$ParkOrderStatus.$unknown => context.colors.error,
  };

  Widget toChip(BuildContext context) {
    return AppTag(text: name(context), color: chipType(), prefixIcon: icon());
  }
}

extension ParkOrderListX on List<Enum$ParkOrderStatus> {
  List<FilterItem<Enum$ParkOrderStatus>> toFilterItems(BuildContext context) =>
      where(
        (e) => e != Enum$ParkOrderStatus.$unknown,
      ).map((e) => FilterItem(label: e.name(context), value: e)).toList();
}
