import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/blocs/region_category_details.cubit.dart';

@RoutePage()
class RegionCategoryDetailsScreen extends StatelessWidget {
  final String? regionCategoryId;

  RegionCategoryDetailsScreen({
    super.key,
    @PathParam('regionCategoryId') this.regionCategoryId,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegionCategoryDetailsBloc()
            ..onStarted(regionCategoryId: regionCategoryId),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: BlocConsumer<RegionCategoryDetailsBloc, RegionCategoryDetailsState>(
          listener: (context, state) {
            if (state.networkStateSave.isLoaded) {
              context.router.back();
            }
          },
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: switch (state.regionCategory) {
                ApiResponseInitial() => const SizedBox(),
                ApiResponseLoading() => const Center(
                  child: CupertinoActivityIndicator(),
                ),
                ApiResponseError(:final message) => Center(
                  child: Text(message.toString()),
                ),
                ApiResponseLoaded(:final data) => Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PageHeader(
                        title: isEdit
                            ? "${context.tr.editRegionCategory} $regionCategoryId"
                            : context.tr.createRegionCategory,
                        showBackButton: true,
                        subtitle: isEdit
                            ? context.tr.editRegionCategoryInstruction
                            : context.tr.createRegionCategoryInstruction,
                        actions: [
                          AppFilledButton(
                            text: context.tr.saveChanges,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<RegionCategoryDetailsBloc>()
                                    .onSaved();
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                AppTextField(
                                  onChanged: context
                                      .read<RegionCategoryDetailsBloc>()
                                      .regionNameChanged,
                                  initialValue: data?.name,
                                  label: context.tr.name,
                                  hint: context.tr.nameHint,
                                ),
                                SizedBox(height: 16),
                                AppDroopdownCurrency(
                                  onChanged: context
                                      .read<RegionCategoryDetailsBloc>()
                                      .regionCurrencyChanged,
                                  initialValue: data?.currency,
                                  showAll: true,
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
              },
            );
          },
        ),
      ),
    );
  }

  bool get isEdit => regionCategoryId != null;
}
