import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockTaxiPricingCategory1 = Fragment$taxiPricingCategory(
  id: "1",
  name: "Ride",
  services: [],
);

final mockTaxiPricingCategory2 = Fragment$taxiPricingCategory(
  id: "2",
  name: "Delivery",
  services: [],
);

final mockTaxiPricingCategory3 = Fragment$taxiPricingCategory(
  id: "3",
  name: "Truck",
  services: [],
);

final mockTaxiPricingCategories = [
  mockTaxiPricingCategory1,
  mockTaxiPricingCategory2,
  mockTaxiPricingCategory3,
];

final mockTaxiPricingListItem1 = Fragment$taxiPricingListItem(
  id: "1",
  name: "Economy",
  categoryId: "1",
  media: ImageFaker().taxiService.carYellow.toMedia,
  personCapacity: 3,
  description: "Economy class taxi",
);

final mockTaxiPricingListItem2 = Fragment$taxiPricingListItem(
  id: "2",
  name: "Business",
  categoryId: "1",
  media: ImageFaker().taxiService.carPremiumYellow.toMedia,
);

final mockTaxiPricingListItem3 = Fragment$taxiPricingListItem(
  id: "3",
  name: "First Class",
  categoryId: "1",
  media: ImageFaker().taxiService.carPremiumBlack.toMedia,
);

final mockTaxiPricingListItem4 = Fragment$taxiPricingListItem(
  id: "4",
  name: "VIP",
  categoryId: "1",
  media: ImageFaker().taxiService.bikeWhite.toMedia,
);

final taxiPricingListItems = [
  mockTaxiPricingListItem1,
  mockTaxiPricingListItem2,
  mockTaxiPricingListItem3,
  mockTaxiPricingListItem4,
];

final mockTaxiPricing1 = Fragment$taxiPricing(
  id: "1",
  name: "VIP",
  baseFare: 5,
  perHundredMeters: 10,
  orderTypes: [Enum$TaxiOrderType.Ride, Enum$TaxiOrderType.ParcelDelivery],
  perMinuteDrive: 5,
  perMinuteWait: 1,
  prepayPercent: 0,
  minimumFee: 0,
  maximumDestinationDistance: 100,
  paymentMethod: Enum$ServicePaymentMethod.CashCredit,
  cancellationTotalFee: 10,
  displayPriority: 1,
  cancellationDriverShare: 20,
  providerShareFlat: 10,
  twoWayAvailable: true,
  timeMultipliers: [],
  distanceMultipliers: [],
  weekdayMultipliers: [],
  dateRangeMultipliers: [],
  media: ImageFaker().taxiService.taxiService1.toMedia,
  regions: [],
  options: [],
  categoryId: "1",
  searchRadius: 10000,
  providerSharePercent: 50,
  pricingMode: Enum$PricingMode.FIXED,
  rangePolicy: Enum$RangePolicy.ENFORCE,
  priceRangeMinPercent: 0,
  priceRangeMaxPercent: 0,
);

final mockTaxiPricing2 = Fragment$taxiPricing(
  id: "2",
  name: "NORMAL",
  baseFare: 5,
  orderTypes: [Enum$TaxiOrderType.Ride, Enum$TaxiOrderType.ParcelDelivery],
  perHundredMeters: 10,
  perMinuteDrive: 5,
  perMinuteWait: 1,
  prepayPercent: 0,
  minimumFee: 0,
  displayPriority: 2,
  maximumDestinationDistance: 100,
  paymentMethod: Enum$ServicePaymentMethod.CashCredit,
  cancellationTotalFee: 10,
  cancellationDriverShare: 20,
  providerShareFlat: 10,
  twoWayAvailable: true,
  timeMultipliers: [],
  distanceMultipliers: [],
  weekdayMultipliers: [],
  dateRangeMultipliers: [],
  media: ImageFaker().taxiService.taxiService1.toMedia,
  regions: [],
  options: [],
  categoryId: "2",
  searchRadius: 10000,
  providerSharePercent: 50,
  pricingMode: Enum$PricingMode.FIXED,
  rangePolicy: Enum$RangePolicy.ENFORCE,
  priceRangeMinPercent: 0,
  priceRangeMaxPercent: 0,
);
final mockTaxiPricing3 = Fragment$taxiPricing(
  id: "3",
  name: "Business",
  orderTypes: [Enum$TaxiOrderType.Ride, Enum$TaxiOrderType.ParcelDelivery],
  baseFare: 5,
  perHundredMeters: 10,
  perMinuteDrive: 5,
  perMinuteWait: 1,
  prepayPercent: 0,
  minimumFee: 0,
  displayPriority: 3,
  maximumDestinationDistance: 100,
  paymentMethod: Enum$ServicePaymentMethod.CashCredit,
  cancellationTotalFee: 10,
  cancellationDriverShare: 20,
  providerShareFlat: 10,
  twoWayAvailable: true,
  timeMultipliers: [],
  distanceMultipliers: [],
  weekdayMultipliers: [],
  dateRangeMultipliers: [],
  media: ImageFaker().taxiService.taxiService1.toMedia,
  regions: [],
  options: [],
  categoryId: "3",
  searchRadius: 10000,
  providerSharePercent: 50,
  pricingMode: Enum$PricingMode.FIXED,
  rangePolicy: Enum$RangePolicy.ENFORCE,
  priceRangeMinPercent: 0,
  priceRangeMaxPercent: 0,
);

final mockTimeMultiplier1 = Fragment$timeMultiplier(
  startTime: "08:00",
  endTime: "10:00",
  multiply: 1.5,
);
