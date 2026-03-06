import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/widgets.dart';
import 'package:time/time.dart';

class WalletActivityItemEntity {
  final String title;
  final String currency;
  final double amount;
  final DateTime date;
  final IconData icon;
  final SemanticColor iconColor;

  WalletActivityItemEntity({
    required this.title,
    required this.currency,
    required this.amount,
    required this.date,
    required this.icon,
    required this.iconColor,
  });

  // hashCode method for hashing the object
  @override
  int get hashCode {
    return currency.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        icon.hashCode ^
        iconColor.hashCode;
  }

  // equals method to compare two WalletActivityItem objects
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletActivityItemEntity &&
        other.currency == currency &&
        other.amount == amount &&
        other.date == date &&
        other.icon == icon &&
        other.iconColor == iconColor;
  }
}

final mockWalletActivityItem1 = WalletActivityItemEntity(
  title: 'Wallet Topup',
  currency: 'USD',
  amount: 100.0,
  date: 5.hours.ago,
  icon: BetterIcons.wallet01Filled,
  iconColor: SemanticColor.neutral,
);

final mockWalletActivityItem2 = WalletActivityItemEntity(
  title: 'Ride',
  currency: 'USD',
  amount: -12.42,
  date: 3.hours.ago,
  icon: BetterIcons.car01Filled,
  iconColor: SemanticColor.primary,
);

final mockWalletActivityItem3 = WalletActivityItemEntity(
  title: 'Wallet Topup',
  currency: 'USD',
  amount: 20,
  date: 300.minutes.ago,
  icon: BetterIcons.wallet01Filled,
  iconColor: SemanticColor.primary,
);

final mockWalletActivityItem4 = WalletActivityItemEntity(
  title: 'Ride',
  currency: 'JPY',
  amount: -400.0,
  date: 230.minutes.ago,
  icon: BetterIcons.wallet01Filled,
  iconColor: SemanticColor.primary,
);

final mockWalletActivityItem5 = WalletActivityItemEntity(
  title: 'Bank Transfer',
  currency: 'USD',
  amount: -93.2,
  date: 120.minutes.ago,
  icon: BetterIcons.bankFilled,
  iconColor: SemanticColor.primary,
);

final mockWalletActivityItems = [
  mockWalletActivityItem1,
  mockWalletActivityItem2,
  mockWalletActivityItem3,
  mockWalletActivityItem4,
  mockWalletActivityItem5,
];
