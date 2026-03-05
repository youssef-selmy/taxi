import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ShopOrderStatusX on Enum$ShopOrderStatus {
  String name(BuildContext context) {
    return switch (this) {
      Enum$ShopOrderStatus.Cancelled => context.tr.canceled,
      Enum$ShopOrderStatus.New => context.tr.newText,
      Enum$ShopOrderStatus.Processing => context.tr.processing,
      Enum$ShopOrderStatus.PaymentPending => context.tr.paymentPending,
      Enum$ShopOrderStatus.PaymentFailed => context.tr.paymentFailed,
      Enum$ShopOrderStatus.OnHold => context.tr.onHold,
      Enum$ShopOrderStatus.ReadyForPickup => context.tr.readyForPickup,
      Enum$ShopOrderStatus.OutForDelivery => context.tr.outForDelivery,
      Enum$ShopOrderStatus.Completed => context.tr.completed,
      Enum$ShopOrderStatus.Returned => context.tr.returned,
      Enum$ShopOrderStatus.Refunded => context.tr.refunded,
      Enum$ShopOrderStatus.$unknown => context.tr.unknown,
    };
  }

  SemanticColor chipType() {
    switch (this) {
      case Enum$ShopOrderStatus.Cancelled:
      case Enum$ShopOrderStatus.PaymentFailed:
      case Enum$ShopOrderStatus.Returned:
      case Enum$ShopOrderStatus.Refunded:
        return SemanticColor.error;

      case Enum$ShopOrderStatus.New:
      case Enum$ShopOrderStatus.PaymentPending:
      case Enum$ShopOrderStatus.OnHold:
        return SemanticColor.warning;

      case Enum$ShopOrderStatus.Processing:
      case Enum$ShopOrderStatus.ReadyForPickup:
      case Enum$ShopOrderStatus.OutForDelivery:
        return SemanticColor.info;

      case Enum$ShopOrderStatus.Completed:
        return SemanticColor.success;

      case Enum$ShopOrderStatus.$unknown:
        return SemanticColor.error;
    }
  }

  IconData icon() {
    return switch (chipType()) {
      SemanticColor.neutral ||
      SemanticColor.primary ||
      SemanticColor.secondary ||
      SemanticColor.info ||
      SemanticColor.warning => BetterIcons.loading03Outline,
      SemanticColor.success => BetterIcons.checkmarkCircle02Filled,
      SemanticColor.error => BetterIcons.cancelCircleFilled,
      _ => BetterIcons.loading03Outline,
    };
  }

  Widget chip(BuildContext context) {
    return AppTag(text: name(context), color: chipType(), prefixIcon: icon());
  }
}

extension ShopOrderStatusListX on List<Enum$ShopOrderStatus> {
  List<FilterItem<Enum$ShopOrderStatus>> toFilterItems(BuildContext context) =>
      where((status) => status != Enum$ShopOrderStatus.$unknown)
          .map(
            (status) => FilterItem(value: status, label: status.name(context)),
          )
          .toList();
}
