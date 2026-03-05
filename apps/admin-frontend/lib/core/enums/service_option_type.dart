import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ServiceOptionTypeX on Enum$ServiceOptionType {
  String name(BuildContext context) {
    switch (this) {
      case Enum$ServiceOptionType.Free:
        return context.tr.free;
      case Enum$ServiceOptionType.Paid:
        return context.tr.paid;
      case Enum$ServiceOptionType.$unknown:
        return context.tr.unknown;
      case Enum$ServiceOptionType.TwoWay:
        return context.tr.twoWay;
    }
  }

  SemanticColor _chipColor(BuildContext context) {
    switch (this) {
      case Enum$ServiceOptionType.Free:
        return SemanticColor.success;
      case Enum$ServiceOptionType.Paid:
        return SemanticColor.error;
      case Enum$ServiceOptionType.$unknown:
        return SemanticColor.warning;
      case Enum$ServiceOptionType.TwoWay:
        return SemanticColor.secondary;
    }
  }

  Widget chip(BuildContext context) {
    return AppTag(text: name(context), color: _chipColor(context));
  }
}
