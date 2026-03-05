import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:collection/collection.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/overlay.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class AppDropdownStatus<T> extends StatefulWidget {
  final List<DropDownStatusItem<T>> items;
  final T? initialValue;
  final void Function(T?)? onChanged;

  const AppDropdownStatus({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<AppDropdownStatus<T>> createState() => _DropdownStatusState<T>();
}

class _DropdownStatusState<T> extends State<AppDropdownStatus<T>> {
  final OverlayPortalController controller = OverlayPortalController();
  final LayerLink layerLink = LayerLink();
  bool isExpanded = false;
  final GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: widget.initialValue,
      builder: (state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OverlayPortal(
              key: _containerKey,
              controller: controller,
              overlayChildBuilder: (context) {
                // get the _containerKey position
                final RenderBox renderBox =
                    _containerKey.currentContext!.findRenderObject()
                        as RenderBox;
                // get the _containerKey size
                final size = renderBox.size;
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    controller.hide();
                    setState(() {
                      isExpanded = false;
                    });
                  },
                  child: CompositedTransformFollower(
                    link: layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(0, size.height + 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppDropDownStatusOverlay(
                        items: widget.items,
                        selectedValue: state.value,
                        onChanged: (value) {
                          widget.onChanged?.call(value);
                          setState(() {
                            isExpanded = false;
                          });
                          state.didChange(value);
                          controller.hide();
                        },
                      ),
                    ),
                  ),
                );
              },
              child: GestureDetector(
                onTap: () {
                  controller.toggle();
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: CompositedTransformTarget(
                  link: layerLink,
                  child: AnimatedContainer(
                    duration: kThemeAnimationDuration,
                    child: AppTag(
                      text: _selectedItem(state)?.text ?? context.tr.select,
                      color:
                          _selectedItem(state)?.chipType ??
                          SemanticColor.neutral,
                      prefixIcon: _selectedItem(state)?.icon,
                      suffixWidget: Icon(
                        isExpanded
                            ? BetterIcons.arrowUp01Outline
                            : BetterIcons.arrowDown01Outline,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (state.errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                state.errorText!,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  DropDownStatusItem<T>? _selectedItem(FormFieldState<T> state) {
    return widget.items.firstWhereOrNull(
      (element) => element.value == state.value,
    );
  }
}
