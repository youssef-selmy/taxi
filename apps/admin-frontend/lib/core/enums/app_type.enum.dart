import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:flutter/material.dart';

extension AppTypeX on Enum$AppType {
  String displayName(BuildContext context) => switch (this) {
    Enum$AppType.Shop => context.tr.shop,
    Enum$AppType.Taxi => context.tr.taxi,
    Enum$AppType.Parking => context.tr.parking,
    Enum$AppType.$unknown => context.tr.unknown,
  };
}
