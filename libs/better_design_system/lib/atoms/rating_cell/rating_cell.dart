import 'package:better_design_system/atoms/rating_cell/rating_cell_size.dart';
import 'package:better_design_system/atoms/rating_cell/rating_cell_style.dart';
import 'package:better_design_system/atoms/rating_cell/rating_cell_type.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
export 'rating_cell_size.dart';
export 'rating_cell_type.dart';
export 'rating_cell_style.dart';

typedef BetterRatingCell = AppRatingCell;

class AppRatingCell extends StatefulWidget {
  const AppRatingCell({
    super.key,
    this.isActive = false,
    this.isHalfActive = false,
    this.size = RatingCellSize.large,
    this.type = RatingCellType.star,
    this.isRounded = false,
    this.style = RatingCellStyle.outline,
    this.number,
    this.onPressed,
    this.iconColor,
  }) : assert(
         (type != RatingCellType.number || number != null) &&
             (number == null || type == RatingCellType.number),
         'number cannot be null when type is RatingCellType.number and must be used only when type is RatingCellType.number',
       );

  final bool isActive;
  final bool isHalfActive;
  final bool isRounded;
  final RatingCellSize size;
  final RatingCellType type;
  final RatingCellStyle style;
  final int? number;
  final void Function()? onPressed;
  final Color? iconColor;

  @override
  State<AppRatingCell> createState() => _AppRatingCellState();
}

class _AppRatingCellState extends State<AppRatingCell> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.isRounded ? 100 : 8),
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      onTap: widget.onPressed,
      child: Container(
        padding: widget.size.padding,
        decoration: BoxDecoration(
          color:
              widget.number != null && (widget.isActive || widget.isHalfActive)
              ? context.colors.primaryContainer
              : _getBackgroundColor(context),
          border: widget.style == RatingCellStyle.outline
              ? Border.all(width: 1, color: context.colors.outline)
              : null,
          borderRadius: BorderRadius.circular(widget.isRounded ? 100 : 8),
        ),
        child: _getCenterWidget(context),
      ),
    );
  }

  Widget _getCenterWidget(BuildContext context) {
    switch (widget.type) {
      case RatingCellType.star:
        if (widget.isHalfActive && !widget.isActive) {
          return Stack(
            children: [
              Icon(
                BetterIcons.starOutline,
                size: widget.size.iconSize,
                color: _getForegroundColor(context),
              ),
              ClipRect(
                clipper: _HalfClipper(),
                child: Icon(
                  BetterIcons.starFilled,
                  size: widget.size.iconSize,
                  color: _getForegroundColor(context),
                ),
              ),
            ],
          );
        }
        return Icon(
          widget.isActive ? BetterIcons.starFilled : BetterIcons.starOutline,
          size: widget.size.iconSize,
          color: widget.isActive
              ? _getForegroundColor(context)
              : context.colors.onSurfaceVariantLow,
        );

      case RatingCellType.favorite:
        if (widget.isHalfActive && !widget.isActive) {
          return Stack(
            children: [
              Icon(
                BetterIcons.favouriteOutline,
                size: widget.size.iconSize,
                color: _getForegroundColor(context),
              ),
              ClipRect(
                clipper: _HalfClipper(),
                child: Icon(
                  BetterIcons.favouriteFilled,
                  size: widget.size.iconSize,
                  color: _getForegroundColor(context),
                ),
              ),
            ],
          );
        }
        return Icon(
          widget.isActive
              ? BetterIcons.favouriteFilled
              : BetterIcons.favouriteOutline,
          size: widget.size.iconSize,
          color: widget.isActive
              ? _getForegroundColor(context)
              : context.colors.onSurfaceVariantLow,
        );

      case RatingCellType.number:
        return SizedBox(
          width: widget.size == RatingCellSize.large ? 24 : 20,
          height: widget.size == RatingCellSize.large ? 24 : 20,
          child: Center(
            child: Text(
              widget.number.toString(),
              style: _getNumberTextStyle(context),
            ),
          ),
        );
    }
  }

  TextStyle? _getNumberTextStyle(BuildContext context) {
    switch (widget.size) {
      case RatingCellSize.small:
      case RatingCellSize.medium:
        return context.textTheme.labelLarge?.copyWith(
          color: _getForegroundColor(context),
        );
      case RatingCellSize.large:
        return context.textTheme.titleSmall?.copyWith(
          color: _getForegroundColor(context),
        );
    }
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (widget.style == RatingCellStyle.ghost) {
      if (_isHovered) {
        return context.colors.surfaceVariantLow;
      } else {
        return null;
      }
    } else {
      if (_isHovered) {
        return context.colors.surfaceVariantLow;
      } else {
        return context.colors.surface;
      }
    }
  }

  Color _getForegroundColor(BuildContext context) {
    // If iconColor is provided, use it
    if (widget.iconColor != null) {
      return widget.iconColor!;
    }

    switch (widget.type) {
      case RatingCellType.star:
        return context.colors.warning;

      case RatingCellType.favorite:
        return context.colors.error;

      case RatingCellType.number:
        if (widget.isActive || widget.isHalfActive) {
          return context.colors.primary;
        } else if (_isHovered) {
          return context.colors.onSurface;
        } else {
          return context.colors.onSurfaceVariant;
        }
    }
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
