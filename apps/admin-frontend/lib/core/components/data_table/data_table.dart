import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/organisms/data_table/offset_page_info.dart';
import 'package:better_design_system/organisms/data_table/offset_paging.dart';
import 'package:better_design_system/organisms/data_table/table_empty_state.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

import 'package:better_design_system/organisms/data_table/data_table.dart'
    as better_data_table;

export 'package:better_design_system/organisms/data_table/data_table.dart';

class AppDataTable<T, S> extends StatelessWidget {
  final List<DataColumn?> columns;
  final String? title;
  final String? subtitle;
  final better_data_table.TitleSize titleSize;
  final ApiResponse<T> data;
  final int Function(T) getRowCount;
  final Fragment$OffsetPageInfo Function(T)? getPageInfo;
  final DataRow Function(T, int) rowBuilder;
  final better_data_table.TableSearchBarOptions searchBarOptions;
  final better_data_table.AppSortDropdown<S>? sortOptions;
  final List<better_data_table.AppFilterDropdown> filterOptions;
  final List<Widget> actions;
  final Function(Input$OffsetPaging) onPageChanged;
  final Input$OffsetPaging? paging;
  final bool isHeaderTransparent;
  final Widget? empty;
  final double dataRowHeight;
  final bool useSafeArea;
  final double? minWidth;
  final int fixedLeftColumns;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.getRowCount,
    required this.rowBuilder,
    required this.getPageInfo,
    this.searchBarOptions = const better_data_table.TableSearchBarOptions(
      enabled: false,
    ),
    this.actions = const [],
    this.sortOptions,
    this.filterOptions = const [],
    this.title,
    this.subtitle,
    required this.data,
    required this.onPageChanged,
    this.titleSize = better_data_table.TitleSize.large,
    this.isHeaderTransparent = false,
    this.empty = const TableEmptyState(),
    this.dataRowHeight = 64,
    required this.paging,
    this.useSafeArea = true,
    this.minWidth,
    this.fixedLeftColumns = 0,
  });

  @override
  Widget build(BuildContext context) {
    return better_data_table.AppDataTable<T, S>(
      columns: columns,
      getRowCount: getRowCount,
      rowBuilder: rowBuilder,
      getPageInfo: (data) {
        final pageInfo = getPageInfo?.call(data);
        return OffsetPageInfo(
          hasNextPage: pageInfo?.hasNextPage ?? false,
          hasPreviousPage: pageInfo?.hasPreviousPage ?? false,
        );
      },
      data: data,
      onPageChanged: (paging) {
        onPageChanged(
          Input$OffsetPaging(limit: paging.limit, offset: paging.offset),
        );
      },
      paging: OffsetPaging(
        limit: paging?.limit ?? 10,
        offset: paging?.offset ?? 0,
      ),
      searchBarOptions: searchBarOptions,
      sortOptions: sortOptions,
      subtitle: subtitle,
      title: title,
      titleSize: titleSize,
      isHeaderTransparent: isHeaderTransparent,
      filterOptions: filterOptions,
      actions: actions,
      empty: empty,
      dataRowHeight: dataRowHeight,
      useSafeArea: useSafeArea,
      minWidth: minWidth,
      fixedLeftColumns: fixedLeftColumns,
    );
  }
}
