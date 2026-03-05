import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/saved_payment_method_provider_brand.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension PaymentMethodX on Enum$PaymentMode {
  String name(BuildContext context) {
    return switch (this) {
      Enum$PaymentMode.Cash => context.tr.cash,
      Enum$PaymentMode.SavedPaymentMethod => context.tr.savedCard,
      Enum$PaymentMode.PaymentGateway => context.tr.onlinePayment,
      Enum$PaymentMode.Wallet => context.tr.wallet,
      Enum$PaymentMode.$unknown => context.tr.unknown,
    };
  }

  Widget icon({
    required BuildContext context,
    required Fragment$SavedPaymentMethod? savedPaymentMethod,
    required Fragment$paymentGatewayCompact? paymentGateway,
    double size = 16,
  }) {
    return switch (this) {
      Enum$PaymentMode.Cash => Icon(
        BetterIcons.wallet01Filled,
        color: context.colors.primary,
        size: size,
      ),
      Enum$PaymentMode.SavedPaymentMethod =>
        savedPaymentMethod?.providerBrand?.image.image(
              width: size,
              height: size,
            ) ??
            Icon(
              BetterIcons.creditCardFilled,
              color: context.colors.primary,
              size: size,
            ),
      Enum$PaymentMode.PaymentGateway =>
        paymentGateway?.media.widget(height: 16, width: 16) ??
            Icon(
              BetterIcons.creditCardFilled,
              color: context.colors.primary,
              size: size,
            ),
      Enum$PaymentMode.Wallet => Icon(
        BetterIcons.wallet01Filled,
        color: context.colors.primary,
        size: size,
      ),
      Enum$PaymentMode.$unknown => const Icon(Icons.error),
    };
  }

  Widget tableViewPaymentMethod(
    BuildContext context,
    Fragment$SavedPaymentMethod? savedPaymentMethod,
    Fragment$paymentGatewayCompact? paymentGateway,
  ) {
    return switch (this) {
      Enum$PaymentMode.Cash => Row(
        children: [
          Icon(
            BetterIcons.wallet01Filled,
            color: context.colors.primary,
            size: 16,
          ),
          const SizedBox(width: 4),
          Transform.translate(
            offset: const Offset(0, 0),
            child: Text(
              context.tr.wallet,
              style: context.textTheme.labelMedium,
            ),
          ),
        ],
      ),
      Enum$PaymentMode.SavedPaymentMethod => savedPaymentMethod!.tableView(
        context,
      ),
      Enum$PaymentMode.PaymentGateway => paymentGateway!.tableView(context),
      Enum$PaymentMode.Wallet => Row(
        children: [
          Icon(
            BetterIcons.wallet01Filled,
            color: context.colors.primary,
            size: 16,
          ),
          const SizedBox(width: 4),
          Transform.translate(
            offset: const Offset(0, -2),
            child: Text(
              context.tr.wallet,
              style: context.textTheme.labelMedium,
            ),
          ),
        ],
      ),
      Enum$PaymentMode.$unknown => Text(context.tr.unknown),
    };
  }
}
