import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_role_details.cubit.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/widgets/dropdown_staff_permission.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopPanelPermision extends StatelessWidget {
  final List<Enum$ShopPermission> enabledPermissions;

  const ShopPanelPermision({super.key, required this.enabledPermissions});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StaffRoleDetailsBloc>();
    return Column(
      children: [
        DropdownStaffPermission(
          title: context.tr.shop,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$ShopPermission.SHOP_VIEW,
          editEntity: Enum$ShopPermission.SHOP_EDIT,
          onChanged: bloc.updateShopPermission,
        ),
        const SizedBox(height: 16),
        DropdownStaffPermission(
          title: context.tr.orders,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$ShopPermission.ORDER_VIEW,
          editEntity: Enum$ShopPermission.ORDER_EDIT,
          onChanged: bloc.updateShopPermission,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
