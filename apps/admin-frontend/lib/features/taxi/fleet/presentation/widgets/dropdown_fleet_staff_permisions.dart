import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class DropdownFleetStaffPermission<T> extends StatelessWidget {
  final String title;
  final T viewEntity;
  final T editEntity;
  final T none;
  final T enabledPermissions;
  final Function(T addPermissions) onChanged;

  const DropdownFleetStaffPermission({
    super.key,
    required this.title,
    required this.viewEntity,
    required this.editEntity,
    required this.onChanged,
    required this.enabledPermissions,
    required this.none,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(title, style: context.textTheme.labelMedium),
              ),
              Expanded(
                child: AppDropdownField<T?>(
                  type: DropdownFieldType.compact,
                  initialValue: [enabledPermissions],
                  hint: context.tr.choosePermission,
                  onChanged: (value) {
                    if (value == null) {
                      onChanged(none);
                      return;
                    }
                    if (value == viewEntity) {
                      onChanged(viewEntity);
                    } else if (value == editEntity) {
                      onChanged(editEntity);
                    } else {
                      onChanged(value);
                    }
                  },
                  items: [
                    AppDropdownItem(
                      title: context.tr.none,
                      subtitle: context.tr.noAccess,
                      value: null,
                      prefixIcon: BetterIcons.securityBlockOutline,
                    ),
                    AppDropdownItem(
                      title: context.tr.canView,
                      subtitle: context.tr.canViewOnly,
                      value: viewEntity,
                      prefixIcon: BetterIcons.viewFilled,
                    ),
                    AppDropdownItem(
                      title: context.tr.canEdit,
                      subtitle: context.tr.canViewAndEdit,
                      value: editEntity,
                      prefixIcon: BetterIcons.pencilEdit01Filled,
                    ),
                    // if (deleteEntity != null)
                    // AppDropdownItem(
                    //   title: 'Full Access',
                    //   value: deleteEntity != null ? [viewEntity, editEntity, deleteEntity] : [viewEntity, editEntity],
                    //   prefixIcon: BetterIcons.settingsFill,
                    // ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
