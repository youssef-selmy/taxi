import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item_widget.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'async_dropdown_state.dart';

/// Overlay widget for [AppAsyncDropdownField] that displays a search bar
/// and search results.
///
/// This widget handles the display of different states:
/// - Initial state with optional initial items
/// - Typing/loading state with spinner
/// - Success state with search results
/// - Empty state when no results found
/// - Error state when search fails
class AsyncDropdownOverlay<T> extends StatelessWidget {
  /// Width of the overlay, typically matches the trigger field width.
  final double width;

  /// Current search state.
  final AsyncDropdownState searchState;

  /// Search results to display.
  final List<AppDropdownItem<T>> items;

  /// Initial items shown before searching (e.g., recent or popular items).
  final List<AppDropdownItem<T>>? initialItems;

  /// Header text for initial items section (e.g., "Recent" or "Popular").
  final String? initialItemsHeader;

  /// Currently selected values.
  final List<T>? selectedValues;

  /// Whether multi-selection is enabled.
  final bool isMultiSelect;

  /// Callback when selection changes.
  final void Function(List<T>?) onChanged;

  /// Controller for the search text field.
  final TextEditingController searchController;

  /// Focus node for the search text field.
  final FocusNode searchFocusNode;

  /// Callback when search text changes.
  final void Function(String) onSearchChanged;

  /// Placeholder text for the search field.
  final String? searchHint;

  /// Text shown when search returns no results.
  final String? emptyResultsText;

  /// Custom widget for empty results state.
  final Widget? emptyResultsWidget;

  /// Error message to display in error state.
  final String? errorMessage;

  const AsyncDropdownOverlay({
    super.key,
    required this.width,
    required this.searchState,
    required this.items,
    this.initialItems,
    this.initialItemsHeader,
    required this.selectedValues,
    required this.isMultiSelect,
    required this.onChanged,
    required this.searchController,
    required this.searchFocusNode,
    required this.onSearchChanged,
    this.searchHint,
    this.emptyResultsText,
    this.emptyResultsWidget,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(maxHeight: 350),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.outline),
        boxShadow: context.isDark
            ? null
            : [
                BoxShadow(
                  color: context.colors.shadow,
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                  spreadRadius: 0,
                ),
              ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSearchBar(context),
          Divider(height: 1, color: context.colors.outline),
          Flexible(child: _buildContent(context)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: searchController,
        focusNode: searchFocusNode,
        onChanged: onSearchChanged,
        style: context.textTheme.labelMedium,
        decoration: InputDecoration(
          hintText: searchHint ?? context.strings.search,
          hintStyle: context.textTheme.labelMedium?.variant(context),
          prefixIcon: Icon(
            BetterIcons.search01Outline,
            size: 16,
            color: context.colors.onSurfaceVariant,
          ),
          suffixIcon: _buildSearchSuffix(context),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          filled: true,
          fillColor: context.colors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: context.colors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget? _buildSearchSuffix(BuildContext context) => switch (searchState) {
    AsyncDropdownState.typing || AsyncDropdownState.loading => Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 16,
        height: 16,
        child: CupertinoActivityIndicator(
          radius: 8,
          color: context.colors.primary,
        ),
      ),
    ),
    _ =>
      searchController.text.isNotEmpty
          ? IconButton(
              icon: Icon(
                BetterIcons.cancelCircleFilled,
                size: 16,
                color: context.colors.onSurfaceVariant,
              ),
              onPressed: () {
                searchController.clear();
                onSearchChanged('');
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            )
          : null,
  };

  Widget _buildContent(BuildContext context) => switch (searchState) {
    AsyncDropdownState.initial => _buildInitialState(context),
    AsyncDropdownState.typing ||
    AsyncDropdownState.loading => _buildLoadingState(context),
    AsyncDropdownState.success => _buildResultsList(context, items),
    AsyncDropdownState.empty => _buildEmptyState(context),
    AsyncDropdownState.error => _buildErrorState(context),
  };

  Widget _buildInitialState(BuildContext context) {
    if (initialItems != null && initialItems!.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (initialItemsHeader != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Text(
                initialItemsHeader!,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
          Flexible(child: _buildResultsList(context, initialItems!)),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            BetterIcons.search01Outline,
            size: 32,
            color: context.colors.onSurfaceVariantLow,
          ),
          const SizedBox(height: 8),
          Text(
            searchHint ?? context.strings.search,
            style: context.textTheme.bodyMedium?.variant(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 12,
          color: context.colors.primary,
        ),
      ),
    );
  }

  Widget _buildResultsList(
    BuildContext context,
    List<AppDropdownItem<T>> itemsToShow,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      itemCount: itemsToShow.length,
      separatorBuilder: (_, index) => const SizedBox(height: 4),
      itemBuilder: (_, index) {
        final item = itemsToShow[index];
        return AppDropdownItemWidget(
          item: item,
          isSelected: selectedValues?.contains(item.value) ?? false,
          isMultiSelect: isMultiSelect,
          onTap: () => _onItemTap(item),
        );
      },
    );
  }

  void _onItemTap(AppDropdownItem<T> item) {
    final currentSelected = selectedValues ?? [];

    if (currentSelected.contains(item.value)) {
      if (isMultiSelect) {
        onChanged(currentSelected.where((e) => e != item.value).toList());
      }
    } else {
      if (isMultiSelect) {
        onChanged([...currentSelected, item.value]);
      } else {
        onChanged([item.value]);
      }
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    return emptyResultsWidget ??
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                BetterIcons.searchRemoveOutline,
                size: 32,
                color: context.colors.onSurfaceVariantLow,
              ),
              const SizedBox(height: 8),
              Text(
                emptyResultsText ?? context.strings.noDataAvailable,
                style: context.textTheme.bodyMedium?.variant(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
  }

  Widget _buildErrorState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            BetterIcons.alertCircleFilled,
            size: 32,
            color: context.colors.error,
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage ?? context.strings.somethingWentWrong,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.error,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
