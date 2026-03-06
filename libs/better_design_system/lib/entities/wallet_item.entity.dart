class WalletItemEntity {
  final String currency;
  final double balance;

  WalletItemEntity({required this.currency, required this.balance});

  // toJson method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {'currency': currency, 'balance': balance};
  }

  // fromJson method to create an object from a JSON map
  factory WalletItemEntity.fromJson(Map<String, dynamic> json) {
    return WalletItemEntity(
      currency: json['currency'] as String,
      balance: json['balance'] as double,
    );
  }

  // toString method for easy debugging
  @override
  String toString() {
    return 'WalletItem(currency: $currency, balance: $balance)';
  }

  // hashCode method for hashing the object
  @override
  int get hashCode {
    return currency.hashCode ^ balance.hashCode;
  }

  // equals method to compare two WalletItem objects
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletItemEntity &&
        other.currency == currency &&
        other.balance == balance;
  }
}

final mockWalletItem = WalletItemEntity(currency: 'USD', balance: 100.0);

final mockWalletItems = [
  WalletItemEntity(currency: 'USD', balance: 100.0),
  WalletItemEntity(currency: 'EUR', balance: 200.0),
  WalletItemEntity(currency: 'GBP', balance: 300.0),
];
