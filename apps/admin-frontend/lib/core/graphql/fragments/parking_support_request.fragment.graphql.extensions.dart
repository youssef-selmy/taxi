import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.dart';

extension ParkingSupportRequestDetailX on Fragment$parkingSupportRequestDetail {
  String senderName(BuildContext context) => requestedByOwner
      ? (parkOrder.spotOwner?.fullName ?? context.tr.unknown)
      : (parkOrder.carOwner?.fullName ?? context.tr.unknown);

  String senderTitle(BuildContext context) =>
      requestedByOwner ? context.tr.parking : context.tr.customer;
}

extension ParkingSupportRequestX on Fragment$parkingSupportRequest {
  String senderName(BuildContext context) => requestedByOwner
      ? (parkOrder.spotOwner?.fullName ?? context.tr.unknown)
      : (parkOrder.carOwner?.fullName ?? context.tr.unknown);

  String senderTitle(BuildContext context) =>
      requestedByOwner ? context.tr.parking : context.tr.customer;
}
