import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockDriverShiftRule1 = Fragment$driverShiftRule(
  id: '1',
  maxHoursPerFrequency: 3,
  mandatoryBreakMinutes: 4,
  timeFrequency: Enum$TimeFrequency.Monthly,
);

final mockDriverShiftRule2 = Fragment$driverShiftRule(
  id: '1',
  maxHoursPerFrequency: 2,
  mandatoryBreakMinutes: 10,
  timeFrequency: Enum$TimeFrequency.Daily,
);

final mockDriverShiftRuleList = [mockDriverShiftRule1, mockDriverShiftRule2];
