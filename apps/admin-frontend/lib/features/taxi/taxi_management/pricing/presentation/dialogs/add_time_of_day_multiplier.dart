import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_localization/localizations.dart';
import 'package:better_design_system/atoms/input_fields/time_field/time_field.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AddTimeOfDayMultiplierDialog extends StatefulWidget {
  const AddTimeOfDayMultiplierDialog({super.key});

  @override
  State<AddTimeOfDayMultiplierDialog> createState() =>
      _AddTimeOfDayMultiplierDialogState();
}

class _AddTimeOfDayMultiplierDialogState
    extends State<AddTimeOfDayMultiplierDialog> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  double? multiplier;

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      maxWidth: 600,
      icon: BetterIcons.addCircleFilled,
      title: context.tr.addTimeOfDayMultiplier,
      primaryButton: AppFilledButton(
        text: context.tr.insert,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Navigator.of(context).pop(
              Input$TimeMultiplierInput(
                startTime: startTime!.format(context),
                endTime: endTime!.format(context),
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
            Row(
              children: [
                Expanded(
                  child: AppTimeField(
                    label: "${context.tr.startTime}:",
                    defaultValue: startTime,
                    validator: (p0) =>
                        p0 == null ? context.tr.fieldIsRequired : null,
                    onChanged: (value) {
                      startTime = value;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTimeField(
                    label: "${context.tr.endTime}:",
                    defaultValue: endTime,
                    validator: (p0) =>
                        p0 == null ? context.tr.fieldIsRequired : null,
                    onChanged: (value) {
                      endTime = value;
                    },
                  ),
                ),
              ],
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
