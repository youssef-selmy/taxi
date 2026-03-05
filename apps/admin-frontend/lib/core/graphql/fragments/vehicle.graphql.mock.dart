import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';

final mockVehicleColor1 = Fragment$vehicleColor(id: "1", name: "Black");

final mockVehicleColor2 = Fragment$vehicleColor(id: "2", name: "White");

final mockVehicleColor3 = Fragment$vehicleColor(id: "3", name: "Red");

final mockVehicleColor4 = Fragment$vehicleColor(id: "4", name: "Blue");

final mockVehicleColor5 = Fragment$vehicleColor(id: "5", name: "Green");

final mockVehicleColors = [
  mockVehicleColor1,
  mockVehicleColor2,
  mockVehicleColor3,
  mockVehicleColor4,
  mockVehicleColor5,
];

final mockVehicleModel1 = Fragment$vehicleModel(id: "1", name: "Tesla Model S");

final mockVehicleModel2 = Fragment$vehicleModel(id: "2", name: "Tesla Model 3");

final mockVehicleModel3 = Fragment$vehicleModel(id: "3", name: "BMW i4");

final mockVehicleModel4 = Fragment$vehicleModel(id: "4", name: "BMW i3");

final mockVehicleModel5 = Fragment$vehicleModel(id: "5", name: "Audi e-tron");

final mockVehicleModels = [
  mockVehicleModel1,
  mockVehicleModel2,
  mockVehicleModel3,
  mockVehicleModel4,
  mockVehicleModel5,
];
