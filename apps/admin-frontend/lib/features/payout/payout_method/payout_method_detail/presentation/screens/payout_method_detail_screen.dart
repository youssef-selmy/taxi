import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_detail/presentation/blocs/payout_method_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class PayoutMethodDetailScreen extends StatelessWidget {
  final String? payoutMethodId;
  const PayoutMethodDetailScreen({
    super.key,
    @PathParam('payoutMethodId') this.payoutMethodId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PayoutMethodDetailBloc()..onStarted(id: payoutMethodId),
      child: Container(
        padding: context.pagePadding,
        color: context.colors.surface,
        child: BlocConsumer<PayoutMethodDetailBloc, PayoutMethodDetailState>(
          listener: (context, state) {
            if (state.saveState.isLoaded) {
              context.router.back();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                PageHeader(
                  title: payoutMethodId == null
                      ? context.tr.createPayoutMethod
                      : context.tr.editPayoutMethod,
                  subtitle: payoutMethodId == null
                      ? context.tr.createNewPayoutMethod
                      : context.tr.editExistingPayoutMethod,
                  showBackButton: true,
                  actions: [
                    if (payoutMethodId != null) ...[
                      AppOutlinedButton(
                        onPressed: () => context
                            .read<PayoutMethodDetailBloc>()
                            .onDeletePayoutMethod(),
                        text: context.tr.delete,
                        color: SemanticColor.error,
                        prefixIcon: BetterIcons.delete03Outline,
                      ),
                    ],
                    AppFilledButton(
                      text: context.tr.saveChanges,
                      onPressed: context
                          .read<PayoutMethodDetailBloc>()
                          .submitPayoutMethod,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                switch (state.payoutMethodState) {
                  ApiResponseLoaded() => LayoutGrid(
                    columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                    rowSizes: List.generate(
                      context.isDesktop ? 5 : 6,
                      (_) => auto,
                    ),
                    rowGap: 16,
                    columnGap: 16,
                    children: [
                      UploadFieldSmall(
                        title: context.tr.uploadImage,
                        initialValue: state.media,
                        onChanged: context
                            .read<PayoutMethodDetailBloc>()
                            .onMediaChanged,
                      ).withGridPlacement(
                        columnSpan: context.responsive(1, lg: 2),
                      ),
                      AppTextField(
                        label: context.tr.name,
                        initialValue: state.name,
                        onChanged: context
                            .read<PayoutMethodDetailBloc>()
                            .onNameChanged,
                      ),
                      AppDropdownField.single(
                        label: context.tr.type,
                        initialValue: state.type,
                        items: Enum$PayoutMethodType.values
                            .where(
                              (type) => type != Enum$PayoutMethodType.$unknown,
                            )
                            .map(
                              (type) => AppDropdownItem(
                                title: type.name,
                                value: type,
                              ),
                            )
                            .toList(),
                        onChanged: context
                            .read<PayoutMethodDetailBloc>()
                            .onTypeChanged,
                      ),
                      AppDroopdownCurrency(
                        initialValue: state.currency,
                        onChanged: context
                            .read<PayoutMethodDetailBloc>()
                            .onCurrencyChanged,
                      ),
                      AppTextField(
                        label: context.tr.description,
                        initialValue: state.description,
                        onChanged: context
                            .read<PayoutMethodDetailBloc>()
                            .onDescriptionChanged,
                      ),
                      if (state.type == Enum$PayoutMethodType.Stripe) ...[
                        AppTextField(
                          label: context.tr.privateKey,
                          initialValue: state.privateKey,
                          onChanged: context
                              .read<PayoutMethodDetailBloc>()
                              .onPrivateKeyChanged,
                        ),
                      ],
                    ],
                  ),
                  _ => const SizedBox(),
                },
              ],
            );
          },
        ),
      ),
    );
  }
}
