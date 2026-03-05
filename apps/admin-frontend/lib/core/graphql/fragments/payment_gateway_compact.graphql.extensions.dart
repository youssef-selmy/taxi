import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.dart';

extension PaymentGatewayCompactFragmentX on Fragment$paymentGatewayCompact {
  Widget tableView(BuildContext context) {
    return Row(
      children: [
        if (media != null) ...[
          CachedNetworkImage(imageUrl: media!.address, width: 16, height: 16),
          const SizedBox(width: 4),
        ],
        Transform.translate(
          offset: const Offset(0, -2),
          child: Text(title, style: context.textTheme.labelMedium),
        ),
      ],
    );
  }
}
