import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:better_localization/localizations.dart';

class CreateNewDriverBottomActions extends StatelessWidget {
  const CreateNewDriverBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewDriverBloc>();
    return BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AppOutlinedButton(
              onPressed: () {
                bloc.onPreviousPage();
              },
              text: context.tr.back,
              prefixIcon: BetterIcons.arrowLeft02Outline,
            ),
            state.stepperCurrentIndex == 1
                ? AppFilledButton(
                    text: context.tr.register,
                    onPressed: () {
                      bloc.onCreateDriver();
                    },
                  )
                : AppFilledButton(
                    text: context.tr.actionContinue,
                    onPressed: () {
                      bloc.onNextPage();
                    },
                  ),
          ],
        );
      },
    );
  }
}
