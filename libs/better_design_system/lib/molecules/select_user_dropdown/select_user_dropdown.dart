import 'package:better_design_system/molecules/select_user_dropdown/select_user_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';

import '../filter_dropdown/dropdown_overlay_operator.dart';
import 'operator_active_filter_view.dart';
export '../filter_dropdown/filter_item.dart';
export '../filter_dropdown/active_filters_view.dart';

typedef BetterSelectUserDropdown = AppSelectUserDropdown;

class AppSelectUserDropdown<T> extends StatefulWidget {
  final List<SelectUserItem<T>> items;
  final List<T>? selectedValues;
  final void Function(List<T>)? onChanged;

  const AppSelectUserDropdown({
    super.key,
    required this.items,
    this.selectedValues,
    this.onChanged,
  });

  @override
  createState() => _AppSelectUserDropdownState<T>();
}

class _AppSelectUserDropdownState<T> extends State<AppSelectUserDropdown<T>> {
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
        return CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(0, 8),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          child: Align(
            alignment: Alignment.topCenter,
            child: OperatorDropDownOverlay(
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
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  _overlayPortalController.toggle();
                },
                minimumSize: const Size(0, 0),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    SelectUsersDropdownSelectedUsersView(
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
                    BetterIcons.cancelCircleOutline,
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
