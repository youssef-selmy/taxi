import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockConfig = Fragment$Config(
  isValid: true,
  config: Fragment$Config$config(
    companyName: "BetterSuite",
    companyLogo: ImageFaker().appLogo.bettersuiteTyped,
    taxi: Fragment$AppConfigInfo(
      logo: ImageFaker().appLogo.taxi,
      name: "BetterTaxi",
      color: Enum$AppColorScheme.Cobalt,
    ),
    shop: Fragment$AppConfigInfo(
      logo: ImageFaker().appLogo.shop,
      name: "BetterShop",
      color: Enum$AppColorScheme.HyperPink,
    ),
    parking: Fragment$AppConfigInfo(
      logo: ImageFaker().appLogo.parking,
      name: "BetterParking",
      color: Enum$AppColorScheme.EarthyGreen,
    ),
  ),
);

final mockLicense = Fragment$license(
  license: Fragment$license$license(
    buyerName: "John Doe",
    licenseType: Enum$LicenseType.Extended,
    supportExpireDate: DateTime.now().add(const Duration(days: 365)),
    connectedApps: [Enum$AppType.Taxi, Enum$AppType.Shop, Enum$AppType.Parking],
    platformAddons: [Enum$PlatformAddOn.FleetAddOn],
  ),
  benefits: ["Customizable", "Publication Rights", "Commercial Use", "Support"],
  drawbacks: [
    "Premium Support Package",
    "Logo Design",
    "Customization",
    "Fleet add-on",
    "Upgrades",
  ],
  availableUpgrades: [
    Fragment$license$availableUpgrades(
      type: "Pro Plus",
      benefits: [
        "Premium Support Package",
        "Logo Design",
        "Customization",
        "Fleet add-on",
        "Bi-weekly meetings",
        "Upgrades",
      ],
      price: 8800,
    ),
  ],
);
