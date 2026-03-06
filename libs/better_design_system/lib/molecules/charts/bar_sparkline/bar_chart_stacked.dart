// import 'dart:core';

// import 'package:better_design_system/molecules/charts/chart_helper.dart';
// import 'package:better_design_system/molecules/charts/chart_series_data.dart';
// import 'package:flutter/material.dart';
// import 'package:collection/collection.dart';
// import 'package:fl_chart/fl_chart.dart';

// class BarChartStacked extends StatelessWidget {
//   final List<ChartSeriesData> data;
//   final String Function(String)? bottomTitleBuilder;
//   final String Function(double)? leftTitleBuilder;
//   final double leftReservedSize;

//   const BarChartStacked({
//     super.key,
//     required this.data,
//     this.bottomTitleBuilder,
//     this.leftTitleBuilder,
//     this.leftReservedSize = 44,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final allDayKeys =
//         data
//             .expand((series) => series.points.map((e) => e.name))
//             .toSet()
//             .toList();

//     return BarChart(
//       BarChartData(
//         titlesData:
//             bottomTitleBuilder == null
//                 ? FlTitlesData(show: false)
//                 : FlTitlesData(
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         final index = value.toInt();
//                         if (index >= 0 && index < allDayKeys.length) {
//                           return Text(bottomTitleBuilder!(allDayKeys[index]));
//                         }
//                         return const SizedBox();
//                       },
//                       reservedSize: 32,
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: leftReservedSize,
//                       getTitlesWidget:
//                           (value, meta) => Text(
//                             leftTitleBuilder?.call(value) ?? value.toString(),
//                           ),
//                     ),
//                   ),
//                   rightTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   topTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                 ),
//         gridData: barChartGridData(context),
//         barTouchData: BarTouchData(enabled: false),
//         borderData: FlBorderData(show: false),
//         alignment: BarChartAlignment.spaceAround,
//         barGroups:
//             allDayKeys.mapIndexed((index, dayKey) {
//               final stackItems = <BarChartRodStackItem>[];
//               double startY = 0.0;
//               for (var series in data) {
//                 final point = series.points.firstWhereOrNull(
//                   (p) => p.name == dayKey,
//                 );
//                 if (point != null) {
//                   final endY = startY + point.value;
//                   stackItems.add(
//                     BarChartRodStackItem(startY, endY, series.color),
//                   );
//                   startY = endY;
//                 }
//               }

//               return BarChartGroupData(
//                 x: index,
//                 barRods: [
//                   BarChartRodData(
//                     toY: startY,
//                     rodStackItems: stackItems,
//                     width: 24,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                 ],
//               );
//             }).toList(),
//       ),
//     );
//   }
// }
