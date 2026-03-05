import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockPaymentGatewayListItem1 = Fragment$paymentGatewayListItem(
  id: '1',
  title: 'PayPal',
  type: Enum$PaymentGatewayType.PayPal,
  media: ImageFaker().paymentGateway.paypal.toMedia,
  enabled: true,
  totalTransactions: [
    Fragment$paymentGatewayListItem$totalTransactions(
      sum: Fragment$paymentGatewayListItem$totalTransactions$sum(amount: 1500),
      groupBy: Fragment$paymentGatewayListItem$totalTransactions$groupBy(
        currency: 'USD',
      ),
    ),
  ],
);

final mockPaymentGatewayListItem2 = Fragment$paymentGatewayListItem(
  id: '2',
  title: 'Stripe',
  type: Enum$PaymentGatewayType.Stripe,
  media: ImageFaker().paymentGateway.stripe.toMedia,
  enabled: false,
  totalTransactions: [
    Fragment$paymentGatewayListItem$totalTransactions(
      sum: Fragment$paymentGatewayListItem$totalTransactions$sum(amount: 2000),
      groupBy: Fragment$paymentGatewayListItem$totalTransactions$groupBy(
        currency: 'USD',
      ),
    ),
  ],
);

final mockPaymentGatewayList = [
  mockPaymentGatewayListItem1,
  mockPaymentGatewayListItem2,
];

final mockPaymentGatewayDetails = Fragment$paymentGatewayDetails(
  id: "1",
  title: "PayPal",
  privateKey: "privateKey",
  publicKey: "publicKey",
  media: ImageFaker().paymentGateway.paypal.toMedia,
  saltKey: "saltKey",
  merchantId: "merchantId",
  enabled: true,
  type: Enum$PaymentGatewayType.PayPal,
);
