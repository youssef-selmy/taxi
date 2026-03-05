import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockTaxiOrderOption1 = Fragment$taxiOrderOption(
  id: "1",
  name: "Two way",
  icon: Enum$ServiceOptionIcon.TwoWay,
  additionalFee: 10,
  type: Enum$ServiceOptionType.TwoWay,
);
final mockTaxiOrderOption2 = Fragment$taxiOrderOption(
  id: "2",
  name: "Pets",
  icon: Enum$ServiceOptionIcon.Pet,
  additionalFee: 5,
  type: Enum$ServiceOptionType.Free,
);

final mockTaxiOrderOptions = [mockTaxiOrderOption1, mockTaxiOrderOption2];
