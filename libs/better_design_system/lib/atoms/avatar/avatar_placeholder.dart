import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

enum AvatarPlaceholder {
  none,
  user,
  category,
  product,
  shop,
  parking,
  car;

  IconData get icon => switch (this) {
    AvatarPlaceholder.none => BetterIcons.cancel01Filled,
    AvatarPlaceholder.user => BetterIcons.userFilled,
    AvatarPlaceholder.product => BetterIcons.shoppingBag02Filled,
    AvatarPlaceholder.category => BetterIcons.dashboardSquare01Filled,
    AvatarPlaceholder.shop => BetterIcons.store01Filled,
    AvatarPlaceholder.parking => BetterIcons.carParking01Filled,
    AvatarPlaceholder.car => BetterIcons.car05Filled,
  };
}
