import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class FleetStaffPasswordTab extends StatelessWidget {
  const FleetStaffPasswordTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTextField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                maxLines: 1,
                label: context.tr.password,
                hint: context.tr.enterPassword,
                onChanged: (value) {
                  // context.read<StaffListBloc>().onPasswordChanged(value);
                },
              ),
              const SizedBox(height: 8),
              AppTextButton(onPressed: () {}, text: context.tr.forgotPassword),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppFilledButton(text: context.tr.submit, onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
