import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension UserTypeEnumX on Enum$AnnouncementUserType {
  String name(BuildContext context) {
    return switch (this) {
      Enum$AnnouncementUserType.Driver => context.tr.driver,
      Enum$AnnouncementUserType.Rider => context.tr.customer,
      Enum$AnnouncementUserType.$unknown => context.tr.unknown,
      Enum$AnnouncementUserType.Operator => context.tr.staff,
    };
  }

  Color color(BuildContext context) {
    return switch (this) {
      Enum$AnnouncementUserType.Driver => context.colors.secondary,
      Enum$AnnouncementUserType.Rider => context.colors.primary,
      Enum$AnnouncementUserType.$unknown => context.colors.onSurfaceVariant,
      Enum$AnnouncementUserType.Operator => context.colors.tertiary,
    };
  }
}
