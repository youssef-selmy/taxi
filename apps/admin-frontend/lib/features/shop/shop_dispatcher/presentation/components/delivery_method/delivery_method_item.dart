import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_frontend/core/enums/delivery_method_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DeliveryMethodItem extends StatelessWidget {
  final Enum$DeliveryMethod deliveryMethod;
  final double price;
  final String currency;
  final bool isSelected;
  final Function(Enum$DeliveryMethod) onSelected;

  const DeliveryMethodItem({
    super.key,
    required this.deliveryMethod,
    required this.isSelected,
    required this.onSelected,
    required this.price,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return AppListItem(
      title: deliveryMethod.name(context),
      subtitle: deliveryMethod.description(context),
      trailing: Text(
        price.formatCurrency(currency),
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colors.primary,
        ),
      ),
      isSelected: isSelected,
      onTap: (value) => onSelected,
    );
  }
}
