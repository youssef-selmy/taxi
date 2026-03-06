import 'package:api_response/api_response.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDataTable)
Widget defaultDataTable(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: SizedBox(
      width: 800,
      height: 500,
      child: AppDataTable(
        data: ApiResponse.loaded([]),
        getPageInfo:
            (_) => OffsetPageInfo(hasNextPage: true, hasPreviousPage: false),
        getRowCount: (_) => 3,
        onPageChanged: (_) {},
        paging: OffsetPaging(limit: 10, offset: 0),
        columns: [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Email")),
        ],
        rowBuilder: (p0, p1) {
          return DataRow(
            onSelectChanged: (_) {},
            cells: [
              DataCell(Text("1")),
              DataCell(Text("John Doe")),
              DataCell(Text("john.doe@example.com")),
            ],
          );
        },
      ),
    ),
  );
}
