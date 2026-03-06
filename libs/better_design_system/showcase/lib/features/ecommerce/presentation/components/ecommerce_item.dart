import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/rating_cell/rating_cell.dart';
import 'package:better_design_system/colors/color_palette.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class EcommerceItem extends StatefulWidget {
  final String category;
  final String description;
  final Widget image;
  final String currentPrice;
  final String? originalPrice;
  final String? badgeText;
  final SemanticColor? badgeColor;

  const EcommerceItem._({
    required this.category,
    required this.description,
    required this.image,
    required this.currentPrice,
    this.originalPrice,
    this.badgeText,
    this.badgeColor,
  });

  factory EcommerceItem.discount({
    required String category,
    required String description,
    required Widget image,
    required String currentPrice,
    required String originalPrice,
  }) {
    return EcommerceItem._(
      category: category,
      description: description,
      image: image,
      currentPrice: currentPrice,
      originalPrice: originalPrice,
      badgeText: '%24 off',
      badgeColor: SemanticColor.neutral,
    );
  }

  factory EcommerceItem.simple({
    required String category,
    required String description,
    required Widget image,
    required String currentPrice,
  }) {
    return EcommerceItem._(
      category: category,
      description: description,
      image: image,
      currentPrice: currentPrice,
    );
  }

  factory EcommerceItem.newItem({
    required String category,
    required String description,
    required Widget image,
    required String currentPrice,
  }) {
    return EcommerceItem._(
      category: category,
      description: description,
      image: image,
      currentPrice: currentPrice,
      badgeText: 'New',
      badgeColor: SemanticColor.primary,
    );
  }

  @override
  State<EcommerceItem> createState() => _EcommerceItemState();
}

class _EcommerceItemState extends State<EcommerceItem> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      onShowHoverHighlight: (isHovered) {
        setState(() => _isHovered = isHovered);
      },
      onShowFocusHighlight: (isFocused) {
        setState(() => _isFocused = isFocused);
      },
      onFocusChange: (isFocused) {
        setState(() => _isFocused = isFocused);
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colors.outline),
            boxShadow: [
              _isHovered || _isPressed || _isFocused
                  ? BetterShadow.shadow8.toBoxShadow(context)
                  : BetterShadow.shadowCard.toBoxShadow(context),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: widget.image,
                  ),
                  if (_isHovered || _isPressed || _isFocused)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 5),
                          duration: const Duration(milliseconds: 150),
                          builder: (context, blurValue, child) {
                            return BackdropFilter(
                              filter: ui.ImageFilter.blur(
                                sigmaX: blurValue,
                                sigmaY: blurValue,
                              ),
                              child: Container(
                                color: ColorPalette.neutral12Percent,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  if (_isHovered || _isPressed || _isFocused)
                    Positioned.fill(
                      child: Center(
                        child: AppLinkButton(
                          color: SemanticColor.neutral,
                          text: 'View',
                          onPressed: () {},
                        ),
                      ),
                    ),
                  if (widget.badgeText != null)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: AppBadge(
                        text: widget.badgeText!,
                        size: BadgeSize.small,
                        style: BadgeStyle.fill,
                        color: widget.badgeColor!,
                      ),
                    ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: AppRatingCell(
                      type: RatingCellType.favorite,
                      size: RatingCellSize.small,
                      style: RatingCellStyle.ghost,
                      iconColor: context.colors.onSurfaceVariantLow,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.category,
                  style: context.textTheme.labelSmall!.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.description,
                  style: context.textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    widget.currentPrice,
                    style: context.textTheme.labelMedium,
                  ),
                  if (widget.originalPrice != null) ...[
                    const SizedBox(width: 4),
                    Text(
                      widget.originalPrice!,
                      style: context.textTheme.labelSmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: context.colors.onSurfaceVariantLow,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
