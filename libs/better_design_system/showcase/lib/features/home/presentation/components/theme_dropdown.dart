import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/colors/color_palette.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

Widget _buildThemeColorPreview(
  BuildContext context,
  BetterThemes theme, {
  double size = 20,
}) {
  final themeData = theme.themeData(context.isDesktop, context.isDark);
  final colors = [
    themeData.colorScheme.primary,
    themeData.colorScheme.secondary,
    themeData.colorScheme.tertiary,
  ];
  return Container(
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      shadows: const [
        BoxShadow(
          color: ColorPalette.neutral16Percent,
          blurRadius: 4,
          offset: Offset(0, 2),
          spreadRadius: 0,
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          colors
              .map(
                (color) => Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(color: color),
                ),
              )
              .toList(),
    ),
  );
}

class AppThemeDropdown extends StatefulWidget {
  final BetterThemes? initialValue;
  final void Function(BetterThemes?)? onChanged;
  final String? label;
  final String? sublabel;
  final bool isRequired;
  final String? helpText;
  final String? hint;
  final double? width;
  final bool isDisabled;

  const AppThemeDropdown({
    super.key,
    this.initialValue,
    this.onChanged,
    this.label,
    this.sublabel,
    this.isRequired = false,
    this.helpText,
    this.hint,
    this.width,
    this.isDisabled = false,
  });

  @override
  State<AppThemeDropdown> createState() => _AppThemeDropdownState();
}

class _AppThemeDropdownState extends State<AppThemeDropdown> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _targetKey = GlobalKey();

  late BetterThemes _selectedTheme;
  bool _isExpanded = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.initialValue ?? BetterThemes.cobalt;
  }

  @override
  void didUpdateWidget(covariant AppThemeDropdown oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        _selectedTheme = widget.initialValue ?? BetterThemes.cobalt;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox? renderBox =
        _targetKey.currentContext?.findRenderObject() as RenderBox?;
    final targetWidth = renderBox?.size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        OverlayPortal(
          controller: _controller,
          overlayChildBuilder: (context) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _controller.hide();
                setState(() {
                  _isExpanded = false;
                });
              },
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                targetAnchor:
                    context.isMobile
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                followerAnchor:
                    context.isMobile ? Alignment.topLeft : Alignment.topRight,
                offset: Offset(0, 8),
                child: Align(
                  alignment:
                      context.isMobile ? Alignment.topLeft : Alignment.topRight,
                  child: Container(
                    width: context.isMobile ? targetWidth : 245,
                    height: 223,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: context.colors.outline,
                      ),
                      boxShadow: [
                        BetterShadow.shadowDropdown.toBoxShadow(context),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: supportedThemes.length,
                      itemBuilder: (context, index) {
                        final theme = supportedThemes[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedTheme = theme;
                              _isExpanded = false;
                            });
                            _controller.hide();
                            widget.onChanged?.call(theme);
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                AppRadio(
                                  value: theme,
                                  groupValue: _selectedTheme,
                                  onTap: (context) {
                                    setState(() {
                                      _selectedTheme = context;
                                      _isExpanded = false;
                                    });
                                    _controller.hide();
                                    widget.onChanged?.call(context);
                                  },
                                ),
                                const SizedBox(width: 8),
                                _buildThemeColorPreview(context, theme),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    theme.name,
                                    style: context.textTheme.labelLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
          child: CompositedTransformTarget(
            key: _targetKey,
            link: _layerLink,
            child: InkWell(
              onTap:
                  widget.isDisabled
                      ? null
                      : () {
                        _controller.toggle();
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
              onHover: (value) {
                setState(() {
                  _isHovered = value;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.width ?? double.infinity,
                padding:
                    context.isDesktop
                        ? EdgeInsets.only(
                          left: 10,
                          right: 4,
                          top: 10,
                          bottom: 10,
                        )
                        : EdgeInsets.all(8),

                decoration: BoxDecoration(
                  color: context.colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color:
                        _isExpanded
                            ? context.colors.primary
                            : _isHovered
                            ? context.colors.outlineVariant
                            : Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [
                    _buildThemeColorPreview(context, _selectedTheme, size: 20),
                    if (context.isMobile) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedTheme.name,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.onSurface,
                          ),
                        ),
                      ),
                    ],
                    if (!context.isMobile) const Spacer(),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: _isExpanded ? 0.5 : 0,
                      child: Icon(
                        BetterIcons.arrowDown01Outline,
                        size: 20,
                        color:
                            _isExpanded
                                ? context.colors.onSurface
                                : context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
