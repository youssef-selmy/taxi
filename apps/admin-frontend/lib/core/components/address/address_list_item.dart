import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/molecules/list_item/list_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.extensions.dart';

class AddressListItem extends StatelessWidget {
  final Fragment$Address address;
  final Function(Fragment$Address) onSelected;

  const AddressListItem({
    super.key,
    required this.address,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppListItem(
        actionType: ListItemActionType.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: Icon(address.icon, color: context.colors.primary, size: 24),
        title: address.title,
        subtitle: address.details,
        onTap: (value) => onSelected(address),
      ),
    );
  }
}
