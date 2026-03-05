import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.dart';

extension ShopSupportRequestDetailX on Fragment$shopSupportRequestDetail {
  String senderName(BuildContext context) => requestedByShop
      ? (cart?.shop.name ?? context.tr.unknown)
      : (order.customer.fullName);

  String senderTitle(BuildContext context) =>
      requestedByShop ? context.tr.shop : context.tr.customer;
}

extension ShopSupportRequestX on Fragment$shopSupportRequest {
  String senderName(BuildContext context) => requestedByShop
      ? (cart?.shop.name ?? context.tr.unknown)
      : (order.customer.fullName);

  String senderTitle(BuildContext context) =>
      requestedByShop ? context.tr.shop : context.tr.customer;
}
