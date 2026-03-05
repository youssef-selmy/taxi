import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/weekdays_open_hours_input.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_create_preset_dialog.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailUpsertPresetDialog extends StatelessWidget {
  final String shopId;
  final String? presetId;

  const ShopDetailUpsertPresetDialog({
    super.key,
    required this.shopId,
    required this.presetId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopDetailCreatePresetDialogBloc()
            ..onStarted(shopId: shopId, presetId: presetId),
      child:
          BlocConsumer<
            ShopDetailCreatePresetDialogBloc,
            ShopDetailCreatePresetDialogState
          >(
            listener: (context, state) {
              if (state.submitState.isLoaded) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return AppResponsiveDialog(
                icon: BetterIcons.addCircleFilled,
                title: presetId == null
                    ? context.tr.createPreset
                    : context.tr.updatePreset,
                subtitle: context.tr.enterInformationOfPreset,
                maxWidth: 700,
                secondaryButton: AppOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: context.tr.cancel,
                ),
                primaryButton: AppFilledButton(
                  text: context.tr.saveChanges,
                  onPressed: () => context
                      .read<ShopDetailCreatePresetDialogBloc>()
                      .onSubmit(),
                ),
                child: Column(
                  children: [
                    AppTextField(
                      label: context.tr.name,
                      hint: context.tr.enterName,
                      initialValue: state.name,
                      onChanged: context
                          .read<ShopDetailCreatePresetDialogBloc>()
                          .onNameChanged,
                    ),
                    const SizedBox(height: 24),
                    WeekdaysOpenHoursInput(
                      openHours: state.availabilitySchedule,
                      onChanged: context
                          .read<ShopDetailCreatePresetDialogBloc>()
                          .onAvailabilityScheduleChanged,
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
