import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

import 'sort_overlay.dart';

typedef BetterSortDropdown = AppSortDropdown;

class AppSortDropdown<T> extends StatefulWidget {
  final List<T> items;
  final List<T>? selectedValues;
  final void Function(List<T>)? onChanged;
  final String Function(T) labelGetter;
  final double overlayWidth;

  const AppSortDropdown({
    super.key,
    required this.items,
    this.selectedValues,
    this.onChanged,
    required this.labelGetter,
    this.overlayWidth = 200,
  });

  @override
  createState() => _AppSortDropdownState<T>();
}

class _AppSortDropdownState<T> extends State<AppSortDropdown<T>> {
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();
  final GlobalKey _containerKey = GlobalKey();
  late int dropdownIndex = 0;
  late double width;

  late List<(T?, LayerLink)> _selectedValues;

  @override
  void initState() {
    if (widget.selectedValues?.isEmpty ?? true) {
      _selectedValues = [(null, LayerLink())];
    } else {
      _selectedValues = widget.selectedValues!
          .map((e) => (e, LayerLink()))
          .toList();
    }
    width = _containerKey.currentContext?.size?.width ?? widget.overlayWidth;
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
            link: _selectedValues.elementAtOrNull(dropdownIndex)!.$2,
            offset: const Offset(-8, 12),
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            child: Align(
              alignment: Alignment.topLeft,
              child: SortOverlay<T>(
                width: width,
                labelGetter: widget.labelGetter,
                items: widget.items
                    .where((e) => !_selectedValues.map((e) => e.$1).contains(e))
                    .toList(),
                selectedItem: _selectedValues
                    .elementAtOrNull(dropdownIndex)
                    ?.$1,
                onChanged: (selectedItem) {
                  _overlayPortalController.hide();
                  setState(() {
                    _selectedValues[dropdownIndex] = (
                      selectedItem,
                      _selectedValues.elementAtOrNull(dropdownIndex)!.$2,
                    );
                    widget.onChanged?.call(
                      _selectedValues
                          .where((e) => e.$1 != null)
                          .map((e) => (e.$1!, e.$2))
                          .map((e) => e.$1)
                          .toList(),
                    );
                  });
                },
              ),
            ),
          ),
        );
      },
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _overlayPortalController.hide();
          }
          if (notification is SizeChangedLayoutNotification) {
            setState(() {
              width = _containerKey.currentContext!.size!.width;
            });
          }

          return true;
        },
        child: Container(
          key: _containerKey,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          height: 38,
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: context.colors.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: _selectedValues.length,
                itemBuilder: (context, index) {
                  return CompositedTransformTarget(
                    link: _selectedValues[index].$2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            dropdownIndex = index;
                            _overlayPortalController.toggle();
                          },
                          minimumSize: const Size(0, 0),
                          child: Row(
                            children: [
                              if (index > 0) const SizedBox(width: 8),
                              Text(
                                index == 0 ? 'Sort by' : 'Then by',
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (_selectedValues.elementAtOrNull(index)?.$1 !=
                                  null) ...[
                                AppTag(
                                  text: widget.labelGetter(
                                    _selectedValues.elementAt(index).$1 as T,
                                  ),
                                  color: SemanticColor.primary,
                                ),
                              ],
                              if (_selectedValues.elementAtOrNull(index)?.$1 ==
                                  null) ...[
                                Text(
                                  'Select',
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        color: context.colors.onSurfaceVariant,
                                      ),
                                ),
                              ],
                              const SizedBox(width: 4),
                              const Icon(
                                BetterIcons.arrowDown01Outline,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        if (_selectedValues.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                if (_selectedValues.length > 1) {
                                  _selectedValues.removeAt(index);
                                } else {
                                  _selectedValues = [
                                    (
                                      null,
                                      _selectedValues
                                          .elementAtOrNull(index)!
                                          .$2,
                                    ),
                                  ];
                                }
                                widget.onChanged?.call(
                                  _selectedValues
                                      .where((e) => e.$1 != null)
                                      .map((e) => (e.$1!, e.$2))
                                      .map((e) => e.$1)
                                      .toList(),
                                );
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
                  );
                },
              ),
              if (_selectedValues.length < 5) ...[
                const SizedBox(width: 8),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _selectedValues = [
                        ..._selectedValues,
                        (null as T?, LayerLink()),
                      ];
                    });
                  },
                  minimumSize: const Size(0, 0),
                  child: Icon(
                    BetterIcons.add01Outline,
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
