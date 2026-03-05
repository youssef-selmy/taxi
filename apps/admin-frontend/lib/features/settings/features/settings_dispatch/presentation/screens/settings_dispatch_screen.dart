import 'package:admin_frontend/core/components/organisms/settings_components/settings_radio_tile.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/settings/features/settings_dispatch/presentation/components/dispatch_scoring_impact_breakdown.dart';
import 'package:admin_frontend/features/settings/features/settings_dispatch/presentation/components/settings_section.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_design_system/molecules/slider/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/settings/features/settings_dispatch/presentation/blocs/settings_dispatch.cubit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class SettingsDispatchScreen extends StatelessWidget {
  const SettingsDispatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsDispatchCubit()..onStarted(),
      child: BlocConsumer<SettingsDispatchCubit, SettingsDispatchState>(
        listenWhen: (previous, current) =>
            previous.saveSettingsResponse != current.saveSettingsResponse,
        listener: (context, state) {
          if (state.saveSettingsResponse.isError) {
            context.showFailure(state.saveSettingsResponse);
          }
          if (state.saveSettingsResponse.isLoaded) {
            context.showSuccess(context.tr.savedSuccessfully);
          }
        },
        builder: (context, state) {
          final bloc = context.read<SettingsDispatchCubit>();
          if (state.dispatchConfig.data == null) {
            return Center(child: CupertinoActivityIndicator());
          }
          return Form(
            key: state.formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppSettingsSection(
                    layout: SettingsSectionLayout.twoColumnCompact,
                    title: "Dispatch Strategy",
                    subtitle:
                        "Choose how dispatch requests are sent to drivers — all at once or one by one based on priority.",
                    children: [
                      AppSettingsRadioTile(
                        title: "Broadcast",
                        subtitle: "Notify all eligible drivers at once.",
                        value:
                            state.strategy == Enum$DispatchStrategy.Broadcast,
                        onSelected: () =>
                            bloc.setStrategy(Enum$DispatchStrategy.Broadcast),
                      ),
                      AppSettingsRadioTile(
                        title: "Sequential",
                        subtitle: "Notify drivers one by one.",
                        value:
                            state.strategy == Enum$DispatchStrategy.Sequential,
                        onSelected: () =>
                            bloc.setStrategy(Enum$DispatchStrategy.Sequential),
                      ),
                    ],
                  ),
                  const AppDivider(height: 24),
                  _commonOptions(context, state),
                  if (state.strategy == Enum$DispatchStrategy.Broadcast) ...[
                    const AppDivider(height: 24),
                    _broadcastOptions(state, bloc),
                  ],
                  if (state.strategy == Enum$DispatchStrategy.Sequential) ...[
                    const AppDivider(height: 24),
                    _sequentialOptions(context, state, bloc),
                  ],
                  const AppDivider(height: 24),
                  _scoringOptions(state, bloc, context),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppOutlinedButton(
                          onPressed: bloc.resetToDefaults,
                          text: context.tr.resetToDefault,
                        ),
                        AppFilledButton(
                          onPressed: () {
                            if (state.formKey.currentState?.validate() ??
                                false) {
                              bloc.saveSettings();
                            }
                          },
                          text: context.tr.saveChanges,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppSettingsSection _broadcastOptions(
    SettingsDispatchState state,
    SettingsDispatchCubit bloc,
  ) {
    return AppSettingsSection(
      layout: SettingsSectionLayout.threeColumn,
      title: "Broadcast Options",
      subtitle: "Customize how broadcast dispatching works.",
      children: [
        AppNumberField.integer(
          title: "Wave Size",
          subtitle: "Number of drivers to notify in each wave of a broadcast.",
          sublabel: "drivers",
          initialValue: state.broadcastWaveSize,
          validator: FormBuilderValidators.required(),
          isFilled: false,
          onChanged: (value) {
            bloc.setBroadcastWaveSize(value);
          },
        ),
        AppNumberField.integer(
          title: "Wave Interval",
          subtitle: "Time between each wave of notifications.",
          sublabel: "seconds",
          isFilled: false,
          initialValue: state.broadcastWaveIntervalSeconds,
          validator: FormBuilderValidators.required(),
          onChanged: (value) {
            bloc.setBroadcastWaveIntervalSeconds(value);
          },
        ),
        AppNumberField.integer(
          title: "Max Waves",
          subtitle: "Maximum number of waves to send.",
          sublabel: "waves",
          isFilled: false,
          initialValue: state.broadcastMaxWaves,
          validator: FormBuilderValidators.required(),
          onChanged: (value) {
            bloc.setBroadcastMaxWaves(value);
          },
        ),
        AppNumberField.integer(
          title: "Broadcast Radius Increment",
          subtitle:
              "Increase the broadcast radius by this amount for each wave.",
          sublabel: "meters",
          isFilled: false,
          initialValue: state.broadcastRadiusIncrementMeters,
          validator: FormBuilderValidators.required(),
          onChanged: (value) {
            bloc.setBroadcastRadiusIncrementMeters(value);
          },
        ),
      ],
    );
  }

  AppSettingsSection _sequentialOptions(
    BuildContext context,
    SettingsDispatchState state,
    SettingsDispatchCubit bloc,
  ) {
    return AppSettingsSection(
      layout: SettingsSectionLayout.threeColumn,
      title: "Sequential Options",
      subtitle: "Customize how sequential dispatching works.",
      children: [
        AppNumberField.integer(
          title: "Per Driver Timeout",
          subtitle:
              "Time to wait for each driver to accept before moving to the next.",
          sublabel: "seconds",
          initialValue: state.sequentialPerDriverRequestTimeoutSeconds,
          isFilled: false,
          validator: FormBuilderValidators.required(),
          onChanged: bloc.setSequentialPerDriverRequestTimeoutSeconds,
        ),
        AppNumberField.integer(
          title: "Max Drivers to Test",
          subtitle:
              "Maximum number of drivers to notify in a sequential dispatch.",
          sublabel: "drivers",
          isFilled: false,
          initialValue: state.sequentialMaxDriversToTest,
          validator: FormBuilderValidators.required(),
          onChanged: bloc.setSequentialMaxDriversToTest,
        ),
        AppNumberField.integer(
          title: "Max Retries Per Driver",
          subtitle: "Maximum number of retries for each driver.",
          sublabel: "times",
          isFilled: false,
          initialValue: state.sequentialDriverRetryLimit,
          validator: FormBuilderValidators.required(),
          onChanged: bloc.setSequentialDriverRetryLimit,
        ),
      ],
    );
  }

  Column _scoringOptions(
    SettingsDispatchState state,
    SettingsDispatchCubit bloc,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSettingsSection(
          layout: SettingsSectionLayout.twoColumnExpanded,
          title: "Driver Scoring Configuration",
          subtitle: "Customize how drivers are scored during dispatch.",
          children: [
            AppSlider(
              label: "Distance Weight",
              sublabel: "points",
              value: state.distanceWeight ?? 50,
              minValue: 0,
              maxValue: 100,
              onChanged: (double value) {
                bloc.setDistanceWeight(value);
              },
            ),
            AppSlider(
              label: "Driver Rating Weight",
              sublabel: "points",
              value: state.driverRatingWeight ?? 50,
              minValue: 0,
              maxValue: 100,
              onChanged: (double value) {
                bloc.setDriverRatingWeight(value);
              },
            ),
            AppSlider(
              label: "Idle Time Weight",
              sublabel: "points",
              value: state.idleTimeWeight ?? 50,
              minValue: 0,
              maxValue: 100,
              onChanged: (double value) {
                bloc.setIdleTimeWeight(value);
              },
            ),
            AppSlider(
              label: "Cancel Rate Weight",
              sublabel: "points",
              value: state.cancelRateWeight ?? 50,
              minValue: 0,
              maxValue: 100,
              onChanged: (double value) {
                bloc.setCancelRateWeight(value);
              },
            ),
            AppNumberField(
              title: "Threshold",
              sublabel: "points",
              initialValue: state.threshold,
              validator: FormBuilderValidators.required(),
              isFilled: false,
              onChanged: (value) {
                if (value != null) {
                  bloc.setThreshold(value);
                }
              },
            ),
            AppNumberField.integer(
              title: "Top N",
              sublabel: "drivers",
              initialValue: state.topN,
              validator: FormBuilderValidators.required(),
              isFilled: false,
              onChanged: (value) {
                if (value != null) {
                  bloc.setTopN(value);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text("Impact Breakdown", style: context.textTheme.labelLarge),
        const SizedBox(height: 8),
        AppDispatchScoringImpactBreakdown(
          distanceWeight: state.distanceWeight ?? 50,
          driverRatingWeight: state.driverRatingWeight ?? 50,
          idleTimeWeight: state.idleTimeWeight ?? 50,
          cancelRateWeight: state.cancelRateWeight ?? 50,
        ),
      ],
    );
  }

  AppSettingsSection _commonOptions(
    BuildContext context,
    SettingsDispatchState state,
  ) {
    return AppSettingsSection(
      layout: SettingsSectionLayout.twoColumnExpanded,
      title: "Common Options",
      subtitle: "Define settings that apply to both dispatch strategies.",
      children: [
        AppNumberField.integer(
          title: "Request Expiry Time",
          subtitle:
              "Time after which a dispatch request expires if not accepted by any driver.",
          sublabel: "seconds",
          initialValue: state.requestTimeoutSeconds,
          validator: FormBuilderValidators.required(),
          isFilled: false,
          onChanged: context
              .read<SettingsDispatchCubit>()
              .setRequestTimeoutSeconds,
        ),
        AppNumberField.integer(
          title: "Search Area",
          subtitle: "Define the area in which drivers are notified.",
          initialValue: state.maxSearchRadiusMeters,
          validator: FormBuilderValidators.required(),
          sublabel: "meters",
          isFilled: false,
          onChanged: context
              .read<SettingsDispatchCubit>()
              .setMaxSearchRadiusMeters,
        ),
        AppNumberField.integer(
          title: "Pre-Dispatch Buffer",
          subtitle:
              "Dispatches scheduled orders this many minutes before the scheduled pickup time to ensure on-time driver arrival.",
          sublabel: "minutes",
          initialValue: state.preDispatchBufferMinutes,
          validator: FormBuilderValidators.required(),
          onChanged: context
              .read<SettingsDispatchCubit>()
              .setPreDispatchBufferMinutes,
          isFilled: false,
        ),
      ],
    );
  }
}
