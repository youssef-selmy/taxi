import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_insert_transaction.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AdminAccountingInsertTransactionDialog extends StatelessWidget {
  const AdminAccountingInsertTransactionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminAccountingInsertTransactionBloc()..onStarted(),
      child:
          BlocBuilder<
            AdminAccountingInsertTransactionBloc,
            AdminAccountingInsertTransactionState
          >(
            builder: (context, state) {
              return AppResponsiveDialog(
                icon: BetterIcons.addCircleFilled,
                title: context.tr.insertTransaction,
                subtitle: context.tr.insertTransactionSubtitle,
                onClosePressed: () => Navigator.of(context).pop(),
                primaryButton: AppFilledButton(
                  text: context.tr.submit,
                  onPressed: () => context
                      .read<AdminAccountingInsertTransactionBloc>()
                      .onSubmitted(),
                ),
                secondaryButton: AppOutlinedButton(
                  text: context.tr.cancel,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                maxWidth: 600,
                child:
                    BlocConsumer<
                      AdminAccountingInsertTransactionBloc,
                      AdminAccountingInsertTransactionState
                    >(
                      listener: (context, state) {
                        if (state.saveState.isLoaded) {
                          Navigator.of(context).pop(true);
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: state.formKey,
                          child: Column(
                            spacing: 16,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppDropdownField.single(
                                label: context.tr.transactionType,
                                initialValue: state.action,
                                validator: (value) => value == null
                                    ? context.tr.selectTransactionType
                                    : null,
                                onChanged: (value) => context
                                    .read<
                                      AdminAccountingInsertTransactionBloc
                                    >()
                                    .onActionChanged(value),
                                items: [
                                  AppDropdownItem(
                                    title: context.tr.debit,
                                    value: Enum$TransactionAction.Deduct,
                                  ),
                                  AppDropdownItem(
                                    title: context.tr.credit,
                                    value: Enum$TransactionAction.Recharge,
                                  ),
                                ],
                              ),
                              switch (state.action) {
                                Enum$TransactionAction.Recharge =>
                                  AppDropdownField.single(
                                    label: context.tr.creditType,
                                    initialValue: state.creditType,
                                    onChanged: context
                                        .read<
                                          AdminAccountingInsertTransactionBloc
                                        >()
                                        .onCreditTypeChanged,
                                    items: Enum$ProviderRechargeTransactionType
                                        .values
                                        .where(
                                          (type) =>
                                              type !=
                                              Enum$ProviderRechargeTransactionType
                                                  .$unknown,
                                        )
                                        .map(
                                          (type) => AppDropdownItem(
                                            title: type.name,
                                            value: type,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                Enum$TransactionAction.Deduct =>
                                  AppDropdownField.single(
                                    label: context.tr.debitType,
                                    initialValue: state.debitType,
                                    onChanged: context
                                        .read<
                                          AdminAccountingInsertTransactionBloc
                                        >()
                                        .onDebitTypeChanged,
                                    items: Enum$ProviderDeductTransactionType
                                        .values
                                        .where(
                                          (type) =>
                                              type !=
                                              Enum$ProviderDeductTransactionType
                                                  .$unknown,
                                        )
                                        .map(
                                          (type) => AppDropdownItem(
                                            title: type.name,
                                            value: type,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                _ => const SizedBox(),
                              },
                              if (state.action ==
                                      Enum$TransactionAction.Deduct &&
                                  state.debitType ==
                                      Enum$ProviderDeductTransactionType
                                          .Expense) ...[
                                AppDropdownField.single(
                                  label: context.tr.expenseType,
                                  initialValue: state.expenseType,
                                  onChanged: context
                                      .read<
                                        AdminAccountingInsertTransactionBloc
                                      >()
                                      .onExpenseTypeChanged,
                                  items: Enum$ProviderExpenseType.values
                                      .where(
                                        (type) =>
                                            type !=
                                            Enum$ProviderExpenseType.$unknown,
                                      )
                                      .map(
                                        (type) => AppDropdownItem(
                                          title: type.name,
                                          value: type,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, stateAuth) {
                                  return AppDroopdownCurrency(
                                    initialValue: state.currency,
                                    onChanged: (value) => context
                                        .read<
                                          AdminAccountingInsertTransactionBloc
                                        >()
                                        .onCurrencyChanged(value),
                                    validator: (value) => value == null
                                        ? context.tr.selectCurrency
                                        : null,
                                  );
                                },
                              ),
                              AppTextField(
                                initialValue: state.amount?.toString(),
                                onChanged: (p0) => context
                                    .read<
                                      AdminAccountingInsertTransactionBloc
                                    >()
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
                              AppTextField(
                                initialValue: state.referenceNumber,
                                onChanged: (value) => context
                                    .read<
                                      AdminAccountingInsertTransactionBloc
                                    >()
                                    .onReferenceNumberChanged(value),
                                validator: (p0) => p0 == null || p0.isEmpty
                                    ? context.tr.enterReferenceNumber
                                    : null,
                                label: context.tr.referenceNumber,
                                hint: context.tr.enterReferenceNumber,
                                isFilled: true,
                              ),
                              AppTextField(
                                initialValue: state.description,
                                onChanged: (value) => context
                                    .read<
                                      AdminAccountingInsertTransactionBloc
                                    >()
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
