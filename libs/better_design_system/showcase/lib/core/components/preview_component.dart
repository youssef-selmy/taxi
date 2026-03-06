import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/core/components/app_code_block.dart';
import 'package:better_design_showcase/core/components/feature_title.dart';
import 'package:better_design_showcase/core/dialogs/component_full_screen_dialog.dart';
import 'package:better_design_showcase/core/enums/device_view_port.dart';
import 'package:better_design_showcase/core/enums/full_screen_type.dart';
import 'package:better_design_showcase/core/utils/load_source_code.dart';
import 'package:better_design_showcase/features/home/presentation/components/theme_toggle.dart';
import 'package:better_design_system/atoms/buttons/soft_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/colors/color_palette.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export '../enums/full_screen_type.dart';

/// Defines how the preview component should handle fullscreen mode.
///
/// - [none]: /// No fullscreen view is displayed.
/// - [showFullScreen]: /// Displays the desktop or mobile widget as fullscreen.
/// - [customFullScreen]: /// Uses a custom fullscreen behavior through [onCustomFullScreen].
enum FullScreenMode { none, showFullScreen, customFullScreen }

class AppPreviewComponent extends StatefulWidget {
  final Widget? desktopWidget;
  final Widget? mobileWidget;
  final bool isMobileUnsupported;
  final double? maxHeight;
  final double maxWidth;
  final String title;
  final ThemeMode? initialTheme;
  final ValueChanged<ThemeMode>? onThemeChanged;
  final void Function()? onCustomFullScreen;
  final FullScreenMode fullScreenMode;
  final String? desktopSourceCode;
  final String? mobileSourceCode;
  final bool isBordered;
  final BorderRadiusGeometry? borderRadius;
  final FullScreenType fullScreenType;
  const AppPreviewComponent({
    super.key,
    this.desktopWidget,
    this.mobileWidget,
    required this.title,
    required this.desktopSourceCode,
    this.onCustomFullScreen,
    this.initialTheme,
    this.onThemeChanged,
    this.fullScreenMode = FullScreenMode.showFullScreen,
    this.isBordered = true,
    this.isMobileUnsupported = false,
    this.maxHeight,
    this.maxWidth = 1440,
    this.borderRadius,
    this.mobileSourceCode,
    this.fullScreenType = FullScreenType.block,
  }) : assert(
         desktopWidget != null || mobileWidget != null,
         '❌ Either desktopWidget or mobileWidget must be provided. Both cannot be null.',
       ),
       assert(
         desktopSourceCode != null || mobileSourceCode != null,
         '❌ Either desktopSourceCode or mobileSourceCode must be provided. Both cannot be null.',
       );

  @override
  State<AppPreviewComponent> createState() => _AppPreviewComponentState();
}

class _AppPreviewComponentState extends State<AppPreviewComponent> {
  DeviceViewport? selectedDeviceViewport;
  late ThemeMode _themeMode;
  String? desktopCode;
  String? mobileCode;
  bool showCode = false;

  @override
  void initState() {
    _themeMode =
        widget.initialTheme ?? context.read<SettingsCubit>().state.themeMode;

    if (widget.desktopSourceCode != null) {
      loadSourceCode(widget.desktopSourceCode!).then((value) {
        setState(() => desktopCode = value);
      });
    }

    if (widget.mobileSourceCode != null) {
      loadSourceCode(widget.mobileSourceCode!).then((value) {
        setState(() => mobileCode = value);
      });
    }

    super.initState();
  }

  @override
  void didUpdateWidget(AppPreviewComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTheme != null &&
        widget.initialTheme != oldWidget.initialTheme) {
      setState(() {
        _themeMode = widget.initialTheme!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: _themeMode,
          theme: BetterTheme.fromBetterTheme(
            state.theme,
            context.isDesktop,
            false,
          ),
          darkTheme: BetterTheme.fromBetterTheme(
            state.theme,
            context.isDesktop,
            true,
          ),
          home: Builder(
            builder: (context) {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: widget.maxWidth),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1440),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.title,
                                  style: context.textTheme.titleSmall,
                                ),
                                const Spacer(),
                                AppThemeToggle(
                                  selectedThemeMode: _themeMode,
                                  onChanged: (value) {
                                    setState(() {
                                      _themeMode = value;
                                    });
                                    widget.onThemeChanged?.call(value);
                                  },
                                ),
                                const SizedBox(width: 8),

                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 250),
                                  child:
                                      (widget.fullScreenMode !=
                                                  FullScreenMode.none &&
                                              !(!context.isDesktop &&
                                                  widget.isMobileUnsupported) &&
                                              !(context.isMobile &&
                                                  selectedDeviceViewport ==
                                                      DeviceViewport.desktop))
                                          ? Row(
                                            children: [
                                              AppSoftButton(
                                                onPressed:
                                                    widget.fullScreenMode ==
                                                            FullScreenMode
                                                                .customFullScreen
                                                        ? widget
                                                            .onCustomFullScreen
                                                        : () {
                                                          if (widget
                                                                  .fullScreenType ==
                                                              FullScreenType
                                                                  .block) {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => AppComponentFullScreenDialog(
                                                                    title:
                                                                        widget
                                                                            .title,
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color:
                                                                            context.colors.surface,
                                                                        borderRadius:
                                                                            widget.borderRadius ??
                                                                            BorderRadius.circular(
                                                                              12,
                                                                            ),
                                                                        border: Border.all(
                                                                          color:
                                                                              context.colors.outline,
                                                                        ),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                context.colors.shadow,
                                                                            blurRadius:
                                                                                8,
                                                                            offset: Offset(
                                                                              0,
                                                                              4,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          widget
                                                                              .desktopWidget ??
                                                                          widget
                                                                              .mobileWidget!,
                                                                    ),
                                                                  ),
                                                            );
                                                          } else {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => AppComponentFullScreenDialog(
                                                                    title:
                                                                        widget
                                                                            .title,
                                                                    fullScreenType:
                                                                        FullScreenType
                                                                            .dashboard,
                                                                    child: Container(
                                                                      decoration: ShapeDecoration(
                                                                        color:
                                                                            context.colors.surface,
                                                                        shape: RoundedRectangleBorder(
                                                                          side: BorderSide(
                                                                            color:
                                                                                context.colors.outline,
                                                                          ),
                                                                        ),
                                                                        shadows: [
                                                                          BetterShadow.shadow8.toBoxShadow(
                                                                            context,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Column(
                                                                        children: <
                                                                          Widget
                                                                        >[
                                                                          FeatureTitle(
                                                                            title:
                                                                                'Title',
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                selectedDeviceViewport ==
                                                                                        null
                                                                                    ? context.isDesktop
                                                                                        ? widget.desktopWidget!
                                                                                        : widget.mobileWidget!
                                                                                    : selectedDeviceViewport ==
                                                                                        DeviceViewport.desktop
                                                                                    ? widget.desktopWidget!
                                                                                    : widget.mobileWidget!,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                            );
                                                          }
                                                        },
                                                prefixIcon:
                                                    BetterIcons
                                                        .fullScreenFilled,
                                                color: SemanticColor.neutral,
                                                size: ButtonSize.small,
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          )
                                          : const SizedBox.shrink(),
                                ),

                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 250),
                                  child:
                                      (widget.desktopWidget != null &&
                                              widget.mobileWidget != null)
                                          ? Row(
                                            children: [
                                              AppToggleSwitchButtonGroup<
                                                DeviceViewport
                                              >(
                                                options: [
                                                  ToggleSwitchButtonGroupOption(
                                                    value:
                                                        DeviceViewport.mobile,
                                                    icon:
                                                        BetterIcons
                                                            .smartPhone01Outline,
                                                    selectedIcon:
                                                        BetterIcons
                                                            .smartPhone01Outline,
                                                  ),
                                                  ToggleSwitchButtonGroupOption(
                                                    value:
                                                        DeviceViewport.desktop,
                                                    icon:
                                                        BetterIcons
                                                            .computerOutline,
                                                    selectedIcon:
                                                        BetterIcons
                                                            .computerOutline,
                                                  ),
                                                ],
                                                size:
                                                    ToggleSwitchButtonGroupSize
                                                        .small,
                                                selectedValue:
                                                    selectedDeviceViewport ??
                                                    (context.isDesktop
                                                        ? DeviceViewport.desktop
                                                        : DeviceViewport
                                                            .mobile),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedDeviceViewport =
                                                        value;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          )
                                          : const SizedBox.shrink(),
                                ),

                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 250),
                                  child:
                                      (!(!context.isDesktop &&
                                                  widget.isMobileUnsupported) &&
                                              !(context.isMobile &&
                                                  selectedDeviceViewport ==
                                                      DeviceViewport.desktop))
                                          ? AppSoftButton(
                                            onPressed: () {
                                              setState(() {
                                                showCode = !showCode;
                                              });
                                            },
                                            prefixIcon:
                                                BetterIcons.squareLock02Outline,
                                            text: 'Code',
                                            color: SemanticColor.neutral,
                                            size: ButtonSize.small,
                                          )
                                          : const SizedBox.shrink(),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: widget.maxHeight ?? double.infinity,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 40,
                                horizontal: 16,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: context.colors.surfaceVariantLow,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: context.colors.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: ColorPalette.neutral16Percent,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  transitionBuilder: (child, animation) {
                                    final offsetAnimation = Tween<Offset>(
                                      begin: const Offset(0.0, 0.1),
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeInOut,
                                      ),
                                    );
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child:
                                      showCode
                                          ? AppCodeBlock(
                                            code:
                                                (selectedDeviceViewport == null)
                                                    ? (context.isDesktop)
                                                        ? desktopCode ?? ''
                                                        : mobileCode ?? ''
                                                    : selectedDeviceViewport ==
                                                        DeviceViewport.desktop
                                                    ? desktopCode ?? ''
                                                    : mobileCode ?? '',
                                            language: 'dart',
                                            isDarkMode:
                                                _themeMode == ThemeMode.dark,
                                            showHeader: true,
                                            maxHeight: widget.maxHeight ?? 500,
                                            expanded: true,
                                          )
                                          : Container(
                                            decoration: BoxDecoration(
                                              color: context.colors.surface,
                                              borderRadius:
                                                  widget.borderRadius ??
                                                  BorderRadius.circular(12),
                                              border:
                                                  widget.isBordered
                                                      ? Border.all(
                                                        color:
                                                            context
                                                                .colors
                                                                .outline,
                                                      )
                                                      : null,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: context.colors.shadow,
                                                  blurRadius: 8,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child:
                                                (!context.isDesktop &&
                                                        widget
                                                            .isMobileUnsupported)
                                                    ? _getMobileUnsupported(
                                                      context,
                                                    )
                                                    : (widget.desktopWidget !=
                                                            null &&
                                                        widget.mobileWidget !=
                                                            null)
                                                    ? ((selectedDeviceViewport ??
                                                                (context.isDesktop
                                                                    ? DeviceViewport
                                                                        .desktop
                                                                    : DeviceViewport
                                                                        .mobile)) ==
                                                            DeviceViewport
                                                                .desktop
                                                        ? context.isDesktop
                                                            ? widget
                                                                .desktopWidget!
                                                            : _getMobileUnsupported(
                                                              context,
                                                            )
                                                        : widget.mobileWidget!)
                                                    : widget.desktopWidget ??
                                                        widget.mobileWidget ??
                                                        const SizedBox.shrink(),
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _getMobileUnsupported(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        height: 600,
        child: AppEmptyState(
          title: 'not supported',
          image: Assets.images.emptyStates.noRecord,
        ),
      ),
    );
  }
}
