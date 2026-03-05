import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.dart';

extension ShopCategoryCompactListX on List<Fragment$shopCategoryCompact> {
  Widget toChips() => Wrap(
    spacing: 4,
    runSpacing: 4,
    children: map(
      (e) => AppTag(text: e.name, color: SemanticColor.neutral),
    ).toList(),
  );
}

extension ShopCategoryListItemListX on List<Fragment$shopItemCategoryListItem> {
  Widget toChips() => Wrap(
    spacing: 4,
    runSpacing: 4,
    children: map(
      (e) => AppTag(text: e.name, color: SemanticColor.neutral),
    ).toList(),
  );
}
