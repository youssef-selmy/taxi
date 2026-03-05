import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension PaymentGatewayTypeX on Enum$PaymentGatewayType {
  String name(BuildContext context) => switch (this) {
    Enum$PaymentGatewayType.PayPal => 'PayPal',
    Enum$PaymentGatewayType.Stripe => 'Stripe',
    Enum$PaymentGatewayType.BrainTree => 'BrainTree',
    Enum$PaymentGatewayType.Paytm => 'Paytm',
    Enum$PaymentGatewayType.Razorpay => 'Razorpay',
    Enum$PaymentGatewayType.Paystack => 'Paystack',
    Enum$PaymentGatewayType.PayU => 'PayU',
    Enum$PaymentGatewayType.Instamojo => 'Instamojo',
    Enum$PaymentGatewayType.Flutterwave => 'Flutterwave',
    Enum$PaymentGatewayType.PayGate => 'PayGate',
    Enum$PaymentGatewayType.MIPS => 'MIPS',
    Enum$PaymentGatewayType.MercadoPago => 'MercadoPago',
    Enum$PaymentGatewayType.AmazonPaymentServices => 'AmazonPaymentServices',
    Enum$PaymentGatewayType.MyTMoney => 'MyTMoney',
    Enum$PaymentGatewayType.WayForPay => 'WayForPay',
    Enum$PaymentGatewayType.MyFatoorah => 'MyFatoorah',
    Enum$PaymentGatewayType.SberBank => 'SberBank',
    Enum$PaymentGatewayType.BinancePay => 'BinancePay',
    Enum$PaymentGatewayType.OpenPix => 'OpenPix',
    Enum$PaymentGatewayType.PayTR => 'PayTR',
    Enum$PaymentGatewayType.BambooPay => 'BambooPay',
    Enum$PaymentGatewayType.CustomLink => 'CustomLink',
    Enum$PaymentGatewayType.$unknown => context.tr.unknown,
  };

  PaymentGatewayApiKeys apiKeys(BuildContext context) => switch (this) {
    Enum$PaymentGatewayType.AmazonPaymentServices => PaymentGatewayApiKeys(
      privateKey: "Access Code",
      merchantId: "Merchant Identifier",
    ),
    Enum$PaymentGatewayType.BrainTree => PaymentGatewayApiKeys(
      privateKey: "Private key",
      publicKey: "Public key",
      merchantId: "Merchant ID",
    ),
    Enum$PaymentGatewayType.CustomLink => PaymentGatewayApiKeys(
      privateKey: "URL",
    ),
    Enum$PaymentGatewayType.Flutterwave => PaymentGatewayApiKeys(
      privateKey: "Secret Key",
    ),
    Enum$PaymentGatewayType.Instamojo => PaymentGatewayApiKeys(
      privateKey: "Auth Key",
      publicKey: "API Key",
    ),
    Enum$PaymentGatewayType.MIPS => PaymentGatewayApiKeys(
      privateKey: "Cipher key",
      saltKey: "Salt key",
      publicKey: "Form ID",
      merchantId: "Merchant ID",
    ),
    Enum$PaymentGatewayType.MercadoPago => PaymentGatewayApiKeys(
      publicKey: "Public key",
      privateKey: "Access Token",
    ),
    Enum$PaymentGatewayType.PayTR => PaymentGatewayApiKeys(
      merchantId: "Merchant ID",
      privateKey: "Merchant key",
      saltKey: "Merchant salt",
    ),
    Enum$PaymentGatewayType.MyFatoorah => PaymentGatewayApiKeys(
      privateKey: "Private key",
      merchantId: "Payment Method code",
    ),
    Enum$PaymentGatewayType.MyTMoney => PaymentGatewayApiKeys(
      publicKey: "Public key",
      privateKey: "Private key",
      merchantId: "App Id",
    ),
    Enum$PaymentGatewayType.PayGate => PaymentGatewayApiKeys(
      privateKey: "Secret Key",
    ),
    Enum$PaymentGatewayType.PayPal => PaymentGatewayApiKeys(
      privateKey: "Client Secret",
      merchantId: "Client ID",
    ),
    Enum$PaymentGatewayType.PayU => PaymentGatewayApiKeys(
      privateKey: "Client secret",
      merchantId: "Merchant Pos Id",
    ),
    Enum$PaymentGatewayType.Paystack => PaymentGatewayApiKeys(
      privateKey: "API Key",
    ),
    Enum$PaymentGatewayType.Paytm => PaymentGatewayApiKeys(
      privateKey: "Merchant Key",
      merchantId: "Merchant Id",
    ),
    Enum$PaymentGatewayType.Razorpay => PaymentGatewayApiKeys(
      privateKey: "Key Secret",
      merchantId: "Key Id",
    ),
    Enum$PaymentGatewayType.SberBank => PaymentGatewayApiKeys(
      publicKey: "Username",
      privateKey: "Password",
    ),
    Enum$PaymentGatewayType.Stripe => PaymentGatewayApiKeys(
      privateKey: "API key",
    ),
    Enum$PaymentGatewayType.WayForPay => PaymentGatewayApiKeys(
      privateKey: "Merchant secret Key",
      publicKey: "Merchant domain name",
      merchantId: "Merchant Id",
    ),
    Enum$PaymentGatewayType.BinancePay => PaymentGatewayApiKeys(
      publicKey: "API Key",
      privateKey: "Secret Key",
    ),
    Enum$PaymentGatewayType.OpenPix => PaymentGatewayApiKeys(
      privateKey: "AppID",
    ),
    Enum$PaymentGatewayType.BambooPay => PaymentGatewayApiKeys(
      privateKey: "Password",
      publicKey: "Username",
      merchantId: "Merchant ID",
      saltKey: "Merchant Account",
    ),
    Enum$PaymentGatewayType.$unknown => PaymentGatewayApiKeys(
      privateKey: context.tr.pleaseUpdateYourAppToSupportThisPaymentGateway,
    ),
  };
}

class PaymentGatewayApiKeys {
  final String privateKey;
  final String? publicKey;
  final String? merchantId;
  final String? saltKey;

  PaymentGatewayApiKeys({
    required this.privateKey,
    this.publicKey,
    this.merchantId,
    this.saltKey,
  });

  int get length =>
      [privateKey, publicKey, merchantId, saltKey].nonNulls.length;
}
