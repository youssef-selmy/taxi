import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_role_details.cubit.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/widgets/dropdown_staff_permission.dart';
import 'package:admin_frontend/schema.graphql.dart';

class TaxiPanelPermision extends StatelessWidget {
  final List<Enum$TaxiPermission> enabledPermissions;

  const TaxiPanelPermision({super.key, required this.enabledPermissions});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StaffRoleDetailsBloc>();
    return Column(
      children: [
        DropdownStaffPermission(
          title: context.tr.drivers,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$TaxiPermission.DRIVER_VIEW,
          editEntity: Enum$TaxiPermission.DRIVER_EDIT,
          onChanged: bloc.updateTaxiPermission,
        ),
        const SizedBox(height: 16),
        DropdownStaffPermission(
          title: context.tr.orders,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$TaxiPermission.ORDER_VIEW,
          editEntity: Enum$TaxiPermission.ORDER_EDIT,
          onChanged: bloc.updateTaxiPermission,
        ),
        const SizedBox(height: 16),
        DropdownStaffPermission(
          title: context.tr.fleets,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$TaxiPermission.FLEET_VIEW,
          editEntity: Enum$TaxiPermission.FLEET_EDIT,
          onChanged: bloc.updateTaxiPermission,
        ),
        const SizedBox(height: 16),
        DropdownStaffPermission(
          title: context.tr.pricing,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$TaxiPermission.PRICING_VIEW,
          editEntity: Enum$TaxiPermission.PRICING_EDIT,
          onChanged: bloc.updateTaxiPermission,
        ),
        const SizedBox(height: 16),
        DropdownStaffPermission(
          title: context.tr.regions,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$TaxiPermission.REGION_VIEW,
          editEntity: Enum$TaxiPermission.REGION_EDIT,
          onChanged: bloc.updateTaxiPermission,
        ),
        const SizedBox(height: 16),
        DropdownStaffPermission(
          title: context.tr.vehicles,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$TaxiPermission.VEHICLE_VIEW,
          editEntity: Enum$TaxiPermission.VEHICLE_EDIT,
          onChanged: bloc.updateTaxiPermission,
        ),
      ],
    );
  }
}
