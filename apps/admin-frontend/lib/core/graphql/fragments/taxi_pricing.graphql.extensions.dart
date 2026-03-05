import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TaxiPricingGQL on Fragment$taxiPricing {
  List<Input$WeekdayMultiplierInput> weekDayToInput() {
    return weekdayMultipliers
        .map(
          (e) => Input$WeekdayMultiplierInput(
            weekday: e.weekday,
            multiply: e.multiply,
          ),
        )
        .toList();
  }

  List<Input$DateRangeMultiplierInput> dateRangeToInput() {
    return dateRangeMultipliers
        .map(
          (e) => Input$DateRangeMultiplierInput(
            startDate: e.startDate,
            endDate: e.endDate,
            multiply: e.multiply,
          ),
        )
        .toList();
  }

  List<Input$TimeMultiplierInput> timeToInput() {
    return timeMultipliers
        .map(
          (e) => Input$TimeMultiplierInput(
            startTime: e.startTime,
            endTime: e.endTime,
            multiply: e.multiply,
          ),
        )
        .toList();
  }

  List<Input$DistanceMultiplierInput> distanceToInput() {
    return distanceMultipliers
        .map(
          (e) => Input$DistanceMultiplierInput(
            distanceFrom: e.distanceFrom,
            distanceTo: e.distanceTo,
            multiply: e.multiply,
          ),
        )
        .toList();
  }
}
