import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

import 'package:admin_frontend/core/enums/weekday.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AddWeekdayMultiplierDialog extends StatefulWidget {
  const AddWeekdayMultiplierDialog({super.key});

  @override
  State<AddWeekdayMultiplierDialog> createState() =>
      _AddWeekdayMultiplierDialogState();
}

class _AddWeekdayMultiplierDialogState
    extends State<AddWeekdayMultiplierDialog> {
  final _formKey = GlobalKey<FormState>();
  Enum$Weekday? weekday;
  double? multiplier;

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      icon: BetterIcons.addCircleFilled,
      title: context.tr.addWeekdayMultiplier,
      primaryButton: AppFilledButton(
        text: context.tr.insert,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Navigator.of(context).pop(
              Input$WeekdayMultiplierInput(
                weekday: weekday!,
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
            AppDropdownField.single(
              items:
                  [
                        Enum$Weekday.Monday,
                        Enum$Weekday.Tuesday,
                        Enum$Weekday.Wednesday,
                        Enum$Weekday.Thursday,
                        Enum$Weekday.Friday,
                        Enum$Weekday.Saturday,
                        Enum$Weekday.Sunday,
                      ]
                      .map(
                        (e) =>
                            AppDropdownItem(title: e.name(context), value: e),
                      )
                      .toList(),
              validator: (p0) => p0 == null ? context.tr.invalidWeekday : null,
              onSaved: (p0) => weekday = p0,
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
