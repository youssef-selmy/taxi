import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.dart';

extension ComplaintFragmentProdX on Fragment$taxiSupportRequestDetail {
  String get senderName =>
      (requestedByDriver
          ? request.rider?.fullName
          : request.driver?.fullName) ??
      "-";

  String senderTitle(BuildContext context) =>
      (requestedByDriver ? context.tr.driver : context.tr.customer);
}

extension TaxiSupportRequestX on Fragment$taxiSupportRequest {
  String senderTitle(BuildContext context) =>
      (requestedByDriver ? context.tr.driver : context.tr.customer);
}
