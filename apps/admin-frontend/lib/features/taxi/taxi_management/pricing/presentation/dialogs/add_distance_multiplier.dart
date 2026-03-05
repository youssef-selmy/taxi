import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AddDistanceMultiplierDialog extends StatefulWidget {
  const AddDistanceMultiplierDialog({super.key});

  @override
  State<AddDistanceMultiplierDialog> createState() =>
      _AddDistanceMultiplierDialogState();
}

class _AddDistanceMultiplierDialogState
    extends State<AddDistanceMultiplierDialog> {
  final _formKey = GlobalKey<FormState>();
  double? distanceFrom;
  double? distanceTo;
  double? multiplier;

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      icon: BetterIcons.addCircleFilled,
      title: context.tr.addDistanceMultiplier,
      primaryButton: AppFilledButton(
        text: context.tr.insert,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Navigator.of(context).pop(
              Input$DistanceMultiplierInput(
                distanceFrom: distanceFrom!,
                distanceTo: distanceTo!,
                multiply: multiplier!,
              ),
            );
          }
        },
      ),
      secondaryButton: AppOutlinedButton(
        text: context.tr.cancel,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppNumberField.integer(
              title: "${context.tr.distanceFrom}:",
              hint: context.tr.enterDistance,
              minValue: 0,
              validator: (p0) =>
                  p0 == null ? context.tr.distanceFromRequired : null,
              onSaved: (p0) => distanceFrom = p0?.toDouble(),
            ),
            const SizedBox(height: 16),
            AppNumberField.integer(
              title: "${context.tr.distanceTo}:",
              hint: context.tr.enterDistance,
              minValue: 0,
              validator: (p0) =>
                  p0 == null ? context.tr.distanceToRequired : null,
              onSaved: (p0) => distanceTo = p0?.toDouble(),
            ),
            const SizedBox(height: 16),
            AppNumberField(
              title: "${context.tr.multiplier}:",
              hint: context.tr.enterMultiplier,
              minValue: 0,
              maxValue: 10,
              validator: (p0) =>
                  p0 == null ? context.tr.multiplierRequired : null,
              onSaved: (p0) => multiplier = p0,
            ),
          ],
        ),
      ),
    );
  }
}
