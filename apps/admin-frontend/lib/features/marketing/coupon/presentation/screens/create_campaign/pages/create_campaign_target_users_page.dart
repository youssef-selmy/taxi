import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/campaign_criteria_orders_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/blocs/create_campaign.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateCampaignTargetUsers extends StatefulWidget {
  const CreateCampaignTargetUsers({super.key});

  @override
  State<CreateCampaignTargetUsers> createState() =>
      _CreateCampaignTargetUsersState();
}

class _CreateCampaignTargetUsersState extends State<CreateCampaignTargetUsers> {
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
                padding: context.pagePaddingHorizontal,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeHeader(
                        title: context.tr.targetUsers,
                        size: HeaderSize.large,
                      ),
                      const Divider(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ...List.generate(state.targetUsers.length, (index) {
                              return LayoutGrid(
                                columnGap: 16,
                                rowGap: 16,
                                columnSizes: context.responsive(
                                  [1.fr],
                                  lg: [1.fr, 1.fr, 1.fr],
                                ),
                                rowSizes: context.isDesktop
                                    ? const [auto, auto]
                                    : const [auto, auto, auto, auto, auto],
                                children: [
                                  AppDropdownField.single(
                                    label: context.tr.appType,
                                    initialValue: state.targetUsers
                                        .elementAt(index)
                                        .appType,
                                    onChanged: (value) =>
                                        bloc.onAppTypeChanged(index, value),
                                    items:
                                        [
                                              Enum$AppType.Taxi,
                                              Enum$AppType.Shop,
                                              Enum$AppType.Parking,
                                            ]
                                            .map(
                                              (e) => AppDropdownItem(
                                                title: e.name,
                                                value: e,
                                              ),
                                            )
                                            .toList(),
                                  ).withGridPlacement(
                                    columnSpan: context.responsive(1, lg: 3),
                                  ),
                                  AppDropdownField.single(
                                    label: context.tr.lastActivity,
                                    onChanged: (p0) =>
                                        bloc.onLastActivityChanged(index, p0),
                                    initialValue: state.targetUsers
                                        .elementAt(index)
                                        .lastDays,
                                    items: [
                                      AppDropdownItem(
                                        title: context.tr.lastNumberOfDays(7),
                                        value: 7,
                                      ),
                                      AppDropdownItem(
                                        title: context.tr.lastNumberOfDays(14),
                                        value: 14,
                                      ),
                                      AppDropdownItem(
                                        title: context.tr.lastNumberOfDays(30),
                                        value: 30,
                                      ),
                                      AppDropdownItem(
                                        title: context.tr.lastNumberOfDays(60),
                                        value: 60,
                                      ),
                                      AppDropdownItem(
                                        title: context.tr.lastNumberOfDays(90),
                                        value: 90,
                                      ),
                                    ],
                                  ),
                                  AppDropdownField.single(
                                    label: context.tr.criteriaType,
                                    initialValue: state.targetUsers
                                        .elementAt(index)
                                        .type,
                                    onChanged: (value) => bloc
                                        .onCriteriaTypeChanged(index, value),
                                    items: Enum$CampaignCriteriaOrdersType
                                        .values
                                        .where(
                                          (e) =>
                                              e !=
                                              Enum$CampaignCriteriaOrdersType
                                                  .$unknown,
                                        )
                                        .map(
                                          (e) => AppDropdownItem(
                                            title: e.title(context),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  AppTextField(
                                    label: context.tr.value,
                                    hint: context.tr.enterValue,
                                    onChanged: (value) => bloc
                                        .onCriteriaValueChanged(index, value),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    initialValue: state.targetUsers
                                        .elementAt(index)
                                        .value
                                        .toString(),
                                    validator: FormBuilderValidators.required(),
                                  ),
                                ],
                              );
                            }),
                          ].separated(separator: const Divider(height: 32)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      AppOutlinedButton(
                        onPressed: () => bloc.addTarget(),
                        text: context.tr.addAnotherTarget,
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppOutlinedButton(
                      prefixIcon: BetterIcons.arrowLeft02Outline,
                      onPressed: () {
                        bloc.onBackButtonPressed();
                      },
                      text: context.tr.back,
                    ),
                    const Spacer(),
                    AppFilledButton(
                      text: context.tr.next,
                      suffixIcon: BetterIcons.arrowRight02Outline,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bloc.onTargetUsersNextButtonPressed();
                        }
                      },
                    ),
                  ].separated(separator: const SizedBox(width: 16)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
