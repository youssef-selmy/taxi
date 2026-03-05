import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_design_system/molecules/date_range_picker_field/date_range_picker_field.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/marketing/gift_card/presentation/blocs/create_gift_batch.cubit.dart';

@RoutePage()
class CreateGiftBatchScreen extends StatefulWidget {
  const CreateGiftBatchScreen({super.key});

  @override
  createState() => _CreateGiftBatchScreenState();
}

class _CreateGiftBatchScreenState extends State<CreateGiftBatchScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateGiftBatchBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: BlocConsumer<CreateGiftBatchBloc, CreateGiftBatchState>(
                listener: (context, state) {
                  if (state.networkStateSave.isLoaded) {
                    context.router.back();
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PageHeader(
                              title: context.tr.createGiftBatch,
                              subtitle:
                                  context.tr.createGiftCardBatchDescription,
                              showBackButton: true,
                              actions: [
                                AppFilledButton(
                                  isDisabled: state.networkStateSave.isLoading,
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    context
                                        .read<CreateGiftBatchBloc>()
                                        .onSave();
                                  },
                                  text: context.tr.saveChanges,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            AlignedGridView.count(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              crossAxisCount: context.isDesktop ? 2 : 1,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return switch (index) {
                                  0 => AppTextField(
                                    label: context.tr.name,
                                    initialValue: state.name,
                                    validator: (p0) => (p0?.isEmpty ?? true)
                                        ? context.tr.fieldIsRequired
                                        : null,
                                    onChanged: context
                                        .read<CreateGiftBatchBloc>()
                                        .onNameChanged,
                                  ),
                                  1 => AppDroopdownCurrency(
                                    initialValue: state.currency,
                                    onChanged: context
                                        .read<CreateGiftBatchBloc>()
                                        .onCurrencyChanged,
                                    validator: (p0) => p0 == null
                                        ? context.tr.fieldIsRequired
                                        : null,
                                  ),
                                  2 => AppNumberField(
                                    title: context.tr.amount,
                                    initialValue: state.amount,
                                    validator: (p0) => p0 == null || p0 <= 0
                                        ? context.tr.fieldIsRequired
                                        : null,
                                    onChanged: context
                                        .read<CreateGiftBatchBloc>()
                                        .onAmountChanged,
                                  ),

                                  3 => AppNumberField.integer(
                                    title: context.tr.quantity,
                                    initialValue: state.count,
                                    validator: (p0) => p0 == null || p0 <= 0
                                        ? context.tr.fieldIsRequired
                                        : null,
                                    onChanged: context
                                        .read<CreateGiftBatchBloc>()
                                        .onQuantityChanged,
                                  ),
                                  4 => AppDateRangePickerField(
                                    label: context.tr.expiryDate,
                                    activeDate: (
                                      state.availableFrom,
                                      state.expireAt,
                                    ),
                                    onChanged: context
                                        .read<CreateGiftBatchBloc>()
                                        .onAvailabilityChanged,
                                  ),
                                  _ => const Text("Not implemented"),
                                };
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
