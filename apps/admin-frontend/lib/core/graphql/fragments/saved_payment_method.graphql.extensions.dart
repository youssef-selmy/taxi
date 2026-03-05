import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/saved_payment_method_provider_brand.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.dart';

extension SavedPaymentMethodFragmentX on Fragment$SavedPaymentMethod {
  String title(BuildContext context) {
    return "${providerBrand!.name(context)} ${context.tr.endingWith} $lastFour";
  }

  Widget tableView(BuildContext context) {
    return Row(
      children: [
        if (providerBrand != null) ...[
          providerBrand!.image.image(width: 16, height: 16),
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
                  text: lastFour ?? "",
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
