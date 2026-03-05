import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_staff_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/widgets/dropdown_fleet_staff_permisions.dart';
import 'package:admin_frontend/schema.graphql.dart';

class FleetStaffPermission extends StatelessWidget {
  const FleetStaffPermission({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FleetStaffDetailBloc>();
    return BlocBuilder<FleetStaffDetailBloc, FleetStaffDetailState>(
      builder: (context, state) {
        return Column(
          children: [
            DropdownFleetStaffPermission(
              title: context.tr.financialRecords,
              enabledPermissions: state.permissionFinancial,
              viewEntity: Enum$FleetStaffPermissionFinancial.CAN_VIEW,
              editEntity: Enum$FleetStaffPermissionFinancial.CAN_EDIT,
              none: Enum$FleetStaffPermissionFinancial.$unknown,
              onChanged: bloc.updateFinancialPermission,
            ),
            DropdownFleetStaffPermission(
              title: context.tr.orders,
              enabledPermissions: state.permissionOrder,
              viewEntity: Enum$FleetStaffPermissionOrder.CAN_VIEW,
              editEntity: Enum$FleetStaffPermissionOrder.CAN_EDIT,
              none: Enum$FleetStaffPermissionOrder.$unknown,
              onChanged: bloc.updateOrderPermission,
            ),
          ],
        );
      },
    );
  }
}
