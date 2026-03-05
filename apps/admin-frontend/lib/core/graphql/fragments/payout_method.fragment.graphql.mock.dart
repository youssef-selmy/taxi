import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockPayoutMethodListItem1 = Fragment$payoutMethodListItem(
  id: "1",
  name: "Stripe Connect",
  currency: "USD",
  enabled: true,
  media: ImageFaker().paymentGateway.stripe.toMedia,
  // payoutSessionsAggregate: [
  //   Fragment$payoutMethodListItem$payoutSessionsAggregate(
  //     sum: Fragment$payoutMethodListItem$payoutSessionsAggregate$sum(
  //       totalAmount: 155753,
  //     ),
  //   ),
  // ],
);

final mockPayoutMethodListItem2 = Fragment$payoutMethodListItem(
  id: "2",
  name: "Bank Transfer",
  currency: "EUR",
  enabled: true,
  // payoutSessionsAggregate: [
  //   Fragment$payoutMethodListItem$payoutSessionsAggregate(
  //     sum: Fragment$payoutMethodListItem$payoutSessionsAggregate$sum(
  //       totalAmount: 543021,
  //     ),
  //   ),
  // ],
);

final mockPayoutMethodListItems = [
  mockPayoutMethodListItem1,
  mockPayoutMethodListItem2,
];

final mockPayoutMethodDetail = Fragment$payoutMethodDetail(
  id: "1",
  name: "Stripe Connect",
  type: Enum$PayoutMethodType.Stripe,
  currency: "USD",
  saltKey: "SALT",
  privateKey: "PRIVATE",
  merchantId: "MERCHANT_ID",
);

final mockPayoutMethodCompact1 = Fragment$payoutMethodCompact(
  id: "1",
  name: "Stripe Connect",
  type: Enum$PayoutMethodType.Stripe,
  media: ImageFaker().paymentGateway.stripe.toMedia,
  currency: "USD",
);

final mockPayoutMethodCompact2 = Fragment$payoutMethodCompact(
  id: "2",
  name: "Bank Transfer",
  type: Enum$PayoutMethodType.BankTransfer,
  media: ImageFaker().paymentGateway.stripe.toMedia,
  currency: "USD",
);

final mockPayoutMethods = [mockPayoutMethodCompact1, mockPayoutMethodCompact2];
