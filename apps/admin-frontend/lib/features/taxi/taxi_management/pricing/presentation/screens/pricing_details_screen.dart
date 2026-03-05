import 'package:admin_frontend/core/enums/taxi_order_type.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/enums/service_option.dart';
import 'package:admin_frontend/core/enums/service_option_type.dart';
import 'package:admin_frontend/core/enums/weekday.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/blocs/pricing_details.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/dialogs/add_date_range_multiplier.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/dialogs/add_distance_multiplier.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/dialogs/add_service_option.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/dialogs/add_time_of_day_multiplier.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/dialogs/add_weekday_multiplier.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class PricingDetailsScreen extends StatelessWidget {
  final String? pricingId;

  PricingDetailsScreen({super.key, @QueryParam('pricingId') this.pricingId});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PricingDetailsBloc()..onStarted(pricingId: pricingId),
      child: Container(
        margin: EdgeInsets.only(top: context.pagePadding.top),
        color: context.colors.surface,
        child: BlocConsumer<PricingDetailsBloc, PricingDetailsState>(
          listenWhen: (previous, current) =>
              previous.networkStateSave != current.networkStateSave &&
              (current.networkStateSave.isLoaded ||
                  current.networkStateSave.isError),
          listener: (context, state) {
            if (state.networkStateSave.isLoaded) {
              context.router.replace(PricingRoute());
            }
            if (state.networkStateSave.isError) {
              context.showFailure(state.networkStateSave);
            }
          },
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: switch (state.remoteData) {
                ApiResponseInitial() => const SizedBox(),
                ApiResponseLoading() => const Center(
                  child: CupertinoActivityIndicator(),
                ),
                ApiResponseError(:final message) => Center(
                  child: Text(message.toString()),
                ),
                ApiResponseLoaded() => Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: context.pagePaddingHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageHeader(
                          title: isEdit
                              ? "${context.tr.editPricing} #$pricingId"
                              : context.tr.createPricing,
                          showBackButton: true,
                          onBackButtonPressed: () =>
                              context.router.replace(PricingRoute()),
                          subtitle: isEdit
                              ? context.tr.editPricingRecordSubtitle
                              : context.tr.createPricingRecordSubtitle,
                          actions: [
                            AppFilledButton(
                              text: context.tr.saveChanges,
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<PricingDetailsBloc>().onSaved();
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LargeHeader(title: context.tr.regions, actions: []),
                        const Divider(height: 16),
                        BlocBuilder<PricingDetailsBloc, PricingDetailsState>(
                          builder: (context, state) {
                            if (state.regions.isEmpty) {
                              return Text(
                                "No Operational region available. Register new regions.",
                              );
                            }
                            return AppDropdownField.multi(
                              label: context.tr.operationalRegions,
                              initialValue: state.regions
                                  .where(
                                    (r) =>
                                        state.selectedRegionIds.contains(r.id),
                                  )
                                  .toList(),
                              items: state.regions
                                  .map(
                                    (e) => AppDropdownItem(
                                      value: e,
                                      title: [
                                        e.name,
                                        e.category?.name,
                                      ].nonNulls.join(" - "),
                                    ),
                                  )
                                  .toList(),
                              showChips: true,
                              onChanged: context
                                  .read<PricingDetailsBloc>()
                                  .onSelectedRegionsChanged,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        LargeHeader(title: context.tr.details),
                        const SizedBox(height: 16),
                        UploadFieldSmall(
                          validator: (p0) =>
                              p0 == null ? context.tr.fieldIsRequired : null,
                          title: context.tr.uploadImage,
                          initialValue: state.image,
                          onChanged: context
                              .read<PricingDetailsBloc>()
                              .onImageChanged,
                        ),
                        const SizedBox(height: 16),
                        AlignedGridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: context.responsive(1, lg: 2),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          itemCount: state.pricingMode == Enum$PricingMode.RANGE
                              ? 23
                              : 20,
                          itemBuilder: (context, index) {
                            // Adjust index for non-RANGE mode (skip indices 6, 7, 8)
                            final adjustedIndex =
                                state.pricingMode != Enum$PricingMode.RANGE &&
                                    index >= 6
                                ? index + 3
                                : index;
                            switch (adjustedIndex) {
                              case 0:
                                return AppTextField(
                                  label: context.tr.name,
                                  hint: context.tr.nameHint,
                                  onChanged: context
                                      .read<PricingDetailsBloc>()
                                      .onNameChanged,
                                  initialValue: state.name,
                                );
                              case 1:
                                return AppTextField(
                                  label: context.tr.description,
                                  initialValue: state.description,
                                  onChanged: context
                                      .read<PricingDetailsBloc>()
                                      .onDescriptionChanged,
                                );
                              case 2:
                                return AppDropdownField.multi(
                                  label: context.tr.supportedOrderTypes,
                                  initialValue: state.orderTypes,
                                  items: Enum$TaxiOrderType.values
                                      .where(
                                        (e) => e != Enum$TaxiOrderType.$unknown,
                                      )
                                      .map(
                                        (e) => AppDropdownItem(
                                          value: e,
                                          title: e.title(context),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: context
                                      .read<PricingDetailsBloc>()
                                      .onOrderTypesChanged,
                                );
                              case 3:
                                return AppDropdownField<String>.single(
                                  label: context.tr.category,
                                  onChanged: context
                                      .read<PricingDetailsBloc>()
                                      .onCategoryIdChanged,
                                  initialValue: state.categoryId,
                                  items: state.categories
                                      .map(
                                        (e) => AppDropdownItem(
                                          value: e.id,
                                          title: e.name,
                                        ),
                                      )
                                      .toList(),
                                );
                              case 4:
                                return AppNumberField.integer(
                                  title: context.tr.maxPersonCapacity,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onPersonCapacityChanged(
                                        value == 0 ? null : value,
                                      ),
                                  initialValue: state.personCapacity,
                                );
                              case 5:
                                return AppDropdownField<
                                  Enum$PricingMode
                                >.single(
                                  label: "Pricing Mode",
                                  onChanged: context
                                      .read<PricingDetailsBloc>()
                                      .onPricingModeChanged,
                                  initialValue: state.pricingMode,
                                  items: Enum$PricingMode.values
                                      .where(
                                        (e) => e != Enum$PricingMode.$unknown,
                                      )
                                      .map(
                                        (e) => AppDropdownItem(
                                          value: e,
                                          title: e.titleCased,
                                        ),
                                      )
                                      .toList(),
                                );
                              case 6:
                                if (state.pricingMode !=
                                    Enum$PricingMode.RANGE) {
                                  return const SizedBox();
                                }
                                return AppDropdownField<
                                  Enum$RangePolicy
                                >.single(
                                  label: "Range Policy",
                                  onChanged: context
                                      .read<PricingDetailsBloc>()
                                      .onRangePolicyChanged,
                                  initialValue: state.rangePolicy,
                                  items: Enum$RangePolicy.values
                                      .where(
                                        (e) => e != Enum$RangePolicy.$unknown,
                                      )
                                      .map(
                                        (e) => AppDropdownItem(
                                          value: e,
                                          title: e.titleCased,
                                        ),
                                      )
                                      .toList(),
                                );
                              case 7:
                                if (state.pricingMode !=
                                    Enum$PricingMode.RANGE) {
                                  return const SizedBox();
                                }
                                return AppNumberField(
                                  title: "Price Range Min Percent",
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onPriceRangeMinPercentChanged(value),
                                  initialValue: state.priceRangeMinPercent,
                                  minValue: 0,
                                  maxValue: 200,
                                );
                              case 8:
                                if (state.pricingMode !=
                                    Enum$PricingMode.RANGE) {
                                  return const SizedBox();
                                }
                                return AppNumberField(
                                  title: "Price Range Max Percent",
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onPriceRangeMaxPercentChanged(value),
                                  initialValue: state.priceRangeMaxPercent,
                                  minValue: 0,
                                  maxValue: 200,
                                );
                              case 9:
                                return AppNumberField(
                                  title: context.tr.baseFare,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onBaseFareChanged(value),
                                  initialValue: state.baseFare,
                                );
                              case 10:
                                return AppNumberField(
                                  title: context.tr.perHundredMeters,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onPerHundredMetersChanged(value),
                                  initialValue: state.perHundredMeters,
                                );
                              case 11:
                                return AppNumberField(
                                  title: context.tr.perMinuteDrive,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onPerMinuteDriveChanged(value),
                                  initialValue: state.perMinuteDrive,
                                );
                              case 12:
                                return AppNumberField(
                                  title: context.tr.perMinuteWait,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onPerMinuteWaitChanged(value),
                                  initialValue: state.perMinuteWait,
                                );
                              case 13: // prepay percent
                                return AppNumberField(
                                  title: context.tr.prepayPercent,
                                  minValue: 0,
                                  maxValue: 100,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onPrepayPercentChanged(value),
                                  initialValue: state.prepayPercent,
                                );
                              case 14: // rounding factor
                                return AppNumberField(
                                  title: context.tr.roundingFactor,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onRoundingFactorChanged(value),
                                  initialValue: state.roundingFactor,
                                );
                              case 15: // minimumFee
                                return AppNumberField(
                                  title: context.tr.minimumFee,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onMinimumFeeChanged(value),
                                  initialValue: state.minimumFee,
                                );

                              case 16: // maximum Distance
                                return AppNumberField.integer(
                                  title: context.tr.maxDestinationDistance,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onMaximumDestinationDistanceChanged(
                                        value,
                                      ),
                                  initialValue:
                                      state.maximumDestinationDistance,
                                );

                              case 17: // cancellation total Fee
                                return AppNumberField(
                                  title: context.tr.cancellationTotalFee,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onCancellationTotalFeeChanged(value),
                                  initialValue: state.cancellationTotalFee,
                                );

                              case 18: // cancellation Driver share
                                return AppNumberField(
                                  title: context.tr.cancellationDriverShare,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onCancellationDriverShareChanged(value),
                                  initialValue: state.cancellationDriverShare,
                                );
                              case 19: // Search Radius
                                return AppNumberField.integer(
                                  title: context.tr.searchRadius,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onSearchRadiusChanged(value ?? 0),
                                  initialValue: state.searchRadius,
                                );
                              case 20: // Display Priority
                                return AppNumberField.integer(
                                  title: context.tr.displayPriority,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onDisplayPriorityChanged(value ?? 0),
                                  initialValue: state.displayPriority,
                                );
                              case 21:
                                return AppNumberField.integer(
                                  title: context.tr.commissionPercentage,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onProviderSharePercentChanged(value),
                                  initialValue: state.providerSharePercent,
                                );
                              case 22:
                                return AppNumberField(
                                  title: context.tr.commissionFlat,
                                  onChanged: (value) => context
                                      .read<PricingDetailsBloc>()
                                      .onProviderShareFlatChanged(value),
                                  initialValue: state.providerShareFlat,
                                );

                              default:
                                return const SizedBox();
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        const SizedBox(height: 16),
                        _timeOfDayMutliplierTable(state, context),
                        const SizedBox(height: 24),
                        _distanceMutliplierTable(state, context),
                        const SizedBox(height: 24),
                        _weekdayMutliplierTable(state, context),
                        const SizedBox(height: 24),
                        _dateRangeMutliplierTable(state, context),
                        const SizedBox(height: 24),
                        _serviceOptionsTable(state, context),
                      ],
                    ),
                  ),
                ),
              },
            );
          },
        ),
      ),
    );
  }

  Widget _timeOfDayMutliplierTable(
    PricingDetailsState state,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LargeHeader(
          title: context.tr.timeOfDayMultiplier,
          actions: [
            AppFilledButton(
              text: context.tr.insert,
              prefixIcon: BetterIcons.addCircleOutline,
              onPressed: () async {
                final bloc = context.read<PricingDetailsBloc>();
                final dialogResult =
                    await showDialog<Input$TimeMultiplierInput>(
                      context: context,
                      builder: (context) =>
                          const AddTimeOfDayMultiplierDialog(),
                    );
                if (dialogResult != null) {
                  bloc.onTimeMultiplierAdded(dialogResult);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: DataTable2(
            showCheckboxColumn: false,
            decoration: const BoxDecoration(),
            headingTextStyle: context.textTheme.bodyMedium,
            dataTextStyle: context.textTheme.labelLarge,
            rows: state.timeMultipliers
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(Text("${e.startTime} -> ${e.endTime}")),
                      DataCell(Text("${e.multiply.toString()}x")),
                      DataCell(
                        AppIconButton(
                          icon: BetterIcons.delete03Outline,
                          color: SemanticColor.error,
                          onPressed: () {
                            context
                                .read<PricingDetailsBloc>()
                                .onTimeMultiplierRemoved(e);
                          },
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
            headingRowHeight: 45,
            dataRowHeight: 64,
            empty: TableEmptyState(message: context.tr.noTimeMultipliers),
            columns: [
              DataColumn(label: Text(context.tr.time)),
              DataColumn(label: Text(context.tr.multiplyBy)),
              const DataColumn(label: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _distanceMutliplierTable(
    PricingDetailsState state,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LargeHeader(
          title: context.tr.distanceMultiplier,
          actions: [
            AppFilledButton(
              text: context.tr.insert,
              prefixIcon: BetterIcons.addCircleOutline,
              onPressed: () async {
                final bloc = context.read<PricingDetailsBloc>();
                final dialogResult =
                    await showDialog<Input$DistanceMultiplierInput>(
                      context: context,
                      builder: (context) => const AddDistanceMultiplierDialog(),
                    );
                if (dialogResult != null) {
                  bloc.onDistanceMultiplierAdded(dialogResult);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: DataTable2(
            showCheckboxColumn: false,
            decoration: const BoxDecoration(),
            headingTextStyle: context.textTheme.bodyMedium,
            dataTextStyle: context.textTheme.labelLarge,
            rows: state.distanceMultipliers
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          "${e.distanceFrom.toInt()} - ${e.distanceTo.toInt()}",
                        ),
                      ),
                      DataCell(Text("${e.multiply.toString()}x")),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppIconButton(
                              icon: BetterIcons.delete03Outline,
                              color: SemanticColor.error,
                              onPressed: () {
                                context
                                    .read<PricingDetailsBloc>()
                                    .onDistanceMultiplierRemoved(e);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
            headingRowHeight: 45,
            dataRowHeight: 64,
            empty: TableEmptyState(message: context.tr.noDistanceMultipliers),
            columns: [
              DataColumn(label: Text(context.tr.time)),
              DataColumn(label: Text(context.tr.multiplyBy)),
              const DataColumn(label: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weekdayMutliplierTable(
    PricingDetailsState state,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LargeHeader(
          title: context.tr.weekdayMultiplier,
          actions: [
            AppFilledButton(
              text: context.tr.insert,
              prefixIcon: BetterIcons.addCircleOutline,
              onPressed: () async {
                final bloc = context.read<PricingDetailsBloc>();
                final dialogResult =
                    await showDialog<Input$WeekdayMultiplierInput>(
                      context: context,
                      builder: (context) => const AddWeekdayMultiplierDialog(),
                    );
                if (dialogResult != null) {
                  bloc.onWeekdayMultiplierAdded(dialogResult);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: DataTable2(
            showCheckboxColumn: false,
            headingTextStyle: context.textTheme.bodyMedium,
            dataTextStyle: context.textTheme.labelLarge,
            decoration: const BoxDecoration(),
            rows: state.weekdayMultipliers
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(Text(e.weekday.name(context))),
                      DataCell(Text("${e.multiply.toString()}x")),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppIconButton(
                              icon: BetterIcons.delete03Outline,
                              color: SemanticColor.error,
                              onPressed: () {
                                context
                                    .read<PricingDetailsBloc>()
                                    .onWeekdayMultiplierRemoved(e);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
            headingRowHeight: 45,
            dataRowHeight: 64,
            empty: TableEmptyState(message: context.tr.noWeekdayMultipliers),
            columns: [
              DataColumn(label: Text(context.tr.time)),
              DataColumn(label: Text(context.tr.multiplyBy)),
              const DataColumn(label: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dateRangeMutliplierTable(
    PricingDetailsState state,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LargeHeader(
          title: context.tr.dateRangeMultiplier,
          actions: [
            AppFilledButton(
              text: context.tr.insert,
              prefixIcon: BetterIcons.addCircleOutline,
              onPressed: () async {
                final bloc = context.read<PricingDetailsBloc>();
                final dialogResult =
                    await showDialog<Input$DateRangeMultiplierInput>(
                      context: context,
                      builder: (context) =>
                          const AddDateRangeMultiplierDialog(),
                    );
                if (dialogResult != null) {
                  bloc.onDateRangeMultiplierAdded(dialogResult);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: DataTable2(
            showCheckboxColumn: false,
            headingTextStyle: context.textTheme.bodyMedium,
            dataTextStyle: context.textTheme.labelLarge,
            decoration: const BoxDecoration(),
            rows: state.dateRangeMultipliers
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          (
                            DateTime.fromMillisecondsSinceEpoch(
                              e.startDate.toInt(),
                            ),
                            DateTime.fromMillisecondsSinceEpoch(
                              e.endDate.toInt(),
                            ),
                          ).toRange(context),
                        ),
                      ),
                      DataCell(Text("${e.multiply.toString()}x")),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppIconButton(
                              icon: BetterIcons.delete03Outline,
                              color: SemanticColor.error,
                              onPressed: () {
                                context
                                    .read<PricingDetailsBloc>()
                                    .onDateRangeMultiplierRemoved(e);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
            headingRowHeight: 45,
            dataRowHeight: 64,
            empty: TableEmptyState(message: context.tr.noDateRangeMultipliers),
            columns: [
              DataColumn(label: Text(context.tr.time)),
              DataColumn(label: Text(context.tr.multiplyBy)),
              const DataColumn(label: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }

  bool get isEdit => pricingId != null;

  Column _serviceOptionsTable(PricingDetailsState state, BuildContext context) {
    return Column(
      children: [
        LargeHeader(
          title: context.tr.serviceOptions,
          actions: [
            AppFilledButton(
              text: context.tr.insert,
              prefixIcon: BetterIcons.addCircleOutline,
              onPressed: () async {
                final dialogResult = await showDialog<bool>(
                  context: context,
                  useSafeArea: false,
                  builder: (context) {
                    return const AddServiceOptionDialog();
                  },
                );
                if (dialogResult == true) {
                  context.read<PricingDetailsBloc>().refreshOptions();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: DataTable2(
            showCheckboxColumn: false,
            headingTextStyle: context.textTheme.bodyMedium,
            dataTextStyle: context.textTheme.labelLarge,
            decoration: const BoxDecoration(),
            rows: state.options
                .map(
                  (e) => DataRow(
                    selected: state.serviceOptionIds.contains(e.id),
                    onSelectChanged: (value) {
                      context
                          .read<PricingDetailsBloc>()
                          .onServiceOptionSelected(e, value);
                    },
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            Icon(e.icon.icon, color: context.colors.primary),
                            const SizedBox(width: 8),
                            Text(e.name),
                          ],
                        ),
                      ),
                      DataCell(Row(children: [e.type.chip(context)])),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppIconButton(
                              icon: BetterIcons.delete03Outline,
                              color: SemanticColor.error,
                              onPressed: () {
                                context
                                    .read<PricingDetailsBloc>()
                                    .onServiceOptionRemoved(e);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
            headingRowHeight: 45,
            dataRowHeight: 64,
            empty: TableEmptyState(message: context.tr.noServiceOptions),
            columns: [
              DataColumn(label: Text(context.tr.name)),
              DataColumn(label: Text(context.tr.description)),
              const DataColumn(label: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }
}
