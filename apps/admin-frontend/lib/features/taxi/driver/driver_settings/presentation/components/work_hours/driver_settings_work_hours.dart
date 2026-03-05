import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/work_hours/driver_settings_work_hours_add_shift_rule.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/work_hours/driver_settings_work_hours_mandatory_break_minutes.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/work_hours/driver_settings_work_hours_max_hours_frequency.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/work_hours/driver_settings_work_hours_remove_shift_rule.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/components/work_hours/driver_settings_work_hours_time_freuency.dart';
import 'package:better_icons/better_icons.dart';

class DriverSettingsWorkHours extends StatelessWidget {
  const DriverSettingsWorkHours({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverSettingsBloc>();
    return Form(
      key: formKey,
      child: BlocBuilder<DriverSettingsBloc, DriverSettingsState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state.driverShiftRulesState.isLoading,
            enableSwitchAnimation: true,
            child: Theme(
              data: context.theme.copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: LargeHeader(title: context.tr.workHours),
                subtitle: const Column(
                  children: [SizedBox(height: 16), Divider(height: 1)],
                ),
                initiallyExpanded: true,
                children: [
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.driverShiftRulesState.isLoading
                            ? 2
                            : state.driverShiftRules.length,
                        separatorBuilder: (context, index) {
                          if (state.driverShiftRulesState.isLoaded) {
                            return const Divider(height: 16);
                          } else {
                            return const Divider(height: 16);
                          }
                        },
                        itemBuilder: (context, index) {
                          var driverShiftRule =
                              state.driverShiftRulesState.isLoading
                              ? Fragment$driverShiftRule(
                                  id: "0",
                                  maxHoursPerFrequency: 0,
                                  mandatoryBreakMinutes: 0,
                                  timeFrequency: Enum$TimeFrequency.Daily,
                                )
                              : state.driverShiftRules[index];
                          return context.responsive(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 8),
                                Text(
                                  context.tr.timeFrequency,
                                  style: context.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 8),
                                DriverSettingsWorkHoursTimeFrequency(
                                  driverShiftRule: driverShiftRule,
                                  index: index,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  context.tr.maxHoursPerFrequency,
                                  style: context.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 8),
                                DriverSettingsWorkHoursMaxHoursFrequency(
                                  driverShiftRule: driverShiftRule,
                                  index: index,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  context.tr.mandatoryBreakMinutes,
                                  style: context.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 8),
                                DriverSettingsWorkHoursMandatoryBreakMinutes(
                                  driverShiftRule: driverShiftRule,
                                  index: index,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:
                                          DriverSettingsWorkHoursRemoveShiftRule(
                                            index: index,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            lg: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              bloc.removeShiftRule(index);
                                            },
                                            minimumSize: Size(0, 0),
                                            child: Icon(
                                              BetterIcons.cancel01Outline,
                                              size: 24,
                                              color: context.colors.error,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            context.tr.timeFrequency,
                                            style: context.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child:
                                          DriverSettingsWorkHoursTimeFrequency(
                                            driverShiftRule: driverShiftRule,
                                            index: index,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        context.tr.maxHoursPerFrequency,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ),
                                    Expanded(
                                      child:
                                          DriverSettingsWorkHoursMaxHoursFrequency(
                                            driverShiftRule: driverShiftRule,
                                            index: index,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        context.tr.mandatoryBreakMinutes,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ),
                                    Expanded(
                                      child:
                                          DriverSettingsWorkHoursMandatoryBreakMinutes(
                                            driverShiftRule: driverShiftRule,
                                            index: index,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  context.responsive(
                    const Divider(height: 32),
                    lg: const SizedBox(height: 16),
                  ),
                  context.responsive(
                    const Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: DriverSettingsWorkHoursAddShiftRule(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    lg: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [DriverSettingsWorkHoursAddShiftRule()],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
