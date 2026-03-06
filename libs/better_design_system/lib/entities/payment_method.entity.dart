import 'package:better_assets/assets.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

enum PaymentMethodType {
  onlineGateway,
  savedCard,
  payoutMethod,
  cash,
  walletCredit,
}

enum PaymentMethodCard {
  visa,
  mastercard,
  amex,
  discover,
  maestro,
  jcb;

  AssetGenImage get logo => switch (this) {
    PaymentMethodCard.visa => Assets.images.paymentMethods.visaPng,
    PaymentMethodCard.mastercard => Assets.images.paymentMethods.mastercardPng,
    PaymentMethodCard.amex => Assets.images.paymentMethods.stripe,
    PaymentMethodCard.discover => Assets.images.paymentMethods.stripe,
    PaymentMethodCard.maestro => Assets.images.paymentMethods.stripe,
    PaymentMethodCard.jcb => Assets.images.paymentMethods.stripe,
  };
}

final mockSavedPaymentMethod = PaymentMethodEntity(
  id: '1',
  title: 'Visa **** 1234',
  type: PaymentMethodType.savedCard,
  card: PaymentMethodCard.visa,
);
final mockOnlinePaymentMethod = PaymentMethodEntity(
  id: '2',
  title: 'PayPal',
  type: PaymentMethodType.onlineGateway,
);
final mockPayoutMethod = PaymentMethodEntity(
  id: '3',
  title: 'Bank Transfer',
  type: PaymentMethodType.payoutMethod,
  logoUrl: null,
);

class PaymentMethodEntity {
  final String id;
  final String title;
  final PaymentMethodType type;
  final String? logoUrl;
  final PaymentMethodCard? card;
  final String? holderName;
  final String? expirationDate;

  PaymentMethodEntity({
    required this.id,
    required this.title,
    required this.type,
    this.holderName,
    this.expirationDate,
    this.logoUrl,
    this.card,
  });

  factory PaymentMethodEntity.cash() {
    return PaymentMethodEntity(
      id: 'cash',
      title: 'Direct Payment',
      type: PaymentMethodType.cash,
    );
  }

  factory PaymentMethodEntity.walletCredit() {
    return PaymentMethodEntity(
      id: 'wallet_credit',
      title: 'Wallet Credit',
      type: PaymentMethodType.walletCredit,
    );
  }

  // fromJson
  factory PaymentMethodEntity.fromJson(Map<String, dynamic> json) {
    return PaymentMethodEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      type: PaymentMethodType.values.firstWhere(
        (e) => e.name == json['type'] as String,
      ),
      logoUrl: json['logoUrl'] as String?,
      card: json['card'] != null
          ? PaymentMethodCard.values.firstWhere(
              (e) => e.name == json['card'] as String,
            )
          : null,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type.name,
      'logoUrl': logoUrl,
      'card': card?.name,
    };
  }

  // copyWith
  PaymentMethodEntity copyWith({
    String? id,
    String? title,
    PaymentMethodType? type,
    String? logoUrl,
    PaymentMethodCard? card,
  }) {
    return PaymentMethodEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      logoUrl: logoUrl ?? this.logoUrl,
      card: card ?? this.card,
    );
  }

  // toString
  @override
  String toString() {
    return 'PaymentMethodEntity(id: $id, title: $title, type: $type, logoUrl: $logoUrl, card: $card)';
  }

  // hashCode
  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        logoUrl.hashCode ^
        card.hashCode;
  }

  // equals
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is! PaymentMethodEntity) return false;

    return id == other.id &&
        title == other.title &&
        type == other.type &&
        logoUrl == other.logoUrl &&
        card == other.card;
  }

  IconData get iconData => switch (type) {
    PaymentMethodType.onlineGateway => BetterIcons.globalFilled,
    PaymentMethodType.savedCard => BetterIcons.creditCardFilled,
    PaymentMethodType.payoutMethod => BetterIcons.wallet01Filled,
    PaymentMethodType.cash => BetterIcons.money03Filled,
    PaymentMethodType.walletCredit => BetterIcons.wallet01Filled,
  };

  Widget icon({Color? color, double size = 24}) => switch (type) {
    PaymentMethodType.walletCredit => Icon(
      BetterIcons.wallet01Filled,
      size: size,
      color: color,
    ),
    PaymentMethodType.cash => Icon(
      BetterIcons.money03Filled,
      size: size,
      color: color,
    ),
    PaymentMethodType.savedCard =>
      card?.logo.image(width: size, height: size) ??
          Icon(BetterIcons.creditCardFilled, size: size, color: color),
    PaymentMethodType.onlineGateway =>
      logoUrl != null
          ? CachedNetworkImage(
              imageUrl: logoUrl!,
              width: size,
              height: size,
              errorWidget: (context, url, error) => Icon(
                BetterIcons.alert02Filled,
                size: size,
                color: context.colors.onSurfaceVariantLow,
              ),
            )
          : const SizedBox(),
    PaymentMethodType.payoutMethod => Icon(
      BetterIcons.wallet01Filled,
      size: size,
      color: color,
    ),
  };
}

final mockPaymentMethodPayPal = PaymentMethodEntity(
  id: "1",
  type: PaymentMethodType.onlineGateway,
  title: "PayPal",
  logoUrl: ImageFaker().paymentGateway.paypal,
);

final mockPaymentMethodVisa = PaymentMethodEntity(
  id: "2",
  type: PaymentMethodType.savedCard,
  title: "Visa **** 1234",
  card: PaymentMethodCard.visa,
);

final mockPaymentMethods = [mockPaymentMethodPayPal, mockPaymentMethodVisa];
