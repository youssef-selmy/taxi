import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter/material.dart';

import 'package:better_icons/better_icons.dart';

import 'package:better_design_system/utils/extensions/extensions.dart';

import '../base_components/input_hint.dart';
import '../base_components/input_label.dart';

import 'dopdown_overlay.dart';
import 'dropdown_field_type.dart';
import 'dropdown_item.dart';
export 'dropdown_item.dart';
export 'dropdown_field_type.dart';

typedef BetterDropdownField = AppDropdownField;

class AppDropdownField<T> extends StatefulWidget {
  final List<AppDropdownItem<T>> items;
  final List<T>? initialValue;
  final void Function(T?)? onChanged;
  final void Function(List<T>?)? onMultiChanged;
  final String? label;
  final String? sublabel;
  final bool isRequired;
  final String? hint;
  final String? helpText;
  final SemanticColor helpTextColor;
  final bool isFilled;
  final double? width;
  final Function(List<T>?)? onSaved;
  final String? Function(List<T>?)? validator;
  final bool isMultiSelect;
  final IconData? prefixIcon;
  final bool showChips;
  final bool isDisabled;
  final DropdownFieldType type;
  final Color? fillColor;
  final BorderRadius? borderRadius;

  const AppDropdownField({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.label,
    this.sublabel,
    this.isRequired = false,
    this.hint,
    this.helpText,
    this.helpTextColor = SemanticColor.neutral,
    this.width,
    this.onSaved,
    this.validator,
    this.isMultiSelect = true,
    this.onMultiChanged,
    this.prefixIcon,
    this.isFilled = true,
    this.showChips = false,
    this.isDisabled = false,
    this.type = DropdownFieldType.normal,
    this.fillColor,
    this.borderRadius,
  });

  // single contructor
  factory AppDropdownField.single({
    required List<AppDropdownItem<T>> items,
    T? initialValue,
    void Function(T?)? onChanged,
    String? label,
    String? sublabel,
    bool isRequired = false,
    String? helpText,
    SemanticColor helpTextColor = SemanticColor.neutral,
    String? hint,
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
  }) {
    return AppDropdownField(
      items: items,
      initialValue: initialValue != null ? [initialValue] : null,
      onChanged: onChanged,
      label: label,
      sublabel: sublabel,
      isRequired: isRequired,
      helpText: helpText,
      helpTextColor: helpTextColor,
      width: width,
      hint: hint,

      onSaved: onSaved != null ? (value) => onSaved(value?.firstOrNull) : null,
      validator: validator != null
          ? (value) => validator(value?.firstOrNull)
          : null,
      prefixIcon: prefixIcon,
      isFilled: isFilled,
      isMultiSelect: false,
      showChips: showChips,
      isDisabled: isDisabled,
      type: type,
      fillColor: fillColor,
      borderRadius: borderRadius,
    );
  }

  // multi contructor
  factory AppDropdownField.multi({
    required List<AppDropdownItem<T>> items,
    List<T>? initialValue,
    void Function(List<T>?)? onChanged,
    String? label,
    String? sublabel,
    bool isRequired = false,
    String? helpText,
    SemanticColor helpTextColor = SemanticColor.neutral,
    String? hint,
    bool isFilled = true,
    bool showChips = false,
    double? width,
    void Function(List<T>?)? onSaved,
    String? Function(List<T>?)? validator,
    IconData? prefixIcon,
    bool isDisabled = false,
    DropdownFieldType type = DropdownFieldType.normal,
    Color? fillColor,
    BorderRadius? borderRadius,
  }) {
    return AppDropdownField(
      items: items,
      initialValue: initialValue,
      onMultiChanged: onChanged,
      label: label,
      sublabel: sublabel,
      isRequired: isRequired,
      helpText: helpText,
      helpTextColor: helpTextColor,
      width: width,
      hint: hint,
      onSaved: onSaved,
      validator: validator,
      prefixIcon: prefixIcon,
      isFilled: isFilled,
      isMultiSelect: true,
      showChips: showChips,
      isDisabled: isDisabled,
      type: type,
      fillColor: fillColor,
      borderRadius: borderRadius,
    );
  }

  @override
  State<AppDropdownField<T>> createState() => _AppDropdownFieldState<T>();
}

class _AppDropdownFieldState<T> extends State<AppDropdownField<T>> {
  final OverlayPortalController controller = OverlayPortalController();
  final LayerLink layerLink = LayerLink();
  bool isExpanded = false;
  final GlobalKey _containerKey = GlobalKey();

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: widget.initialValue,
      onSaved: (value) {
        widget.onSaved?.call(value);
      },
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
                      _isActive = controller.isShowing;
                    });
                  },
                  child: CompositedTransformFollower(
                    link: layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(0, size.height + 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: DropDownCompactOverlay(
                        width: size.width,
                        items: widget.items,
                        selectedValue: state.value,
                        isMultiSelect: widget.isMultiSelect,
                        onChanged: (value) {
                          if (widget.isMultiSelect) {
                            widget.onMultiChanged?.call(value);
                          } else {
                            widget.onChanged?.call(value?.lastOrNull);
                          }
                          setState(() {
                            isExpanded = false;
                          });
                          if (widget.isMultiSelect) {
                            state.didChange(value);
                          } else {
                            if (value?.isNotEmpty ?? false) {
                              state.didChange([value!.last]);
                            } else {
                              state.didChange(null);
                            }
                          }
                          controller.hide();
                          setState(() {
                            _isActive = controller.isShowing;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
              child: InkWell(
                onHover: widget.isDisabled
                    ? null
                    : (value) => setState(() => _isHovered = value),
                onTap: widget.isDisabled
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        controller.toggle();
                        setState(() {
                          isExpanded = !isExpanded;
                          _isActive = controller.isShowing;
                        });
                      },
                splashFactory: NoSplash.splashFactory,
                onHighlightChanged: widget.isDisabled
                    ? null
                    : (value) => setState(() => _isPressed = value),
                child: CompositedTransformTarget(
                  link: layerLink,
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
                        if (state.value != null) ...[
                          Expanded(
                            child: Row(
                              children: [
                                if (widget.items
                                        .where(
                                          (element) =>
                                              state.value?.contains(
                                                element.value,
                                              ) ??
                                              false,
                                        )
                                        .firstOrNull
                                        ?.prefixIcon !=
                                    null) ...[
                                  Icon(
                                    widget.items
                                        .where(
                                          (element) =>
                                              state.value?.contains(
                                                element.value,
                                              ) ??
                                              false,
                                        )
                                        .firstOrNull!
                                        .prefixIcon,
                                    size: 16,
                                    color: context.colors.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Expanded(
                                  child: Text(
                                    widget.items
                                        .where(
                                          (element) =>
                                              state.value?.contains(
                                                element.value,
                                              ) ??
                                              false,
                                        )
                                        .map((e) => e.title)
                                        .join(', '),
                                    style: context.textTheme.labelMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (state.value == null) ...[
                          Expanded(
                            child: Text(
                              widget.hint ?? context.strings.select,
                              style: context.textTheme.labelMedium?.copyWith(
                                color: _getForegroundColor(context),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          duration: kThemeAnimationDuration,
                          turns: isExpanded ? 0.5 : 0,
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
            if (widget.showChips) ...[
              const SizedBox(height: 16),
              Text(
                context.strings.selectedItems,
                style: context.textTheme.bodyMedium?.variant(context),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    state.value
                        ?.map(
                          (category) => AppTag(
                            text:
                                widget.items
                                    .where(
                                      (element) => element.value == category,
                                    )
                                    .firstOrNull
                                    ?.title ??
                                '',
                            color: SemanticColor.neutral,
                            style: TagStyle.soft,
                            isRounded: false,
                            onRemovedPressed: () {
                              if (widget.isMultiSelect) {
                                state.didChange(
                                  state.value
                                      ?.where((element) => element != category)
                                      .toList(),
                                );
                              } else {
                                state.didChange(null);
                              }
                            },
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ],
          ],
        );
      },
    );
  }

  bool _isActive = false;

  EdgeInsets get _padding {
    switch (widget.type) {
      case DropdownFieldType.compact:
        return const EdgeInsets.all(8);
      case DropdownFieldType.normal:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 14);
      case DropdownFieldType.inLine:
        return EdgeInsets.zero;
    }
  }

  Color? _getBackgroundColor(BuildContext context, bool error) {
    if (widget.fillColor != null) {
      return widget.fillColor;
    }
    if (widget.type == DropdownFieldType.inLine) {
      return null;
    }
    switch (widget.isFilled) {
      case false:
        return context.colors.surface;

      case true:
        if (widget.isDisabled) {
          return context.colors.surfaceMuted;
        }
        // Always return normal background, error only affects border
        return context.colors.surfaceVariant;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    switch (widget.type) {
      case DropdownFieldType.compact:
        return widget.isDisabled
            ? context.colors.onSurfaceDisabled
            : context.colors.onSurfaceVariant;
      case DropdownFieldType.inLine:
        if (widget.isDisabled) {
          return context.colors.onSurfaceDisabled;
        }
        if (_isHovered || _isActive) {
          return context.colors.onSurface;
        }
        return context.colors.onSurfaceVariant;

      case DropdownFieldType.normal:
        return widget.isDisabled
            ? context.colors.onSurfaceDisabled
            : context.colors.onSurfaceVariantLow;
    }
  }

  bool _hasBorder(bool hasError) {
    switch (widget.type) {
      case DropdownFieldType.normal:
      case DropdownFieldType.compact:
        switch (widget.isFilled) {
          case false:
            return true;
          case true:
            // Show border if error, hovered, pressed, or active
            if (hasError || _isHovered || _isPressed || _isActive) {
              return true;
            } else {
              return false;
            }
        }

      case DropdownFieldType.inLine:
        return false;
    }
  }

  Color _getBorderColor(BuildContext context, bool error) {
    if (widget.isDisabled) {
      return context.colors.outlineDisabled;
    }
    // Check error state FIRST (before interactive states)
    if (error) {
      return context.colors.error;
    }
    if (_isPressed) {
      return widget.type == DropdownFieldType.normal
          ? context.colors.primary
          : context.colors.onSurface;
    }
    if (_isActive) {
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
    if (widget.type == DropdownFieldType.normal) {
      if (_isHovered || _isActive) {
        return [
          BoxShadow(
            color: context.colors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
