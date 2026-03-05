import 'package:admin_frontend/schema.graphql.dart';
import 'package:flutter/material.dart';
import 'package:better_localization/localizations.dart';

extension OrderTypeX on Enum$TaxiOrderType {
  String title(BuildContext context) => switch (this) {
    Enum$TaxiOrderType.Ride => context.tr.ride,
    Enum$TaxiOrderType.Rideshare => context.tr.rideShare,
    Enum$TaxiOrderType.ParcelDelivery => context.tr.parcelDelivery,
    Enum$TaxiOrderType.FoodDelivery => context.tr.foodDelivery,
    Enum$TaxiOrderType.ShopDelivery => context.tr.shopDelivery,
    Enum$TaxiOrderType.$unknown => context.tr.unknown,
  };
}
