import 'package:api_response/api_response.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'table_pagination.dart';
import 'table_search_field_compact.dart';
import 'table_search_field_large.dart';
export 'title_size.dart';
export 'package:data_table_2/data_table_2.dart';
export 'offset_page_info.dart';
export 'offset_paging.dart';
export 'table_empty_state.dart';
export 'package:better_design_system/molecules/sort_dropdown/sort_dropdown.dart';
export 'package:better_design_system/molecules/filter_dropdown/filter_dropdown.dart';
export 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

part 'search_bar_options.dart';

typedef BetterDataTable = AppDataTable;

class AppDataTable<T, L> extends StatelessWidget {
  final List<DataColumn?> columns;
  final String? title;
  final String? subtitle;
  final TitleSize titleSize;
  final ApiResponse<T> data;
  final int Function(T) getRowCount;
  final OffsetPageInfo Function(T)? getPageInfo;
  final DataRow Function(T, int) rowBuilder;
  final TableSearchBarOptions searchBarOptions;
  final AppSortDropdown<L>? sortOptions;
  final List<AppFilterDropdown> filterOptions;
  final List<Widget> actions;
  final Function(OffsetPaging)? onPageChanged;
  final OffsetPaging? paging;
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
    this.getPageInfo,
    this.searchBarOptions = const TableSearchBarOptions(enabled: false),
    this.actions = const [],
    this.sortOptions,
    this.filterOptions = const [],
    this.title,
    this.subtitle,
    required this.data,
    this.onPageChanged,
    this.titleSize = TitleSize.large,
    this.isHeaderTransparent = false,
    this.empty = const TableEmptyState(),
    this.dataRowHeight = 64,
    this.paging,
    this.useSafeArea = true,
    this.minWidth,
    this.fixedLeftColumns = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null) ...[
                    Text(title!, style: titleSize.style(context)),
                    if (subtitle != null) ...[
                      Text(subtitle!, style: titleSize.subTitleStyle(context)),
                    ],
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
            if (!searchBarOptions.enabled) ...[
              ...actions.map(
                (e) =>
                    Padding(padding: const EdgeInsets.only(left: 16), child: e),
              ),
            ],
            if (searchBarOptions.enabled && searchBarOptions.isCompact) ...[
              SizedBox(
                width: context.isMobile ? 150 : 250,
                child: TableSearchFieldCompact(
                  onChanged: (query) {
                    searchBarOptions.onChanged?.call(query);
                  },
                  initialValue: searchBarOptions.query ?? '',
                  hintText:
                      searchBarOptions.hintText ??
                      context.strings.searchWithDots,
                ),
              ),
              ...actions.map(
                (e) =>
                    Padding(padding: const EdgeInsets.only(left: 16), child: e),
              ),
            ],
          ],
        ),
        if (title != null ||
            (searchBarOptions.enabled && searchBarOptions.isCompact))
          const SizedBox(height: 12),
        if (searchBarOptions.enabled && !searchBarOptions.isCompact) ...[
          Row(
            children: [
              Expanded(
                child: TableSearchFieldLarge(
                  onChanged: (query) {
                    searchBarOptions.onChanged?.call(query);
                  },
                  initialValue: searchBarOptions.query ?? '',
                  hintText: searchBarOptions.hintText ?? 'Search...',
                ),
              ),
              ...actions.map(
                (e) =>
                    Padding(padding: const EdgeInsets.only(left: 16), child: e),
              ),
            ],
          ),
          const Divider(height: 12),
        ],
        if (sortOptions != null || filterOptions.isNotEmpty) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (sortOptions != null) sortOptions!,
                if (filterOptions.isNotEmpty) ...[
                  ...filterOptions.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: e,
                    );
                  }),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
        Expanded(
          child: SafeArea(
            top: false,
            bottom: useSafeArea,
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: switch (data) {
                ApiResponseInitial() => const SizedBox(),
                ApiResponseLoading() => _loadingSkeletonBuilder(context),
                ApiResponseError(:final message) => Text(message),
                ApiResponseLoaded(:final data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: DataTable2(
                        isHorizontalScrollBarVisible: true,
                        horizontalScrollController: ScrollController(),
                        showCheckboxColumn: false,
                        minWidth: minWidth ?? (columns.length > 2 ? 800 : null),
                        decoration: const BoxDecoration(),
                        fixedLeftColumns: fixedLeftColumns,
                        headingTextStyle: context.textTheme.bodyMedium,
                        dataTextStyle: context.textTheme.labelLarge,
                        headingRowColor: isHeaderTransparent
                            ? WidgetStatePropertyAll(context.colors.transparent)
                            : WidgetStatePropertyAll(
                                context.colors.surfaceVariantLow,
                              ),
                        headingRowDecoration: isHeaderTransparent
                            ? const BoxDecoration()
                            : null,
                        rows: List.generate(
                          getRowCount(data),
                          (index) => rowBuilder(data, index),
                        ),
                        headingRowHeight: 45,
                        dataRowHeight: dataRowHeight,
                        dataRowColor: WidgetStateColor.fromMap({
                          WidgetState.selected: context.colors.surfaceVariant,
                          WidgetState.focused: context.colors.surfaceVariant,
                          WidgetState.hovered: context.colors.surfaceVariantLow,
                          WidgetState.pressed: context.colors.surfaceVariant,
                          WidgetState.any: context.colors.transparent,
                        }),
                        empty: empty,
                        sortArrowBuilder: (ascending, sorted) =>
                            _sortArrowBuilder(context, ascending, sorted),
                        columns: columns.nonNulls.toList(),
                      ),
                    ),
                    if (getPageInfo?.call(data) != null &&
                        onPageChanged != null) ...[
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TablePagination(
                          pageInfo: getPageInfo!.call(data),
                          paging: paging,
                          onPageChanged: onPageChanged!,
                        ),
                      ),
                    ],
                  ],
                ),
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _loadingSkeletonBuilder(BuildContext context) => DataTable2(
    columns: columns.nonNulls.toList(),
    decoration: const BoxDecoration(),
    minWidth: minWidth ?? (columns.length > 2 ? 800 : null),
    horizontalScrollController: ScrollController(),
    headingTextStyle: context.textTheme.bodyMedium,
    dataTextStyle: context.textTheme.labelLarge,
    isHorizontalScrollBarVisible: true,
    // empty: Skeletonizer(
    //   enableSwitchAnimation: true,
    //   enabled: true,
    //   child: ListView.builder(
    //     padding: EdgeInsets.all(0),
    //     shrinkWrap: true,
    //     itemCount: 10,
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         title: Row(
    //           children: columns
    //               .map(
    //                 (column) => Expanded(
    //                   child: Text('Item number $index as title'),
    //                 ),
    //               )
    //               .toList(),
    //         ),
    //         subtitle: const Text('Subtitle here'),
    //         leading: const Icon(
    //           Icons.ac_unit,
    //           size: 40,
    //         ),
    //       );
    //     },
    //   ),
    // ),
    rows: List.generate(
      10,
      (i) => DataRow(
        cells: columns
            .map(
              (column) => DataCell(
                Skeletonizer(enabled: true, child: Text('Item number $i')),
              ),
            )
            .toList(),
      ),
    ),
  );

  Widget _sortArrowBuilder(BuildContext context, bool ascending, bool sorted) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          if (sorted == false) ...[
            Icon(
              BetterIcons.arrowDown01Outline,
              size: 16,
              color: context.colors.onSurfaceVariant,
            ),
          ],
          if (ascending && sorted != false)
            Icon(
              BetterIcons.arrowDown01Outline,
              size: 16,
              color: context.colors.onSurfaceVariant,
            ),
          if (!ascending && sorted != false)
            Icon(
              BetterIcons.arrowUp01Filled,
              size: 16,
              color: context.colors.onSurfaceVariant,
            ),
        ],
      ),
    );
  }
}
