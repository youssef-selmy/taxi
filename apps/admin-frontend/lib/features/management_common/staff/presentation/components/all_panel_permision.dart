import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_role_details.cubit.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/widgets/dropdown_staff_permission.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AllPanelPermision extends StatelessWidget {
  final List<Enum$OperatorPermission> enabledPermissions;

  const AllPanelPermision({super.key, required this.enabledPermissions});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StaffRoleDetailsBloc>();
    return Column(
      children: [
        DropdownStaffPermission(
          title: "Critical Admin Access",
          helpText: "Access system-level sections (Overview, License, Logs)",
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.Critical_View,
          editEntity: Enum$OperatorPermission.Critical_Edit,
          onChanged: bloc.updateCommonPermission,
        ),
        const SizedBox(height: 16),
        DropdownStaffPermission(
          title: context.tr.customers,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.Riders_View,
          editEntity: Enum$OperatorPermission.Riders_Edit,
          onChanged: bloc.updateCommonPermission,
        ),
        DropdownStaffPermission(
          title: context.tr.staff,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.Users_View,
          editEntity: Enum$OperatorPermission.Users_Edit,
          onChanged: bloc.updateCommonPermission,
        ),
        DropdownStaffPermission(
          title: context.tr.smsProviders,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.SMSProviders_View,
          editEntity: Enum$OperatorPermission.SMSProviders_Edit,
          onChanged: bloc.updateCommonPermission,
        ),
        DropdownStaffPermission(
          title: context.tr.emailProviders,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.EmailProviders_View,
          editEntity: Enum$OperatorPermission.EmailProviders_Edit,
          onChanged: bloc.updateCommonPermission,
        ),
        DropdownStaffPermission(
          title: context.tr.emailTemplates,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.EmailTemplates_View,
          editEntity: Enum$OperatorPermission.EmailTemplates_Edit,
          onChanged: bloc.updateCommonPermission,
        ),
        DropdownStaffPermission(
          title: context.tr.announcements,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.Announcements_View,
          editEntity: Enum$OperatorPermission.Announcements_Edit,
          onChanged: bloc.updateCommonPermission,
        ),
        DropdownStaffPermission(
          title: context.tr.coupons,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.Coupons_View,
          editEntity: Enum$OperatorPermission.Coupons_Edit,
          onChanged: bloc.updateCommonPermission,
        ),
        DropdownStaffPermission(
          title: context.tr.giftCards,
          enabledPermissions: enabledPermissions,
          viewEntity: Enum$OperatorPermission.GiftBatch_View,
          editEntity: Enum$OperatorPermission.GiftBatch_Create,
          onChanged: bloc.updateCommonPermission,
        ),
      ],
    );
  }
}
