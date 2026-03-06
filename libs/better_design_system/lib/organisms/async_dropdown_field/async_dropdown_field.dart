import 'dart:async';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field_type.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

import '../../../atoms/input_fields/base_components/input_hint.dart';
import '../../../atoms/input_fields/base_components/input_label.dart';
import 'async_dropdown_overlay.dart';
import 'async_dropdown_state.dart';

export 'async_dropdown_overlay.dart';
export 'async_dropdown_state.dart';

typedef BetterAsyncDropdownField = AppAsyncDropdownField;

/// A dropdown field that fetches items asynchronously based on user search input.
///
/// This component provides a search-enabled dropdown that loads items from a
/// remote data source. It supports both single and multi-select modes.
///
/// Example:
/// ```dart
/// AppAsyncDropdownField<User>.single(
///   label: 'Select User',
///   hint: 'Search users...',
///   searchHint: 'Type to search users',
///   initialItems: recentUsers,
///   initialItemsHeader: 'Recent',
///   onSearch: (query) => userRepository.search(query),
///   onChanged: (user) => print('Selected: $user'),
/// )
/// ```
class AppAsyncDropdownField<T> extends StatefulWidget {
  // ============================================================================
  // Search Configuration
  // ============================================================================

  /// Callback to fetch items based on search query.
  /// Returns an [ApiResponse] containing a list of [AppDropdownItem].
  final Future<ApiResponse<List<AppDropdownItem<T>>>> Function(String query)
  onSearch;

  /// Duration to wait after user stops typing before triggering search.
  /// Defaults to 500 milliseconds.
  final Duration debounceDuration;

  /// Minimum query length required before triggering search.
  /// Defaults to 0 (search on any input).
  final int minQueryLength;

  /// Placeholder text shown in the search input field.
  final String? searchHint;

  // ============================================================================
  // Initial Items Configuration
  // ============================================================================

  /// Initial items shown before searching (e.g., recent or popular items).
  final List<AppDropdownItem<T>>? initialItems;

  /// Header text for initial items section (e.g., "Recent" or "Popular").
  final String? initialItemsHeader;

  // ============================================================================
  // Selection Configuration
  // ============================================================================

  /// Initial selected values.
  final List<T>? initialValue;

  /// Callback when a single item is selected (single-select mode).
  final void Function(T?)? onChanged;

  /// Callback when items are selected (multi-select mode).
  final void Function(List<T>?)? onMultiChanged;

  /// Whether multiple items can be selected.
  final bool isMultiSelect;

  /// Whether to show chips for selected items below the field.
  final bool showChips;

  // ============================================================================
  // Field Configuration
  // ============================================================================

  /// Field label displayed above the input.
  final String? label;

  /// Secondary label displayed next to the main label.
  final String? sublabel;

  /// Whether the field is required (shows indicator next to label).
  final bool isRequired;

  /// Hint text shown when no value is selected.
  final String? hint;

  /// Help text shown below the field.
  final String? helpText;

  /// Color for the help text.
  final SemanticColor helpTextColor;

  /// Whether to use filled background style.
  final bool isFilled;

  /// Fixed width for the field.
  final double? width;

  /// Icon displayed as prefix in the trigger field.
  final IconData? prefixIcon;

  /// Whether the field is disabled.
  final bool isDisabled;

  /// Field type affecting padding and styling.
  final DropdownFieldType type;

  /// Custom fill color for the field.
  final Color? fillColor;

  /// Custom border radius for the field.
  final BorderRadius? borderRadius;

  // ============================================================================
  // Form Integration
  // ============================================================================

  /// Callback when form is saved.
  final Function(List<T>?)? onSaved;

  /// Validator for form validation.
  final String? Function(List<T>?)? validator;

  // ============================================================================
  // Behavior Configuration
  // ============================================================================

  /// Whether to close the overlay after selection.
  /// Defaults to true for single-select, always false for multi-select.
  final bool closeOnSelect;

  /// Whether to clear the search query after an item is selected.
  final bool clearSearchOnSelect;

  // ============================================================================
  // Empty/Error States
  // ============================================================================

  /// Text shown when search returns no results.
  final String? emptyResultsText;

  /// Custom widget for empty results state.
  final Widget? emptyResultsWidget;

  const AppAsyncDropdownField({
    super.key,
    required this.onSearch,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.minQueryLength = 0,
    this.searchHint,
    this.initialItems,
    this.initialItemsHeader,
    this.initialValue,
    this.onChanged,
    this.onMultiChanged,
    this.isMultiSelect = false,
    this.showChips = false,
    this.label,
    this.sublabel,
    this.isRequired = false,
    this.hint,
    this.helpText,
    this.helpTextColor = SemanticColor.neutral,
    this.isFilled = true,
    this.width,
    this.onSaved,
    this.validator,
    this.prefixIcon,
    this.isDisabled = false,
    this.type = DropdownFieldType.normal,
    this.fillColor,
    this.borderRadius,
    this.closeOnSelect = true,
    this.clearSearchOnSelect = true,
    this.emptyResultsText,
    this.emptyResultsWidget,
  });

  /// Creates a single-select async dropdown field.
  factory AppAsyncDropdownField.single({
    Key? key,
    required Future<ApiResponse<List<AppDropdownItem<T>>>> Function(
      String query,
    )
    onSearch,
    Duration debounceDuration = const Duration(milliseconds: 500),
    int minQueryLength = 0,
    String? searchHint,
    List<AppDropdownItem<T>>? initialItems,
    String? initialItemsHeader,
    T? initialValue,
    void Function(T?)? onChanged,
    String? label,
    String? sublabel,
    bool isRequired = false,
    String? hint,
    String? helpText,
    SemanticColor helpTextColor = SemanticColor.neutral,
    bool isFilled = true,
    bool showChips = false,
    double? width,
    void Function(T?)? onSaved,
    String? Function(T?)? validator,
    IconData? prefixIcon,
    bool isDisabled = false,
    DropdownFieldType type = DropdownFieldType.normal,
    Color? fillColor,
    BorderRadius? borderRadius,
    bool closeOnSelect = true,
    bool clearSearchOnSelect = true,
    String? emptyResultsText,
    Widget? emptyResultsWidget,
  }) {
    return AppAsyncDropdownField<T>(
      key: key,
      onSearch: onSearch,
      debounceDuration: debounceDuration,
      minQueryLength: minQueryLength,
      searchHint: searchHint,
      initialItems: initialItems,
      initialItemsHeader: initialItemsHeader,
      initialValue: initialValue != null ? [initialValue] : null,
      onChanged: onChanged,
      isMultiSelect: false,
      showChips: showChips,
      label: label,
      sublabel: sublabel,
      isRequired: isRequired,
      hint: hint,
      helpText: helpText,
      helpTextColor: helpTextColor,
      isFilled: isFilled,
      width: width,
      onSaved: onSaved != null ? (value) => onSaved(value?.firstOrNull) : null,
      validator: validator != null
          ? (value) => validator(value?.firstOrNull)
          : null,
      prefixIcon: prefixIcon,
      isDisabled: isDisabled,
      type: type,
      fillColor: fillColor,
      borderRadius: borderRadius,
      closeOnSelect: closeOnSelect,
      clearSearchOnSelect: clearSearchOnSelect,
      emptyResultsText: emptyResultsText,
      emptyResultsWidget: emptyResultsWidget,
    );
  }

  /// Creates a multi-select async dropdown field.
  factory AppAsyncDropdownField.multi({
    Key? key,
    required Future<ApiResponse<List<AppDropdownItem<T>>>> Function(
      String query,
    )
    onSearch,
    Duration debounceDuration = const Duration(milliseconds: 500),
    int minQueryLength = 0,
    String? searchHint,
    List<AppDropdownItem<T>>? initialItems,
    String? initialItemsHeader,
    List<T>? initialValue,
    void Function(List<T>?)? onChanged,
    String? label,
    String? sublabel,
    bool isRequired = false,
    String? hint,
    String? helpText,
    SemanticColor helpTextColor = SemanticColor.neutral,
    bool isFilled = true,
    bool showChips = true,
    double? width,
    void Function(List<T>?)? onSaved,
    String? Function(List<T>?)? validator,
    IconData? prefixIcon,
    bool isDisabled = false,
    DropdownFieldType type = DropdownFieldType.normal,
    Color? fillColor,
    BorderRadius? borderRadius,
    bool clearSearchOnSelect = false,
    String? emptyResultsText,
    Widget? emptyResultsWidget,
  }) {
    return AppAsyncDropdownField<T>(
      key: key,
      onSearch: onSearch,
      debounceDuration: debounceDuration,
      minQueryLength: minQueryLength,
      searchHint: searchHint,
      initialItems: initialItems,
      initialItemsHeader: initialItemsHeader,
      initialValue: initialValue,
      onMultiChanged: onChanged,
      isMultiSelect: true,
      showChips: showChips,
      label: label,
      sublabel: sublabel,
      isRequired: isRequired,
      hint: hint,
      helpText: helpText,
      helpTextColor: helpTextColor,
      isFilled: isFilled,
      width: width,
      onSaved: onSaved,
      validator: validator,
      prefixIcon: prefixIcon,
      isDisabled: isDisabled,
      type: type,
      fillColor: fillColor,
      borderRadius: borderRadius,
      closeOnSelect: false,
      clearSearchOnSelect: clearSearchOnSelect,
      emptyResultsText: emptyResultsText,
      emptyResultsWidget: emptyResultsWidget,
    );
  }

  @override
  State<AppAsyncDropdownField<T>> createState() =>
      _AppAsyncDropdownFieldState<T>();
}

class _AppAsyncDropdownFieldState<T> extends State<AppAsyncDropdownField<T>> {
  // Overlay management
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _containerKey = GlobalKey();
  bool _isExpanded = false;

  // Interaction states
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isActive = false;

  // Search state
  AsyncDropdownState _searchState = AsyncDropdownState.initial;
  Timer? _debounceTimer;
  List<AppDropdownItem<T>> _searchResults = [];
  String? _errorMessage;
  String _currentQuery = '';

  // Text controller for search input
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Track items for display (combines initial items with search results)
  List<AppDropdownItem<T>> get _displayItems {
    if (_searchState == AsyncDropdownState.success) {
      return _searchResults;
    }
    return [];
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _currentQuery = query;

    // Cancel any existing debounce timer
    _debounceTimer?.cancel();

    // Handle empty or short queries
    if (query.isEmpty || query.length < widget.minQueryLength) {
      setState(() {
        _searchState = AsyncDropdownState.initial;
        _searchResults = [];
      });
      return;
    }

    // Show typing indicator
    setState(() {
      _searchState = AsyncDropdownState.typing;
    });

    // Start debounce timer
    _debounceTimer = Timer(widget.debounceDuration, () async {
      if (_currentQuery != query) return; // Query changed, skip this search

      setState(() {
        _searchState = AsyncDropdownState.loading;
      });

      try {
        final response = await widget.onSearch(query);

        // Check if query is still relevant
        if (_currentQuery != query) return;

        response.fold(
          (error, {failure}) {
            setState(() {
              _searchState = AsyncDropdownState.error;
              _errorMessage = error;
            });
          },
          (results) {
            setState(() {
              _searchResults = results;
              _searchState = results.isEmpty
                  ? AsyncDropdownState.empty
                  : AsyncDropdownState.success;
            });
          },
        );
      } catch (e) {
        if (_currentQuery != query) return;

        setState(() {
          _searchState = AsyncDropdownState.error;
          _errorMessage = e.toString();
        });
      }
    });
  }

  void _handleSelectionChange(
    List<T>? newValue,
    FormFieldState<List<T>> state,
  ) {
    if (widget.isMultiSelect) {
      widget.onMultiChanged?.call(newValue);
      state.didChange(newValue);
    } else {
      widget.onChanged?.call(newValue?.lastOrNull);
      if (newValue?.isNotEmpty ?? false) {
        state.didChange([newValue!.last]);
      } else {
        state.didChange(null);
      }
    }

    // Clear search if configured
    if (widget.clearSearchOnSelect) {
      _searchController.clear();
      _currentQuery = '';
      setState(() {
        _searchState = AsyncDropdownState.initial;
        _searchResults = [];
      });
    }

    // Close overlay if configured (and single-select)
    if (widget.closeOnSelect && !widget.isMultiSelect) {
      _closeOverlay();
    }
  }

  void _closeOverlay() {
    _overlayController.hide();
    setState(() {
      _isExpanded = false;
      _isActive = false;
    });
  }

  void _toggleOverlay() {
    _overlayController.toggle();
    setState(() {
      _isExpanded = !_isExpanded;
      _isActive = _overlayController.isShowing;
    });

    // Focus search field when overlay opens
    if (_overlayController.isShowing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchFocusNode.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      initialValue: widget.initialValue,
      onSaved: (value) => widget.onSaved?.call(value),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              AppInputLabel(
                label: widget.label!,
                sublabel: widget.sublabel,
                isRequired: widget.isRequired,
              ),
              const SizedBox(height: 8),
            ],
            OverlayPortal(
              key: _containerKey,
              controller: _overlayController,
              overlayChildBuilder: (context) {
                final RenderBox renderBox =
                    _containerKey.currentContext!.findRenderObject()
                        as RenderBox;
                final size = renderBox.size;
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _closeOverlay,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(0, size.height + 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AsyncDropdownOverlay<T>(
                        width: size.width,
                        searchState: _searchState,
                        items: _displayItems,
                        initialItems: widget.initialItems,
                        initialItemsHeader: widget.initialItemsHeader,
                        selectedValues: state.value,
                        isMultiSelect: widget.isMultiSelect,
                        onChanged: (value) =>
                            _handleSelectionChange(value, state),
                        searchController: _searchController,
                        searchFocusNode: _searchFocusNode,
                        onSearchChanged: _onSearchChanged,
                        searchHint: widget.searchHint,
                        emptyResultsText: widget.emptyResultsText,
                        emptyResultsWidget: widget.emptyResultsWidget,
                        errorMessage: _errorMessage,
                      ),
                    ),
                  ),
                );
              },
              child: InkWell(
                onHover: (value) => setState(() => _isHovered = value),
                onTap: widget.isDisabled ? null : _toggleOverlay,
                splashFactory: NoSplash.splashFactory,
                onHighlightChanged: (value) =>
                    setState(() => _isPressed = value),
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: AnimatedContainer(
                    width: widget.width,
                    duration: kThemeAnimationDuration,
                    padding: _padding,
                    decoration: BoxDecoration(
                      color: _getBackgroundColor(context, state.hasError),
                      border:
                          widget.type == DropdownFieldType.compact ||
                              widget.type == DropdownFieldType.normal
                          ? _hasBorder(state.hasError)
                                ? Border.all(
                                    color: _getBorderColor(
                                      context,
                                      state.hasError,
                                    ),
                                    width: 1.5,
                                  )
                                : Border.all(
                                    color:
                                        _getBackgroundColor(context, false) ??
                                        context.colors.transparent,
                                    width: 1.5,
                                  )
                          : null,
                      boxShadow: _getShadow(context),
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.prefixIcon != null) ...[
                          Icon(
                            widget.prefixIcon,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(child: _buildSelectedDisplay(context, state)),
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          duration: kThemeAnimationDuration,
                          turns: _isExpanded ? 0.5 : 0,
                          child: Icon(
                            BetterIcons.arrowDown01Outline,
                            size: 16,
                            color: widget.isDisabled
                                ? context.colors.onSurfaceDisabled
                                : _isActive
                                ? context.colors.onSurface
                                : context.colors.onSurfaceVariantLow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state.errorText != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: context.colors.error, fontSize: 12),
                ),
              ),
            ],
            if (widget.helpText != null) ...[
              const SizedBox(height: 8),
              AppInputHint(text: widget.helpText!, color: widget.helpTextColor),
            ],
            if (widget.showChips && (state.value?.isNotEmpty ?? false)) ...[
              const SizedBox(height: 16),
              Text(
                context.strings.selectedItems,
                style: context.textTheme.bodyMedium?.variant(context),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _buildSelectedChips(state),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSelectedDisplay(
    BuildContext context,
    FormFieldState<List<T>> state,
  ) {
    if (state.value == null || state.value!.isEmpty) {
      return Text(
        widget.hint ?? context.strings.select,
        style: context.textTheme.labelMedium?.copyWith(
          color: _getForegroundColor(context),
        ),
      );
    }

    // For async dropdown, we may not have the full item info
    // Try to find from initial items or search results
    final selectedItems = _findSelectedItems(state.value!);

    if (selectedItems.isEmpty) {
      // Fallback: just show count for multi-select or hint for single
      if (widget.isMultiSelect) {
        return Text(
          '${state.value!.length} ${context.strings.selectedItems.toLowerCase()}',
          style: context.textTheme.labelMedium,
        );
      }
      return Text(
        widget.hint ?? context.strings.select,
        style: context.textTheme.labelMedium?.copyWith(
          color: _getForegroundColor(context),
        ),
      );
    }

    return Row(
      children: [
        if (selectedItems.first.prefixIcon != null) ...[
          Icon(
            selectedItems.first.prefixIcon,
            size: 16,
            color: context.colors.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            selectedItems.map((e) => e.title).join(', '),
            style: context.textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  List<AppDropdownItem<T>> _findSelectedItems(List<T> values) {
    final allItems = [...?widget.initialItems, ..._searchResults];
    return allItems.where((item) => values.contains(item.value)).toList();
  }

  List<Widget> _buildSelectedChips(FormFieldState<List<T>> state) {
    final selectedItems = _findSelectedItems(state.value ?? []);
    return state.value?.map((value) {
          final item = selectedItems.firstWhere(
            (i) => i.value == value,
            orElse: () =>
                AppDropdownItem(title: value.toString(), value: value),
          );
          return AppTag(
            text: item.title,
            color: SemanticColor.neutral,
            style: TagStyle.soft,
            isRounded: false,
            onRemovedPressed: () {
              if (widget.isMultiSelect) {
                state.didChange(state.value?.where((e) => e != value).toList());
                widget.onMultiChanged?.call(
                  state.value?.where((e) => e != value).toList(),
                );
              } else {
                state.didChange(null);
                widget.onChanged?.call(null);
              }
            },
          );
        }).toList() ??
        [];
  }

  EdgeInsets get _padding => switch (widget.type) {
    DropdownFieldType.compact => const EdgeInsets.all(8),
    DropdownFieldType.normal => const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 14,
    ),
    DropdownFieldType.inLine => EdgeInsets.zero,
  };

  Color? _getBackgroundColor(BuildContext context, bool error) {
    if (widget.fillColor != null) {
      return widget.fillColor;
    }
    if (widget.type == DropdownFieldType.inLine) {
      return null;
    }
    return switch (widget.isFilled) {
      false => context.colors.surface,
      true =>
        widget.isDisabled
            ? context.colors.surfaceMuted
            : context.colors.surfaceVariant,
    };
  }

  Color _getForegroundColor(BuildContext context) => switch (widget.type) {
    DropdownFieldType.compact =>
      widget.isDisabled
          ? context.colors.onSurfaceDisabled
          : context.colors.onSurfaceVariant,
    DropdownFieldType.inLine =>
      widget.isDisabled
          ? context.colors.onSurfaceDisabled
          : (_isHovered || _isActive)
          ? context.colors.onSurface
          : context.colors.onSurfaceVariant,
    DropdownFieldType.normal =>
      widget.isDisabled
          ? context.colors.onSurfaceDisabled
          : context.colors.onSurfaceVariantLow,
  };

  bool _hasBorder(bool hasError) => switch (widget.type) {
    DropdownFieldType.normal ||
    DropdownFieldType.compact => switch (widget.isFilled) {
      false => true,
      true => hasError || _isHovered || _isPressed || _isActive,
    },
    DropdownFieldType.inLine => false,
  };

  Color _getBorderColor(BuildContext context, bool error) {
    if (widget.isDisabled) {
      return context.colors.outlineDisabled;
    }
    if (error) {
      return context.colors.error;
    }
    if (_isPressed || _isActive) {
      return widget.type == DropdownFieldType.normal
          ? context.colors.primary
          : context.colors.onSurface;
    }
    if (_isHovered) {
      return context.colors.outlineVariant;
    }
    return context.colors.outline;
  }

  List<BoxShadow>? _getShadow(BuildContext context) {
    if (widget.type == DropdownFieldType.normal && (_isHovered || _isActive)) {
      return [
        BoxShadow(
          color: context.colors.shadow,
          blurRadius: 4,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];
    }
    return null;
  }
}
