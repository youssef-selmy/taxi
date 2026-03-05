import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_role_details.cubit.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/widgets/dropdown_staff_permission.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingPanelPermision extends StatelessWidget {
  final List<Enum$ParkingPermission> enabledPermissions;

  const ParkingPanelPermision({super.key, required this.enabledPermissions});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StaffRoleDetailsBloc>();
    return Column(
      children: [
        DropdownStaffPermission(
          title: context.tr.parking,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$ParkingPermission.PARKING_VIEW,
          editEntity: Enum$ParkingPermission.PARKING_EDIT,
          onChanged: bloc.updateParkingPermission,
        ),
        const SizedBox(height: 16),
        DropdownStaffPermission(
          title: context.tr.orders,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$ParkingPermission.ORDER_VIEW,
          editEntity: Enum$ParkingPermission.ORDER_EDIT,
          onChanged: bloc.updateParkingPermission,
        ),
      ],
    );
  }
}
