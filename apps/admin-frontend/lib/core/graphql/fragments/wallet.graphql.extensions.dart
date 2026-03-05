import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.dart';

extension CustomerWalletX on Fragment$customerWallet {
  WalletBalanceItem toWalletBalanceItem() {
    return WalletBalanceItem(currency: currency, balance: balance);
  }
}

extension CustomerWalletListX on List<Fragment$customerWallet> {
  List<WalletBalanceItem> toWalletBalanceItems() =>
      map((e) => e.toWalletBalanceItem()).toList();
}

extension DriverWalletX on Fragment$driverWallet {
  WalletBalanceItem toWalletBalanceItem() {
    return WalletBalanceItem(currency: currency, balance: balance);
  }
}

extension DriverWalletListX on List<Fragment$driverWallet> {
  List<WalletBalanceItem> toWalletBalanceItems() =>
      map((e) => e.toWalletBalanceItem()).toList();
}

extension AdminWalletX on Fragment$adminWallet {
  WalletBalanceItem toWalletBalanceItem() {
    return WalletBalanceItem(currency: currency, balance: balance);
  }
}

extension AdminWalletListX on List<Fragment$adminWallet> {
  List<WalletBalanceItem> toWalletBalanceItems() =>
      map((e) => e.toWalletBalanceItem()).toList();
}

extension FleetWalletX on Fragment$fleetWallet {
  WalletBalanceItem toWalletBalanceItem() {
    return WalletBalanceItem(currency: currency, balance: balance);
  }
}

extension FleetWalletListX on List<Fragment$fleetWallet> {
  List<WalletBalanceItem> toWalletBalanceItems() =>
      map((e) => e.toWalletBalanceItem()).toList();
}

extension ShopWalletX on Fragment$shopWallet {
  WalletBalanceItem toWalletBalanceItem() {
    return WalletBalanceItem(currency: currency, balance: balance);
  }
}

extension ShopWalletListX on List<Fragment$shopWallet> {
  List<WalletBalanceItem> toWalletBalanceItems() =>
      map((e) => e.toWalletBalanceItem()).toList();
}

extension ParkingWalletX on Fragment$parkingWallet {
  WalletBalanceItem toWalletBalanceItem() {
    return WalletBalanceItem(currency: currency, balance: balance);
  }
}

extension ParkingWalletListX on List<Fragment$parkingWallet> {
  List<WalletBalanceItem> toWalletBalanceItems() =>
      map((e) => e.toWalletBalanceItem()).toList();
}

extension WalletBalanceItemListX on List<WalletBalanceItem> {
  Wrap balanceText(BuildContext context) => map(
    (e) => e.balance.toCurrency(context, e.currency),
  ).toList().wrapWithCommas();
}
