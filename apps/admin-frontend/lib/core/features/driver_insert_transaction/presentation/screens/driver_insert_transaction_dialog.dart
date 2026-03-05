import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/features/driver_insert_transaction/presentation/blocs/driver_insert_transaction.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverInsertTransactionDialog extends StatelessWidget {
  final String driverId;

  const DriverInsertTransactionDialog({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DriverInsertTransactionBloc()..onStarted(driverId: driverId),
      child:
          BlocBuilder<
            DriverInsertTransactionBloc,
            DriverInsertTransactionState
          >(
            builder: (context, state) {
              return AppResponsiveDialog(
                icon: BetterIcons.addCircleFilled,
                title: context.tr.insertTransaction,
                subtitle: context.tr.insertTransactionSubtitle,
                primaryButton: AppFilledButton(
                  text: context.tr.submit,
                  onPressed: () =>
                      context.read<DriverInsertTransactionBloc>().onSubmitted(),
                ),
                secondaryButton: AppOutlinedButton(
                  text: context.tr.cancel,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                child:
                    BlocConsumer<
                      DriverInsertTransactionBloc,
                      DriverInsertTransactionState
                    >(
                      listener: (context, state) {
                        if (state.saveState.isLoaded) {
                          Navigator.of(context).pop();
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: state.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppDropdownField.single(
                                label: context.tr.transactionType,
                                initialValue: state.transactionType,
                                validator: (value) => value == null
                                    ? context.tr.selectTransactionType
                                    : null,
                                onChanged: (value) => context
                                    .read<DriverInsertTransactionBloc>()
                                    .onTransactionTypeChanged(value),
                                items: [
                                  for (final type
                                      in Enum$DriverRechargeTransactionType
                                          .values
                                          .where(
                                            (type) =>
                                                type !=
                                                Enum$DriverRechargeTransactionType
                                                    .$unknown,
                                          )) ...[
                                    AppDropdownItem(
                                      title: type.name,
                                      prefix: Icon(
                                        BetterIcons.arrowUpRight01Outline,
                                        color: context.colors.success,
                                      ),
                                      value: (
                                        Enum$TransactionAction.Recharge,
                                        type,
                                      ),
                                    ),
                                  ],
                                  for (final type
                                      in Enum$DriverDeductTransactionType.values
                                          .where(
                                            (type) =>
                                                type !=
                                                Enum$DriverDeductTransactionType
                                                    .$unknown,
                                          )) ...[
                                    AppDropdownItem(
                                      title: type.name,
                                      prefix: Icon(
                                        BetterIcons.arrowDownLeft01Outline,
                                        color: context.colors.error,
                                      ),
                                      value: (
                                        Enum$TransactionAction.Deduct,
                                        type,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 16),
                              AppDroopdownCurrency(
                                initialValue: state.currency,
                                onChanged: (value) => context
                                    .read<DriverInsertTransactionBloc>()
                                    .onCurrencyChanged(value),
                                validator: (value) => value == null
                                    ? context.tr.selectCurrency
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                initialValue: state.amount?.toString(),
                                onChanged: (p0) => context
                                    .read<DriverInsertTransactionBloc>()
                                    .onAmountChanged(p0),
                                validator: (p0) => p0 == null || p0.isEmpty
                                    ? context.tr.enterAmount
                                    : null,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'),
                                  ),
                                ],
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                label: context.tr.amount,
                                hint: context.tr.enterAmount,
                                isFilled: true,
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                initialValue: state.referenceNumber,
                                onChanged: (value) => context
                                    .read<DriverInsertTransactionBloc>()
                                    .onReferenceNumberChanged(value),
                                validator: (p0) => p0 == null || p0.isEmpty
                                    ? context.tr.enterReferenceNumber
                                    : null,
                                label: context.tr.referenceNumber,
                                hint: context.tr.enterReferenceNumber,
                                isFilled: true,
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                initialValue: state.description,
                                onChanged: (value) => context
                                    .read<DriverInsertTransactionBloc>()
                                    .onDescriptionChanged(value),
                                validator: (p0) => p0 == null || p0.isEmpty
                                    ? context.tr.enterDescription
                                    : null,
                                label: context.tr.description,
                                hint: context.tr.enterDescription,
                                isFilled: true,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              );
            },
          ),
    );
  }
}
