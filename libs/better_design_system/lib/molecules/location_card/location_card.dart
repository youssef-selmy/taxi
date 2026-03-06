import 'package:better_design_system/atoms/buttons/button_interaction_state.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum LocationCardType { location, recent, compact }

typedef BetterLocationCard = AppLocationCard;

class AppLocationCard extends StatefulWidget {
  /// The icon of the location card. If not set, the default icon is used.
  /// The default icon is [BetterIcons.location01Filled].
  final IconData? icon;

  /// The title of the location card. This is the main text displayed on the card.
  final String? title;

  /// The address of the location card. This is the secondary text displayed on the card.
  /// If the address is empty and the type is [LocationCardType.template], the card will show a `select location` button.
  final String? address;

  final Function()? onTap;

  /// The type of the location card. This determines the layout and style of the card.
  /// The default type is [LocationCardType.location].
  final LocationCardType type;

  final int? distance;

  final bool showArrow;
  final bool isLoading;

  const AppLocationCard({
    super.key,
    this.icon,
    this.title,
    this.address,
    this.onTap,
    this.type = LocationCardType.location,
    this.distance,
    this.isLoading = false,
    this.showArrow = false,
  });

  @override
  State<AppLocationCard> createState() => _AppLocationCardState();
}

class _AppLocationCardState extends State<AppLocationCard> {
  bool _isPressed = false;
  bool _isHovered = false;

  ButtonInteractionState get _interactionState {
    if (widget.onTap == null) {
      return ButtonInteractionState.disabled;
    }
    if (_isPressed) {
      return ButtonInteractionState.pressed;
    } else if (_isHovered) {
      return ButtonInteractionState.hovered;
    }
    return ButtonInteractionState.normal;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (isHovered) => setState(() => _isHovered = isHovered),
      onHighlightChanged: (isPressed) => setState(() => _isPressed = isPressed),
      hoverColor: context.colors.transparent,
      highlightColor: context.colors.transparent,
      splashColor: context.colors.transparent,
      focusColor: context.colors.transparent,
      child: Row(
        spacing: 12,
        mainAxisSize: widget.type == LocationCardType.compact
            ? MainAxisSize.min
            : MainAxisSize.max,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _iconContainerBackgroundColor(context),
              borderRadius: BorderRadius.circular(8),
              border: widget.type == LocationCardType.compact
                  ? null
                  : Border.all(color: context.colors.outline),
            ),
            padding: _padding(),
            child: Icon(
              widget.icon ?? BetterIcons.location01Filled,
              color: _iconColor(context),
              size: 20,
            ),
          ),
          if (widget.type != LocationCardType.compact)
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _textContent(context),
              ),
            ),
          if (widget.type == LocationCardType.compact) _textContent(context),
          if (widget.distance != null)
            Skeletonizer(
              enabled: widget.isLoading,
              enableSwitchAnimation: true,
              child: Text(
                context.strings.distanceInKilometers(widget.distance! / 1000),
                style: context.textTheme.bodySmall?.apply(
                  color: _trailingColor(context),
                ),
              ),
            ),
          if (widget.showArrow)
            Icon(BetterIcons.arrowRight01Outline, color: _arrowColor(context)),
        ],
      ),
    );
  }

  Widget _textContent(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading,
      enableSwitchAnimation: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        children: [
          Text(
            widget.isLoading
                ? '--------------------------------------------------------------------------------'
                : (widget.title?.isNotEmpty ?? false)
                ? widget.title!
                : widget.address ?? "",
            style: context.textTheme.bodyMedium?.apply(
              color: _titleColor(context),
            ),
          ),
          if (widget.address != null &&
              widget.address!.isNotEmpty &&
              (widget.title?.isNotEmpty ?? false))
            Text(
              widget.address!,
              style: context.textTheme.bodySmall?.apply(
                color: context.colors.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }

  Color _arrowColor(BuildContext context) => switch (_interactionState) {
    ButtonInteractionState.pressed => context.colors.onSurface,
    _ => context.colors.onSurfaceVariant,
  };

  Color _trailingColor(BuildContext context) => switch (_interactionState) {
    ButtonInteractionState.hovered => context.colors.primary,
    ButtonInteractionState.pressed => context.colors.primaryBold,
    ButtonInteractionState.disabled ||
    ButtonInteractionState.normal => context.colors.primary,
  };

  Color _titleColor(BuildContext context) => switch (widget.type) {
    LocationCardType.recent => switch (_interactionState) {
      ButtonInteractionState.hovered => context.colors.primary,
      ButtonInteractionState.pressed => context.colors.onSurface,
      ButtonInteractionState.disabled ||
      ButtonInteractionState.normal => context.colors.onSurface,
    },
    LocationCardType.compact ||
    LocationCardType.location => switch (_interactionState) {
      ButtonInteractionState.hovered => context.colors.primary,
      ButtonInteractionState.pressed => context.colors.primaryBold,
      ButtonInteractionState.disabled ||
      ButtonInteractionState.normal => context.colors.onSurface,
    },
  };

  Color _iconColor(BuildContext context) => switch (widget.type) {
    LocationCardType.recent => switch (_interactionState) {
      ButtonInteractionState.hovered => context.colors.onSurfaceVariant,
      ButtonInteractionState.pressed => context.colors.onSurface,
      ButtonInteractionState.disabled ||
      ButtonInteractionState.normal => context.colors.onSurfaceVariant,
    },
    LocationCardType.compact ||
    LocationCardType.location => switch (_interactionState) {
      ButtonInteractionState.hovered => context.colors.primary,
      ButtonInteractionState.pressed => context.colors.primaryBold,
      ButtonInteractionState.disabled ||
      ButtonInteractionState.normal => context.colors.primary,
    },
  };

  Color _iconContainerBackgroundColor(BuildContext context) =>
      switch (widget.type) {
        LocationCardType.location ||
        LocationCardType.recent => context.colors.surfaceVariant,
        LocationCardType.compact => context.colors.primaryContainer,
      };

  EdgeInsets _padding() => switch (widget.type) {
    LocationCardType.location => const EdgeInsets.all(8),
    LocationCardType.recent => const EdgeInsets.all(8),
    LocationCardType.compact => const EdgeInsets.all(6),
  };
}
