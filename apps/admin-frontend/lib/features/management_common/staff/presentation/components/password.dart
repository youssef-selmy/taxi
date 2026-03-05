import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_details.cubit.dart';

class StaffPassword extends StatelessWidget {
  const StaffPassword({super.key});

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
                  context.read<StaffDetailsBloc>().onPasswordChanged(value);
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppFilledButton(
                    text: context.tr.submit,
                    onPressed: () {
                      context
                          .read<StaffDetailsBloc>()
                          .submitPasswordChangeRequest();
                    },
                  ),
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
