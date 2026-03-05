import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/documents/config.graphql.dart';
import 'package:better_icons/better_icons.dart';

class DisableServerDialog extends StatelessWidget {
  final List<Mutation$updateLicense$updatePurchaseCode$clients> clients;

  const DisableServerDialog({super.key, required this.clients});

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      onClosePressed: () => context.router.maybePop(),
      iconColor: SemanticColor.warning,
      primaryButton: AppFilledButton(
        text: context.tr.confirm,
        onPressed: () {},
      ),
      secondaryButton: OutlinedButton(
        onPressed: () => context.router.maybePop(),
        child: Text(context.tr.cancel),
      ),
      icon: BetterIcons.alertCircleFilled,
      title: context.tr.disableServer,
      subtitle: context.tr.licenseActiveElsewherePrompt,
      child: AppDropdownField.single(
        items: clients
            .map((e) => AppDropdownItem(title: e.ip, value: e.ip))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }
}
