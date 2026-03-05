import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ShopOrderQueueLevelX on Enum$OrderQueueLevel {
  SemanticColor chipType() {
    switch (this) {
      case Enum$OrderQueueLevel.LOW:
        return SemanticColor.success;
      case Enum$OrderQueueLevel.MEDIUM:
        return SemanticColor.warning;
      case Enum$OrderQueueLevel.HIGH:
        return SemanticColor.error;
      case Enum$OrderQueueLevel.$unknown:
        return SemanticColor.error;
    }
  }

  String localizedString(BuildContext context) {
    switch (this) {
      case Enum$OrderQueueLevel.LOW:
        return context.tr.low;
      case Enum$OrderQueueLevel.MEDIUM:
        return context.tr.medium;
      case Enum$OrderQueueLevel.HIGH:
        return context.tr.high;
      case Enum$OrderQueueLevel.$unknown:
        return context.tr.unknown;
    }
  }

  AppTag toChip(BuildContext context) {
    return AppTag(text: localizedString(context), color: chipType());
  }
}
