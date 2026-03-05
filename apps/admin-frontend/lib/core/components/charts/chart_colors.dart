import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

const pieChartColors = [
  Color(0xFF0253E8),
  Color(0xFF6C00FF),
  Color(0xFFFF1B68),
];

const pieChartThinColors = [
  Color(0xFF00B8D9),
  Color(0xFF00A76F),
  Color(0xFFFFAB00),
  Color(0xFFFF5630),
];

List<Color> activeInactiveColors(BuildContext context) => [
  context.colors.primary,
  context.colors.primary.withValues(alpha: 0.6),
];

final activeInactiveColorsAlternative = [Color(0xFF00D5FF), Color(0xFFE80054)];

const vibrantColors = [
  Color(0xFF7209B7),
  Color(0xFF00A76F),
  Color(0xFFFFC300),
  Color(0xFFFF1B68),
];
