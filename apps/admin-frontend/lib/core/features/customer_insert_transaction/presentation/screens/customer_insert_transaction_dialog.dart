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
import 'package:admin_frontend/core/features/customer_insert_transaction/presentation/blocs/customer_insert_transaction.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomerInsertTransactionDialog extends StatelessWidget {
  final String customerId;

  const CustomerInsertTransactionDialog({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CustomerInsertTransactionBloc()
                ..onStarted(customerId: customerId),
        ),
      ],
      child: AppResponsiveDialog(
        icon: BetterIcons.addCircleFilled,
        title: context.tr.insertTransaction,
        subtitle: context.tr.insertTransactionSubtitle,
        primaryButton: AppFilledButton(
          text: context.tr.submit,
          onPressed: () =>
              context.read<CustomerInsertTransactionBloc>().onSubmitted(),
        ),
        secondaryButton: AppOutlinedButton(
          text: context.tr.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        child:
            BlocConsumer<
              CustomerInsertTransactionBloc,
              CustomerInsertTransactionState
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
                            .read<CustomerInsertTransactionBloc>()
                            .onTransactionTypeChanged(value),
                        items: [
                          for (final type
                              in Enum$RiderRechargeTransactionType.values.where(
                                (type) =>
                                    type !=
                                    Enum$RiderRechargeTransactionType.$unknown,
                              )) ...[
                            AppDropdownItem(
                              title: type.name,
                              prefix: Icon(
                                BetterIcons.arrowUpRight01Outline,
                                color: context.colors.success,
                              ),
                              value: (Enum$TransactionAction.Recharge, type),
                            ),
                          ],
                          for (final type
                              in Enum$RiderDeductTransactionType.values.where(
                                (type) =>
                                    type !=
                                    Enum$RiderDeductTransactionType.$unknown,
                              )) ...[
                            AppDropdownItem(
                              title: type.name,
                              prefix: Icon(
                                BetterIcons.arrowDownLeft01Outline,
                                color: context.colors.error,
                              ),
                              value: (Enum$TransactionAction.Deduct, type),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppDroopdownCurrency(
                        initialValue: state.currency,
                        onChanged: (value) => context
                            .read<CustomerInsertTransactionBloc>()
                            .onCurrencyChanged(value),
                        validator: (value) =>
                            value == null ? context.tr.selectCurrency : null,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        initialValue: state.amount?.toString(),
                        onChanged: (p0) => context
                            .read<CustomerInsertTransactionBloc>()
                            .onAmountChanged(p0),
                        validator: (p0) => p0 == null || p0.isEmpty
                            ? context.tr.enterAmount
                            : null,
                        isFilled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        label: context.tr.amount,
                        hint: context.tr.enterAmount,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        initialValue: state.referenceNumber,
                        onChanged: (value) => context
                            .read<CustomerInsertTransactionBloc>()
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
                            .read<CustomerInsertTransactionBloc>()
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
      ),
    );
  }
}
