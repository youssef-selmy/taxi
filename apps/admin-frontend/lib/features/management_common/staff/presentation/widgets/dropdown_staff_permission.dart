import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class DropdownStaffPermission<T> extends StatelessWidget {
  final String title;
  final String? helpText;
  final T viewEntity;
  final T editEntity;
  final List<T> enabledPermissions;
  final Function(List<T> addPermissions, List<T> removePermissions) onChanged;

  const DropdownStaffPermission({
    super.key,
    required this.title,
    this.helpText,
    required this.viewEntity,
    required this.editEntity,
    required this.onChanged,
    required this.enabledPermissions,
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
                child: Text(title, style: context.textTheme.labelMedium),
              ),
              Expanded(
                child: AppDropdownField.single(
                  type: DropdownFieldType.compact,
                  helpText: helpText,
                  initialValue:
                      enabledPermissions
                          .where((element) => element == editEntity)
                          .isNotEmpty
                      ? editEntity
                      : enabledPermissions
                            .where((element) => element == viewEntity)
                            .isNotEmpty
                      ? viewEntity
                      : null,
                  hint: context.tr.choosePermission,
                  onChanged: (value) {
                    if (value == null) {
                      // None: remove both permissions
                      onChanged([], [viewEntity, editEntity]);
                      return;
                    }
                    if (value == viewEntity) {
                      // Can View: remove both, add only view
                      onChanged([viewEntity], [viewEntity, editEntity]);
                    } else if (value == editEntity) {
                      // Can Edit: remove both, add both
                      onChanged([viewEntity, editEntity], [viewEntity, editEntity]);
                    } else {
                      onChanged([value], []);
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
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
