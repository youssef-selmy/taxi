import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:collection/collection.dart';

extension DriverShiftRuleFragmentX on Fragment$driverShiftRule {
  Input$DriverShiftRuleInput toInput() => Input$DriverShiftRuleInput(
    maxHoursPerFrequency: maxHoursPerFrequency,
    mandatoryBreakMinutes: mandatoryBreakMinutes,
    timeFrequency: timeFrequency,
  );

  int maxHoursPerFrequencyInSeconds() => maxHoursPerFrequency * 3600;
}

extension DriverShiftRuleListFragmentX on List<Fragment$driverShiftRule> {
  List<Input$DriverShiftRuleInput> toInputList() {
    return map((e) => e.toInput()).toList();
  }

  int maxSecondsPerFrequency(Enum$TimeFrequency frequency) =>
      firstWhereOrNull(
        (e) => e.timeFrequency == frequency,
      )?.maxHoursPerFrequencyInSeconds() ??
      999999999;
}
