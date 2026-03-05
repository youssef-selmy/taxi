import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.dart';

final mockCustomerWalletUSD = Fragment$customerWallet(
  balance: 500,
  currency: "USD",
);

final mockCustomerWalletEUR = Fragment$customerWallet(
  balance: 600,
  currency: "EUR",
);

final mockCustomerWalletGBP = Fragment$customerWallet(
  balance: 700,
  currency: "GBP",
);

final mockCustomerWallets = [
  mockCustomerWalletUSD,
  mockCustomerWalletEUR,
  mockCustomerWalletGBP,
];

final mockDriverWalletUSD = Fragment$driverWallet(
  balance: 500,
  currency: "USD",
);

final mockDriverWalletEUR = Fragment$driverWallet(
  balance: 600,
  currency: "EUR",
);

final mockDriverWalletGBP = Fragment$driverWallet(
  balance: 700,
  currency: "GBP",
);

final mockDriverWallets = [
  mockDriverWalletUSD,
  mockDriverWalletEUR,
  mockDriverWalletGBP,
];

final mockAdminWalletUSD = Fragment$adminWallet(balance: 500, currency: "USD");

final mockAdminWalletEUR = Fragment$adminWallet(balance: 600, currency: "EUR");

final mockAdminWalletGBP = Fragment$adminWallet(balance: 700, currency: "GBP");

final mockAdminWallets = [
  mockAdminWalletUSD,
  mockAdminWalletEUR,
  mockAdminWalletGBP,
];

final mockFleetWalletUSD = Fragment$fleetWallet(balance: 500, currency: "USD");

final mockFleetWalletEUR = Fragment$fleetWallet(balance: 600, currency: "EUR");

final mockFleetWalletGBP = Fragment$fleetWallet(balance: 700, currency: "GBP");

final mockFleetWallets = [
  mockFleetWalletUSD,
  mockFleetWalletEUR,
  mockFleetWalletGBP,
];

final mockShopWalletUSD = Fragment$shopWallet(balance: 500, currency: "USD");

final mockShopWalletEUR = Fragment$shopWallet(balance: 600, currency: "EUR");

final mockShopWalletGBP = Fragment$shopWallet(balance: 700, currency: "GBP");

final mockShopWallets = [
  mockShopWalletUSD,
  mockShopWalletEUR,
  mockShopWalletGBP,
];

final mockParkingWalletUSD = Fragment$parkingWallet(
  balance: 500,
  currency: "USD",
);

final mockParkingWalletEUR = Fragment$parkingWallet(
  balance: 600,
  currency: "EUR",
);

final mockParkingWalletGBP = Fragment$parkingWallet(
  balance: 700,
  currency: "GBP",
);

final mockParkingWallets = [
  mockParkingWalletUSD,
  mockParkingWalletEUR,
  mockParkingWalletGBP,
];
