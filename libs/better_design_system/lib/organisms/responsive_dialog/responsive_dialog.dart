import 'dart:ui';

import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'dialog_header.dart';
import 'dialog_footer.dart';
export 'package:better_design_system/colors/semantic_color.dart';
export 'dialog_header.dart';

typedef BetterResponsiveDialog = AppResponsiveDialog;

class AppResponsiveDialog extends StatefulWidget {
  final DialogType defaultDialogType;
  final DialogType desktopDialogType;
  final Widget? child;
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final Widget? tertiaryButton;
  final double? maxWidth;
  final double? maxHeight;
  final EdgeInsets contentPadding;
  final Function()? onClosePressed;
  final SemanticColor? iconColor;
  final DialogHeaderIconStyle iconStyle;
  final DialogHeaderAlignment alignment;
  final DialogHeaderAlignment desktopAlignment;

  const AppResponsiveDialog({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.icon,
    this.primaryButton,
    this.secondaryButton,
    this.onClosePressed,
    this.defaultDialogType = DialogType.bottomSheet,
    this.desktopDialogType = DialogType.dialog,
    this.maxWidth,
    this.maxHeight,
    this.contentPadding = const EdgeInsets.all(16),
    this.iconColor = SemanticColor.primary,
    this.tertiaryButton,
    this.iconStyle = DialogHeaderIconStyle.simple,
    this.alignment = DialogHeaderAlignment.center,
    this.desktopAlignment = DialogHeaderAlignment.start,
  });

  @override
  State<AppResponsiveDialog> createState() => _AppResponsiveDialogState();
}

class _AppResponsiveDialogState extends State<AppResponsiveDialog>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final dialogType = _dialogType(context);
    if (dialogType == DialogType.close) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pop();
      });
    }
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: switch (dialogType) {
        DialogType.fullScreen => Material(
          child: Container(
            color: backgroundColor(context),
            child: buildContent(context),
          ),
        ),
        DialogType.fullScreenBottomSheet => Animate(
          effects: [
            const FadeEffect(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
            ),
            const SlideEffect(
              curve: Curves.easeInOut,
              begin: Offset(0, 1),
              duration: Duration(milliseconds: 300),
            ),
          ],
          child: BottomSheet(
            enableDrag: false,
            showDragHandle: false,
            backgroundColor: backgroundColor(context),
            constraints: BoxConstraints(maxHeight: context.height - 80),
            onClosing: () {},
            builder: (context) => Container(
              height: context.height - 80,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: backgroundColor(context),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.shadow,
                    offset: const Offset(2, 4),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(color: context.colors.outline),
              ),
              child: buildContent(context),
            ),
          ),
        ),
        DialogType.bottomSheet => Animate(
          effects: [
            const FadeEffect(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
            ),
            const SlideEffect(
              curve: Curves.easeInOut,
              begin: Offset(0, 1),
              duration: Duration(milliseconds: 300),
            ),
          ],
          child: BottomSheet(
            enableDrag: true,
            showDragHandle: false,
            animationController: BottomSheet.createAnimationController(this),
            backgroundColor: backgroundColor(context),
            constraints: constraints(context),
            onClosing: () {},
            builder: (context) => Container(
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: backgroundColor(context),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.shadow,
                    offset: const Offset(2, 4),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(color: context.colors.outline),
              ),
              child: buildContent(context),
            ),
          ),
        ),
        DialogType.dialog => Animate(
          effects: [
            const FadeEffect(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
            ),
          ],
          child: Dialog(
            backgroundColor: backgroundColor(context),
            child: Container(
              constraints: constraints(context),
              decoration: BoxDecoration(
                color: backgroundColor(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colors.outline),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.shadow,
                    offset: const Offset(0, 24),
                    blurRadius: 80,
                    spreadRadius: -8,
                  ),
                ],
              ),
              child: buildContent(context),
            ),
          ),
        ),
        DialogType.overlay => Container(
          constraints: constraints(context),
          decoration: BoxDecoration(
            color: backgroundColor(context),
            boxShadow: [
              BoxShadow(
                color: context.colors.shadow,
                offset: const Offset(0, 3),
                blurRadius: 25,
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: buildContent(context),
        ),
        DialogType.rightSheet => Animate(
          effects: [
            const FadeEffect(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
            ),
            const SlideEffect(
              curve: Curves.easeInOut,
              begin: Offset(1, 0),
              duration: Duration(milliseconds: 300),
            ),
          ],
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Material(
                  child: Container(
                    width: 380,
                    decoration: BoxDecoration(
                      color: backgroundColor(context),
                      border: Border(
                        left: BorderSide(color: context.colorScheme.outline),
                      ),
                    ),
                    child: buildContent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        DialogType.close => const SizedBox.shrink(),
      },
    );
  }

  Color backgroundColor(BuildContext context) => context.colors.surface;

  DialogType _dialogType(BuildContext context) =>
      (context.isDesktop ? widget.desktopDialogType : widget.defaultDialogType);

  Widget buildContent(BuildContext context) {
    final dialogType = _dialogType(context);
    return Column(
      mainAxisSize: dialogType == DialogType.fullScreen
          ? MainAxisSize.max
          : MainAxisSize.min,
      children: [
        AppDialogHeader(
          icon: widget.icon,
          title: widget.title,
          subtitle: widget.subtitle,
          iconColor: widget.iconColor,
          iconStyle: widget.iconStyle,
          alignment: context.isDesktop
              ? widget.desktopAlignment
              : widget.alignment,
          onClosePressed: widget.onClosePressed,
        ),
        switch (dialogType) {
          DialogType.fullScreen ||
          DialogType.rightSheet ||
          DialogType.fullScreenBottomSheet => Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: widget.contentPadding,
                    child: widget.child,
                  ),
                ),
                if (widget.primaryButton != null ||
                    widget.secondaryButton != null ||
                    widget.tertiaryButton != null)
                  AppDialogFooter(
                    primaryAction: widget.primaryButton,
                    secondaryAction: widget.secondaryButton,
                    tertiaryAction: widget.tertiaryButton,
                    direction: DialogFooterDirection.vertical,
                  ),
              ],
            ),
          ),
          DialogType.bottomSheet ||
          DialogType.dialog ||
          DialogType.overlay => Column(
            children: [
              if (dialogType == DialogType.dialog) ...[const AppDivider()],
              Padding(padding: widget.contentPadding, child: widget.child),
              if (dialogType == DialogType.dialog &&
                  (widget.primaryButton != null ||
                      widget.secondaryButton != null ||
                      widget.tertiaryButton != null)) ...[
                const AppDivider(),
              ],
              AppDialogFooter(
                primaryAction: widget.primaryButton,
                secondaryAction: widget.secondaryButton,
                tertiaryAction: widget.tertiaryButton,
                direction: dialogType.actionDirection,
              ),
            ],
          ),
          DialogType.close => const SizedBox(),
        },
      ],
    );
  }

  BoxConstraints? constraints(BuildContext context) => BoxConstraints(
    maxWidth:
        widget.maxWidth ??
        (_dialogType(context) == DialogType.dialog ? 500 : double.infinity),
    maxHeight: widget.maxHeight ?? (double.infinity),
  );
}

enum DialogType {
  bottomSheet,
  fullScreenBottomSheet,
  dialog,
  fullScreen,
  rightSheet,
  overlay,
  close;

  DialogFooterDirection get actionDirection => switch (this) {
    DialogType.bottomSheet ||
    DialogType.fullScreenBottomSheet ||
    DialogType.fullScreen ||
    DialogType.rightSheet => DialogFooterDirection.vertical,
    DialogType.dialog ||
    DialogType.overlay ||
    DialogType.close => DialogFooterDirection.horizontal,
  };
}

typedef DialogHeader = (IconData, String, String?);
