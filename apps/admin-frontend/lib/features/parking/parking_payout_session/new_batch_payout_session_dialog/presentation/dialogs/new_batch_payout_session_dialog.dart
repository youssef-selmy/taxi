import 'package:admin_frontend/config/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/new_batch_payout_session_dialog/presentation/blocs/new_batch_payout_session_dialog.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class NewBatchPayoutSessionDialog extends StatelessWidget {
  final Enum$AppType appType;

  const NewBatchPayoutSessionDialog({super.key, required this.appType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewBatchPayoutSessionDialogBloc()..onStarted(appType: appType),
      child:
          BlocBuilder<
            NewBatchPayoutSessionDialogBloc,
            NewBatchPayoutSessionDialogState
          >(
            builder: (context, state) {
              return AppResponsiveDialog(
                maxWidth: 650,
                icon: BetterIcons.arrowDown05Filled,
                title: context.tr.newPayoutSession,
                subtitle: context.tr.createNewSessionSelectPayoutGroup,
                onClosePressed: () => Navigator.of(context).pop(),
                primaryButton:
                    BlocConsumer<
                      NewBatchPayoutSessionDialogBloc,
                      NewBatchPayoutSessionDialogState
                    >(
                      listener: (context, state) {
                        if (state.saveState.isLoaded) {
                          Navigator.of(context).pop();
                        }
                      },
                      builder: (context, state) => AppFilledButton(
                        isLoading: state.saveState.isLoading,
                        text: context.tr.submit,
                        onPressed: context
                            .read<NewBatchPayoutSessionDialogBloc>()
                            .onSubmit,
                      ),
                    ),
                secondaryButton: AppOutlinedButton(
                  text: context.tr.cancel,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                child:
                    BlocBuilder<
                      NewBatchPayoutSessionDialogBloc,
                      NewBatchPayoutSessionDialogState
                    >(
                      builder: (context, state) {
                        return switch (state.payoutMethodsState) {
                          ApiResponseLoaded(:final data) => Column(
                            children: [
                              AppDropdownField<String>(
                                isMultiSelect: true,
                                label: context.tr.payoutMethods,
                                initialValue: state.selectedPayoutMethodIds,
                                onMultiChanged: context
                                    .read<NewBatchPayoutSessionDialogBloc>()
                                    .onPayoutMethodsChanged,
                                items: data.payoutMethods.nodes
                                    .map(
                                      (payoutMethod) => AppDropdownItem(
                                        value: payoutMethod.id,
                                        title: payoutMethod.name,
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 24),
                              AppDroopdownCurrency(
                                initialValue: state.currency,
                                onChanged: context
                                    .read<NewBatchPayoutSessionDialogBloc>()
                                    .onCurrencyChanged,
                              ),
                              const SizedBox(height: 24),
                              AppTextField(
                                initialValue: state.minimumAmount.toString(),
                                onChanged: (value) => context
                                    .read<NewBatchPayoutSessionDialogBloc>()
                                    .onMinimumAmountChanged(
                                      double.parse(value),
                                    ),
                                label: context.tr.minimumAmount,
                                hint:
                                    context.tr.enterMinimumPayoutWalletBalance,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              AppTextField(
                                initialValue: state.description,
                                onChanged: context
                                    .read<NewBatchPayoutSessionDialogBloc>()
                                    .onDescriptionChanged,
                                label: context.tr.description,
                              ),
                              const Divider(height: 48),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${context.tr.totalAmount}:",
                                        style: context.textTheme.labelMedium
                                            ?.variant(context),
                                      ),
                                      const SizedBox(height: 8),
                                      state.totalPayoutAmount.toCurrency(
                                        context,
                                        state.currency ?? Env.defaultCurrency,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          _ => const CupertinoActivityIndicator(),
                        };
                      },
                    ),
              );
            },
          ),
    );
  }
}
