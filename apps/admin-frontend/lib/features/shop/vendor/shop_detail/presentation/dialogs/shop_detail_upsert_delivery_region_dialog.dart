import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/map/geofence_form_field.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_upsert_delivery_dialog.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailUpsertDeliveryRegionDialog extends StatelessWidget {
  final String shopId;
  final String? regionId;

  const ShopDetailUpsertDeliveryRegionDialog({
    super.key,
    required this.shopId,
    this.regionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopDetailUpsertDeliveryDialogBloc()
            ..onStarted(shopId: shopId, regionId: regionId),
      child:
          BlocConsumer<
            ShopDetailUpsertDeliveryDialogBloc,
            ShopDetailUpsertDeliveryDialogState
          >(
            listener: (context, state) {
              if (state.submitState.isLoaded) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              return AppResponsiveDialog(
                icon: BetterIcons.addCircleFilled,
                title: regionId == null
                    ? context.tr.createDeliveryRegion
                    : context.tr.updateDeliveryRegion,
                subtitle: context.tr.enterInformationOfCategory,
                maxWidth: 700,
                secondaryButton: AppOutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  text: context.tr.cancel,
                ),
                primaryButton: AppFilledButton(
                  text: context.tr.saveChanges,
                  onPressed: () => context
                      .read<ShopDetailUpsertDeliveryDialogBloc>()
                      .onSubmit(),
                ),
                child:
                    BlocBuilder<
                      ShopDetailUpsertDeliveryDialogBloc,
                      ShopDetailUpsertDeliveryDialogState
                    >(
                      builder: (context, state) {
                        return switch (state.deliveryZoneState) {
                          ApiResponseLoaded() => Column(
                            children: [
                              SizedBox(
                                height: 300,
                                child: AppGeofenceFormField(
                                  initialValue: state.location
                                      .toFragmentCoordinateList(),
                                  onChanged: context
                                      .read<
                                        ShopDetailUpsertDeliveryDialogBloc
                                      >()
                                      .onPolylineDrawn,
                                ),
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                label: context.tr.name,
                                hint: context.tr.enterName,
                                initialValue: state.name,
                                onChanged: context
                                    .read<ShopDetailUpsertDeliveryDialogBloc>()
                                    .onNameChanged,
                              ),
                              const SizedBox(height: 16),
                              AppNumberField(
                                title: context.tr.deliveryFee,
                                initialValue: state.deliveryFee,
                                onChanged: context
                                    .read<ShopDetailUpsertDeliveryDialogBloc>()
                                    .onDeliveryFeeChanged,
                              ),
                              const SizedBox(height: 16),
                              AppNumberField(
                                title: context.tr.minimumOrderAmount,
                                initialValue: state.minimumOrderAmount,
                                onChanged: context
                                    .read<ShopDetailUpsertDeliveryDialogBloc>()
                                    .onMinimumOrderAmountChanged,
                              ),
                              const SizedBox(height: 16),
                              AppNumberField.integer(
                                title: context.tr.minimumDeliveryTime,
                                initialValue: state.minDeliveryTimeMinutes,
                                onChanged: context
                                    .read<ShopDetailUpsertDeliveryDialogBloc>()
                                    .onMinDeliveryTimeChanged,
                              ),
                              const SizedBox(height: 16),
                              AppNumberField.integer(
                                title: context.tr.maximumDeliveryTime,
                                initialValue: state.maxDeliveryTimeMinutes,
                                onChanged: context
                                    .read<ShopDetailUpsertDeliveryDialogBloc>()
                                    .onMaxDeliveryTimeChanged,
                              ),
                            ],
                          ),
                          _ => const SizedBox(),
                        };
                      },
                    ),
              );
            },
          ),
    );
  }
}
