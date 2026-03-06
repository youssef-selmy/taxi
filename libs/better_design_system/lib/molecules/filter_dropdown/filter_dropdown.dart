import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

import 'active_filters_view.dart';
import 'dropdown_overlay.dart';
import 'filter_item.dart';

export 'filter_item.dart';
export 'active_filters_view.dart';

typedef BetterFilterDropdown = AppFilterDropdown;

class AppFilterDropdown<T> extends StatefulWidget {
  final String title;
  final List<FilterItem<T>> items;
  final List<T>? selectedValues;
  final void Function(List<T>)? onChanged;

  const AppFilterDropdown({
    super.key,
    required this.title,
    required this.items,
    this.selectedValues,
    this.onChanged,
  });

  @override
  createState() => _AppFilterDropdownState<T>();
}

class _AppFilterDropdownState<T> extends State<AppFilterDropdown<T>> {
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();
  final LayerLink _layerLink = LayerLink();

  late List<T> _selectedValues;

  @override
  void initState() {
    _selectedValues = widget.selectedValues ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayPortalController,
      overlayChildBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _overlayPortalController.hide();
          },
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(0, 8),
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            child: Align(
              alignment: Alignment.topCenter,
              child: DropDownOverlay(
                items: widget.items,
                selectedItems: _selectedValues,
                onChanged: (selectedItems) {
                  setState(() {
                    _selectedValues = selectedItems;
                    widget.onChanged?.call(_selectedValues);
                  });
                },
              ),
            ),
          ),
        );
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: context.colors.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  _overlayPortalController.toggle();
                },
                minimumSize: const Size(0, 0),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: context.textTheme.bodyMedium?.variant(context),
                    ),
                    const SizedBox(width: 8),
                    ActiveFiltersView(
                      items: widget.items
                          .where((item) => _selectedValues.contains(item.value))
                          .toList(),
                    ),
                    const SizedBox(width: 4),
                    const Icon(BetterIcons.arrowDown01Outline, size: 16),
                  ],
                ),
              ),
              if (_selectedValues.isNotEmpty) ...[
                const SizedBox(width: 8),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _selectedValues = [];
                      widget.onChanged?.call(_selectedValues);
                    });
                  },
                  minimumSize: const Size(0, 0),
                  child: Icon(
                    BetterIcons.cancel01Outline,
                    size: 16,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
