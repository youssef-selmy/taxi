import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.dart';

final mockPaymentGatewayCompact1 = Fragment$paymentGatewayCompact(
  id: "1",
  media: ImageFaker().paymentGateway.paypal.toMedia,
  title: "Paypal",
);

final mockPaymentGatewayCompact2 = Fragment$paymentGatewayCompact(
  id: "2",
  media: ImageFaker().paymentGateway.stripe.toMedia,
  title: "Stripe",
);
