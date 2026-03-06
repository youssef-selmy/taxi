import 'package:better_design_system/atoms/banner/banner_align.dart';
import 'package:better_design_system/atoms/banner/banner_responsive.dart';
import 'package:better_design_system/atoms/banner/banner_size.dart';

import 'package:better_design_system/atoms/banner/banner_style.dart';
import 'package:better_design_system/atoms/banner/banner_type.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';
export 'banner_style.dart';
export 'banner_type.dart';
export 'banner_align.dart';
export 'banner_responsive.dart';
export 'banner_size.dart';

/// A customizable banner widget that displays a title, subtitle, and optional actions.
///
/// The [AppBanner] supports different styles, colors, and icons.
/// It can also include a close button and an action button.
typedef BetterBanner = AppBanner;

class AppBanner extends StatelessWidget {
  /// The visual style of the banner.
  /// Defaults to [BannerStyle.soft].
  final BannerStyle style;

  /// The main title text of the banner.
  final String title;

  /// The subtitle text of the banner.
  final String? subtitle;

  /// Callback when the close button is pressed.
  final void Function()? onClosed;

  /// The action button configuration for the banner.
  final List<AppBannerAction> actions;

  /// The type of the banner, which determines the icon displayed.
  /// Defaults to [BannerType.info].
  final BannerType type;

  final BannerAlign bannerAlign;

  final BannerResponsive bannerResponsive;

  final BannerSize size;

  /// Creates an [AppBanner].
  ///
  /// The [title], [subtitle] and [action] parameters are required.
  const AppBanner({
    super.key,
    this.style = BannerStyle.soft,
    required this.title,
    this.subtitle,
    this.onClosed,
    this.actions = const [],
    this.type = BannerType.info,
    this.bannerAlign = BannerAlign.center,
    this.bannerResponsive = BannerResponsive.mobile,
    this.size = BannerSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return _getBanner(context);
  }

  Widget _getDesktopBanner(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: _getBackgroundColor(context),
            border: style == BannerStyle.outline
                ? Border.all(color: context.colors.outline, width: 1)
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: bannerAlign == BannerAlign.center
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              /// Left section: Icon, title, and subtitle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Icon(_icon, size: 20, color: _getIconColor(context)),
                    Text(
                      title,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: style == BannerStyle.outline
                            ? context.colors.onSurface
                            : _getIconColor(context),
                      ),
                    ),
                    Text(
                      '-',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: style == BannerStyle.outline
                            ? context.colors.onSurface
                            : _getIconColor(context),
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: style == BannerStyle.outline
                              ? context.colors.onSurfaceVariant
                              : _getIconColor(context),
                        ),
                      ),
                  ],
                ),
              ),

              /// Right section: Action buttons
              Row(
                children: <Widget>[
                  const SizedBox(width: 16),
                  _getActions(context),

                  if (bannerAlign == BannerAlign.right) ...[
                    const SizedBox(width: 16),
                    _getCloseIcon(context),
                  ],
                ],
              ),
            ],
          ),
        ),

        if (bannerAlign == BannerAlign.center)
          /// Close button
          Positioned(
            top: 10,
            right: 32,
            bottom: 10,
            child: _getCloseIcon(context),
          ),
      ],
    );
  }

  Widget _getMobileBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        border: style == BannerStyle.outline
            ? Border.all(color: context.colors.outline, width: 1)
            : null,
      ),
      padding: EdgeInsets.symmetric(
        vertical: size == BannerSize.large ? 24 : 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Left section: Icon, title, and subtitle
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(_icon, size: 20, color: _getIconColor(context)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: context.textTheme.labelLarge?.copyWith(
                              color: style == BannerStyle.outline
                                  ? context.colors.onSurface
                                  : _getIconColor(context),
                            ),
                          ),
                          if (size == BannerSize.large && subtitle != null)
                            Text(
                              subtitle!,
                              style: context.textTheme.labelLarge?.copyWith(
                                color: style == BannerStyle.outline
                                    ? context.colors.onSurfaceVariant
                                    : _getIconColor(context),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                spacing: 16,
                crossAxisAlignment: size == BannerSize.medium
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  if (size == BannerSize.medium) _getActions(context),
                  _getCloseIcon(context),
                ],
              ),
            ],
          ),

          /// Right section: Action buttons
          if (size == BannerSize.large) _getActions(context),
        ],
      ),
    );
  }

  Widget _getActions(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ...actions.map((action) {
          return AppLinkButton(
            onPressed: action.onPressed ?? () {},
            text: action.title,
            color: _getButtonColor(context),
          );
        }),
      ],
    );
  }

  Widget _getCloseIcon(BuildContext context) {
    if (onClosed == null) {
      return const SizedBox();
    }
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onClosed ?? () {},
      minimumSize: const Size(0, 0),
      child: Icon(
        BetterIcons.cancel01Outline,
        size: 20,
        color: style == BannerStyle.outline
            ? context.colors.onSurfaceVariant
            : _getIconColor(context),
      ),
    );
  }

  /// Returns the background color of the banner based on the style.
  Color _getBackgroundColor(BuildContext context) {
    switch (style) {
      case BannerStyle.outline:
        return context.colors.surface;
      case BannerStyle.soft:
        return bannerResponsive == BannerResponsive.mobile
            ? type.color.containerColor(context)
            : bannerResponsive == BannerResponsive.responsive
            ? context.responsive(
                type.color.containerColor(context),
                xl: type.color.variantLow(context),
              )
            : type.color.variantLow(context);
      case BannerStyle.fill:
        return type.color.main(context);
    }
  }

  /// Returns the icon color of the banner based on the style.
  Color _getIconColor(BuildContext context) {
    switch (style) {
      case BannerStyle.outline:
        return type.color.main(context);
      case BannerStyle.soft:
        return type.color.bold(context);
      case BannerStyle.fill:
        return type.color.onColor(context);
    }
  }

  /// Returns the button text color based on the banner style.
  SemanticColor _getButtonColor(BuildContext context) {
    switch (style) {
      case BannerStyle.outline:
        return SemanticColor.neutral;
      case BannerStyle.soft:
        return type.color;
      case BannerStyle.fill:
        return SemanticColor.white;
    }
  }

  // Icon mapping for the banner
  IconData? get _icon => switch (type) {
    BannerType.info => BetterIcons.informationCircleFilled,
    BannerType.success => BetterIcons.checkmarkCircle02Filled,
    BannerType.warning => BetterIcons.alert02Filled,
    BannerType.error => BetterIcons.alertCircleFilled,
    BannerType.idea => BetterIcons.flashFilled,
    BannerType.none => null,
  };

  Widget _getBanner(BuildContext context) {
    switch (bannerResponsive) {
      case BannerResponsive.responsive:
        return context.responsive(
          _getMobileBanner(context),
          xl: _getDesktopBanner(context),
        );

      case BannerResponsive.desktop:
        return _getDesktopBanner(context);

      case BannerResponsive.mobile:
        return _getMobileBanner(context);
    }
  }
}

/// Represents an action button in the [AppBanner].
typedef BetterBannerAction = AppBannerAction;

class AppBannerAction {
  /// The text displayed on the action button.
  final String title;

  /// The callback function triggered when the action button is pressed.
  final void Function()? onPressed;

  /// Creates an [AppBannerAction].
  const AppBannerAction({required this.title, required this.onPressed});
}
