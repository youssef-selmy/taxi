import 'package:better_design_system/molecules/date_range_picker_field/date_range_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/blocs/create_campaign.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateCampaignCouponSettings extends StatefulWidget {
  const CreateCampaignCouponSettings({super.key});

  @override
  State<CreateCampaignCouponSettings> createState() =>
      _CreateCampaignCouponSettingsState();
}

class _CreateCampaignCouponSettingsState
    extends State<CreateCampaignCouponSettings> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateCampaignBloc>();
    return BlocBuilder<CreateCampaignBloc, CreateCampaignState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsive(16, lg: 40),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeHeader(
                        title: context.tr.couponSettings,
                        size: HeaderSize.large,
                      ),
                      const Divider(height: 32),
                      Form(
                        key: _formKey,
                        child: LayoutGrid(
                          rowSizes: List.generate(
                            context.isDesktop ? 4 : 8,
                            (_) => auto,
                          ),
                          columnSizes: context.responsive(
                            [1.fr],
                            lg: [1.fr, 1.fr],
                          ),
                          rowGap: 16,
                          columnGap: 16,
                          children: [
                            AppTextField(
                              label: context.tr.userRedemptionLimit,
                              initialValue: state.manyTimesUserCanUse
                                  .toString(),
                              onChanged: bloc.onManyTimesUserCanUseChanged,
                              validator: FormBuilderValidators.required(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                            ),
                            AppTextField(
                              label: context.tr.totalUserRedemptionLimit,
                              initialValue: state.manyUsersCanUse.toString(),
                              onChanged: bloc.onManyUsersCanUseChanged,
                              validator: FormBuilderValidators.required(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                            ),
                            AppTextField(
                              label: context.tr.minimumCost,
                              initialValue: state.minimumPurchase.toString(),
                              onChanged: bloc.onMinimumPurchaseChanged,
                            ),
                            AppTextField(
                              label: context.tr.maximumCost,
                              initialValue: state.maximumPurchase.toString(),
                              onChanged: bloc.onMaximumPurchaseChanged,
                            ),
                            AppNumberField(
                              title: context.tr.flatDiscount,
                              initialValue: state.discountFlat,
                              onChanged: bloc.onDiscountFlatChanged,
                            ),
                            AppNumberField(
                              title: context.tr.percentageDiscount,
                              initialValue: state.discountPercent,
                              onChanged: bloc.onDiscountPercentChanged,
                            ),
                            AppDateRangePickerField(
                              label: context.tr.dateAndTime,
                              activeDate: state.dateRange,
                              hint: context.tr.dateAndTime,
                              validator: FormBuilderValidators.required(),
                              onChanged: bloc.onDateRangeChanged,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    AppOutlinedButton(
                      prefixIcon: BetterIcons.arrowLeft02Outline,
                      onPressed: () => bloc.onBackButtonPressed(),
                      text: context.tr.back,
                    ),
                    const Spacer(),
                    AppFilledButton(
                      suffixIcon: BetterIcons.arrowRight02Outline,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bloc.couponSettingsPageCompleted();
                        }
                      },
                      text: context.tr.next,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
