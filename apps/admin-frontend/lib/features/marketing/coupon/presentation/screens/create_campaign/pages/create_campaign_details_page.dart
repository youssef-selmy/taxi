import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/blocs/create_campaign.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateCampaignDetailsPage extends StatefulWidget {
  const CreateCampaignDetailsPage({super.key});

  @override
  State<CreateCampaignDetailsPage> createState() =>
      _CreateCampaignDetailsPageState();
}

class _CreateCampaignDetailsPageState extends State<CreateCampaignDetailsPage> {
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LargeHeader(
                        title: context.tr.details,
                        size: HeaderSize.large,
                      ),
                      const Divider(height: 32),
                      Form(
                        key: _formKey,
                        child: LayoutGrid(
                          columnGap: 16,
                          rowGap: 16,
                          columnSizes: context.responsive(
                            [1.fr],
                            lg: [1.fr, 1.fr],
                          ),
                          rowSizes: const [auto, auto, auto, auto, auto],
                          children: [
                            AppTextField(
                              label: context.tr.title,
                              initialValue: state.title,
                              hint: context.tr.enterCampaignTitle,
                              validator: context.validateName,
                              onChanged: bloc.onTitleChanged,
                            ),
                            AppTextField(
                              label: context.tr.description,
                              initialValue: state.description,
                              hint: context.tr.enterCampaignDescription,
                              validator: FormBuilderValidators.required(),
                              onChanged: bloc.onDescriptionChanged,
                            ),
                            AppNumberField.integer(
                              title: context.tr.quantity,
                              initialValue: state.codesCount,
                              hint: "Enter how many codes you want to generate",
                              validator: FormBuilderValidators.aggregate([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.min(1),
                                FormBuilderValidators.max(10000),
                              ]),
                              onChanged: bloc.onCodesCountChanged,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
            const AppDivider(height: 1),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Spacer(),
                    AppFilledButton(
                      suffixIcon: BetterIcons.arrowRight02Outline,
                      text: context.tr.actionContinue,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bloc.detailsPageCompleted();
                        }
                      },
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
