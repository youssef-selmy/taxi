import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension CampaignCriteriaOrdersTypeX on Enum$CampaignCriteriaOrdersType {
  String title(BuildContext context) {
    switch (this) {
      case Enum$CampaignCriteriaOrdersType.OrderCountLessThan:
        return "Order Count Less Than";
      case Enum$CampaignCriteriaOrdersType.OrderCountMoreThan:
        return "Order Count More Than";
      case Enum$CampaignCriteriaOrdersType.PurchaseAmountLessThan:
        return "Purchase Amount Less Than";
      case Enum$CampaignCriteriaOrdersType.PurchaseAmountMoreThan:
        return "Purchase Amount More Than";
      case Enum$CampaignCriteriaOrdersType.$unknown:
        return context.tr.unknown;
    }
  }
}
