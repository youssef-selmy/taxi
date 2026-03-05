import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.mock.dart';

final mockShopItemPreset1 = Fragment$shopItemPresetListItem(
  id: "1",
  name: "Breakfast",
  products: Fragment$shopItemPresetListItem$products(totalCount: 40),
);

final mockShopItemPreset2 = Fragment$shopItemPresetListItem(
  id: "2",
  name: "Lunch",
  products: Fragment$shopItemPresetListItem$products(totalCount: 30),
);

final mockShopItemPreset3 = Fragment$shopItemPresetListItem(
  id: "4",
  name: "Dinner",
  products: Fragment$shopItemPresetListItem$products(totalCount: 70),
);

final mockShopItemPresets = [
  mockShopItemPreset1,
  mockShopItemPreset2,
  mockShopItemPreset3,
];

final mockShopItemPresetDetail = Fragment$shopItemPresetDetail(
  id: "1",
  name: "Breakfast",
  weeklySchedule: mockWeekdaySchedules,
);
