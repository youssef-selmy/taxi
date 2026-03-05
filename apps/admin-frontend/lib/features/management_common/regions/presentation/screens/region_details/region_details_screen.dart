import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/map/geofence_form_field.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/blocs/region_details.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class RegionDetailsScreen extends StatelessWidget {
  final String? regionId;

  RegionDetailsScreen({super.key, @PathParam('regionId') this.regionId});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegionDetailsBloc()..onStarted(regionId: regionId),
      child: SingleChildScrollView(
        padding: context.pagePadding,
        child: Container(
          color: context.colors.surface,
          child: BlocConsumer<RegionDetailsBloc, RegionDetailsState>(
            listener: (context, state) {
              if (state.networkStateSave.isLoaded) {
                context.showToast(
                  context.tr.savedSuccessfully,
                  type: SemanticColor.success,
                );
                context.router.back();
              }
            },
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: switch (state.region) {
                  ApiResponseLoading() => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  ApiResponseError(:final message) => Center(
                    child: Text(message),
                  ),
                  ApiResponseInitial() => const SizedBox(),
                  ApiResponseLoaded(:final data) => Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PageHeader(
                          title: regionId == null
                              ? context.tr.addRegion
                              : context.tr.editRegion,
                          subtitle: regionId == null
                              ? context.tr.addNewRegionSubtitle
                              : "${context.tr.editRegion} #$regionId",
                          showBackButton: true,
                          onBackButtonPressed: () {
                            context.router.back();
                          },
                          actions: [
                            if (data != null) ...[
                              AppOutlinedButton(
                                isDisabled: state.networkStateSave.isLoading,
                                onPressed: () {
                                  context.read<RegionDetailsBloc>().onDelete();
                                },
                                color: SemanticColor.error,
                                prefixIcon: BetterIcons.delete03Outline,
                                text: context.tr.delete,
                              ),
                              AppOutlinedButton(
                                isDisabled: state.networkStateSave.isLoading,
                                color: SemanticColor.neutral,
                                onPressed: () {
                                  context
                                      .read<RegionDetailsBloc>()
                                      .onChangeHideStatus();
                                },
                                prefixIcon: data.enabled
                                    ? BetterIcons.viewOffSlashFilled
                                    : BetterIcons.eyeFilled,
                                text: data.enabled
                                    ? context.tr.hide
                                    : context.tr.show,
                              ),
                            ],
                            AppFilledButton(
                              isDisabled: state.networkStateSave.isLoading,
                              text: context.tr.saveChanges,
                              onPressed: () {
                                if (_formKey.currentState?.validate() == true) {
                                  _formKey.currentState?.save();
                                }
                                context
                                            .read<RegionDetailsBloc>()
                                            .state
                                            .regionId ==
                                        null
                                    ? context
                                          .read<RegionDetailsBloc>()
                                          .createRegion()
                                    : context
                                          .read<RegionDetailsBloc>()
                                          .updateRegion();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  AppTextField(
                                    onChanged: (p0) => context
                                        .read<RegionDetailsBloc>()
                                        .onNameChanged(p0),
                                    validator: (p0) => (p0?.isEmpty ?? true)
                                        ? context.tr.fieldIsRequired
                                        : null,
                                    initialValue: state.name,
                                    label: context.tr.name,
                                    hint: context.tr.nameHint,
                                  ),
                                  const SizedBox(height: 16),
                                  AppDroopdownCurrency(
                                    initialValue: state.currency,
                                    showAll: true,
                                    onChanged: (p0) => context
                                        .read<RegionDetailsBloc>()
                                        .onCurrencyChanged(p0),
                                    validator: FormBuilderValidators.required(),
                                  ),
                                  const SizedBox(height: 16),
                                  AppDropdownField.single(
                                    initialValue: state.regionCategoryId,
                                    validator: FormBuilderValidators.required(),
                                    onChanged: (p0) => context
                                        .read<RegionDetailsBloc>()
                                        .onRegionCategoryChanged(p0),
                                    items: state.regionCategories
                                        .map(
                                          (e) => AppDropdownItem(
                                            title: e.name,
                                            value: e.id,
                                          ),
                                        )
                                        .toList(),
                                    label: context.tr.category,
                                  ),
                                ],
                              ),
                            ),
                            if (context.isDesktop)
                              const Expanded(child: SizedBox()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "${context.tr.geofence}:",
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 400,
                          child: AppGeofenceFormField(
                            initialValue: state.location.firstOrNull
                                ?.toFragmentCoordinateList(),
                            validator: (value) => (value?.isEmpty ?? true)
                                ? context.tr.youNeedToDrawGeofence
                                : null,
                            onChanged: (p0) => context
                                .read<RegionDetailsBloc>()
                                .onLocationChanged(p0 ?? []),
                            onSaved: (newValue) => context
                                .read<RegionDetailsBloc>()
                                .onLocationChanged(newValue ?? []),
                          ),
                        ),
                      ],
                    ),
                  ),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
