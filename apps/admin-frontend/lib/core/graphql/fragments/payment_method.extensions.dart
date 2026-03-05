import 'package:admin_frontend/core/enums/saved_payment_method_provider_brand.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/entities/payment_processor.entity.dart';

import 'package:admin_frontend/core/graphql/fragments/payment_method.fragment.graphql.dart';
import 'package:better_icons/better_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

extension PaymentMethodX on Fragment$PaymentMethod {
  PaymentMethodEntity get entity => switch (this) {
    Fragment$PaymentMethod$$CashPaymentMethod() => PaymentMethodEntity(
      type: PaymentMethodType.cash,
      id: '0',
      title: 'Cash',
    ),
    Fragment$PaymentMethod$$WalletPaymentMethod() => PaymentMethodEntity(
      type: PaymentMethodType.walletCredit,
      id: '0',
      title: 'Wallet',
    ),
    Fragment$OnlinePaymentMethod(:final id, :final name, :final imageUrl) =>
      PaymentMethodEntity(
        type: PaymentMethodType.onlineGateway,
        id: id,
        title: name,
        logoUrl: imageUrl,
      ),
    Fragment$SavedAccount(:final id, :final name, :final providerBrand) =>
      PaymentMethodEntity(
        type: PaymentMethodType.savedCard,
        id: id,
        title: name,
        card: switch (providerBrand) {
          Enum$ProviderBrand.Visa => PaymentMethodCard.visa,
          Enum$ProviderBrand.Mastercard => PaymentMethodCard.mastercard,
          Enum$ProviderBrand.Amex => PaymentMethodCard.amex,
          Enum$ProviderBrand.Discover => PaymentMethodCard.discover,
          _ => throw Exception('Unknown card brand: $providerBrand'),
        },
      ),
    _ => throw Exception('Unknown payment method type: $this'),
  };

  PaymentProcessorEntity? get paymentProcessor => switch (this) {
    Fragment$PaymentMethod$$OnlinePaymentMethod(
      :final id,
      :final name,
      :final imageUrl,
      :final linkMethod,
    ) =>
      PaymentProcessorEntity(
        id: id,
        name: name,
        logoUrl: imageUrl,
        linkMethod: switch (linkMethod) {
          Enum$GatewayLinkMethod.redirect =>
            PaymentProcessorLinkMethod.redirect,
          Enum$GatewayLinkMethod.manual => PaymentProcessorLinkMethod.manual,
          Enum$GatewayLinkMethod.none => PaymentProcessorLinkMethod.none,
          _ => throw Exception('Unknown gateway link method: $linkMethod'),
        },
      ),
    _ => null,
  };

  Widget tableViewPaymentMethod(BuildContext context) => switch (this) {
    Fragment$PaymentMethod$$CashPaymentMethod() => Row(
      children: [
        Icon(
          BetterIcons.wallet01Filled,
          color: context.colors.primary,
          size: 16,
        ),
        const SizedBox(width: 4),
        Transform.translate(
          offset: const Offset(0, 0),
          child: Text(context.tr.wallet, style: context.textTheme.labelMedium),
        ),
      ],
    ),
    Fragment$PaymentMethod$$WalletPaymentMethod() => Row(
      children: [
        Icon(
          BetterIcons.wallet01Filled,
          color: context.colors.primary,
          size: 16,
        ),
        const SizedBox(width: 4),
        Transform.translate(
          offset: const Offset(0, -2),
          child: Text(context.tr.wallet, style: context.textTheme.labelMedium),
        ),
      ],
    ),
    Fragment$OnlinePaymentMethod(:final name, :final imageUrl) => Row(
      children: [
        if (imageUrl != null) ...[
          CachedNetworkImage(imageUrl: imageUrl, width: 16, height: 16),
          const SizedBox(width: 4),
        ],
        Transform.translate(
          offset: const Offset(0, -2),
          child: Text(name, style: context.textTheme.labelMedium),
        ),
      ],
    ),
    Fragment$SavedAccount(:final name, :final providerBrand) => Row(
      children: [
        if (providerBrand != null) ...[
          providerBrand.image.image(width: 16, height: 16),
          const SizedBox(width: 4),
        ],
        Transform.translate(
          offset: const Offset(0, -2),
          child: Text.rich(
            TextSpan(
              text: "${providerBrand!.name(context)} ${context.tr.endingWith} ",
              style: context.textTheme.labelMedium?.variant(context),
              children: [
                TextSpan(
                  text: name,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    _ => throw Exception('Unknown payment method type: $this'),
  };
}

extension PaymentMethodListX on List<Fragment$PaymentMethod> {
  List<PaymentMethodEntity> get entities => map((e) => e.entity).toList();

  List<Fragment$PaymentMethod$$OnlinePaymentMethod> get onlineMethods =>
      whereType<Fragment$PaymentMethod$$OnlinePaymentMethod>().toList();

  List<Fragment$SavedAccount> get savedAccounts =>
      whereType<Fragment$SavedAccount>().toList();

  List<PaymentProcessorEntity> get paymentProcessors =>
      map((e) => e.paymentProcessor).nonNulls.toList();
}
