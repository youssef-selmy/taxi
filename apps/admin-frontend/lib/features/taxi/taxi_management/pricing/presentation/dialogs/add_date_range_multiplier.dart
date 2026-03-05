import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_design_system/molecules/date_picker_field/date_picker_field.dart';
import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AddDateRangeMultiplierDialog extends StatefulWidget {
  const AddDateRangeMultiplierDialog({super.key});

  @override
  State<AddDateRangeMultiplierDialog> createState() =>
      _AddDateRangeMultiplierDialogState();
}

class _AddDateRangeMultiplierDialogState
    extends State<AddDateRangeMultiplierDialog> {
  final _formKey = GlobalKey<FormState>();
  DateTime? startTime;
  DateTime? endTime;
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
              Input$DateRangeMultiplierInput(
                startDate: startTime!.millisecondsSinceEpoch.toDouble(),
                endDate: endTime!.millisecondsSinceEpoch.toDouble(),
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
                  child: AppDatePickerField(
                    label: "${context.tr.fromDate}:",
                    initialValue: startTime,
                    validator: (p0) =>
                        p0 == null ? context.tr.fieldIsRequired : null,
                    onChanged: (value) {
                      startTime = value;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppDatePickerField(
                    label: "${context.tr.toDate}:",
                    initialValue: endTime,
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
