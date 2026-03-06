import 'package:better_design_system/atoms/rating_cell/rating_cell.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'package:better_design_system/atoms/rating_cell/rating_cell.dart';

typedef BetterRatingBar = AppRatingBar;

class AppRatingBar extends StatefulWidget {
  const AppRatingBar({
    super.key,
    this.size = RatingCellSize.large,
    this.type = RatingCellType.star,
    this.isRounded = false,
    this.style = RatingCellStyle.outline,
    this.allowHalfRating = false,
    required this.rate,
    required this.onPressed,
  });

  @override
  State<AppRatingBar> createState() => _AppRatingBarState();

  final bool isRounded;
  final bool allowHalfRating;
  final RatingCellSize size;
  final RatingCellType type;
  final RatingCellStyle style;
  final double? rate;
  final void Function(double value) onPressed;
}

class _AppRatingBarState extends State<AppRatingBar> {
  final List<GlobalKey> _keys = List.generate(5, (index) => GlobalKey());

  double _getRatingFromPosition(Offset globalPosition) {
    for (int i = 0; i < _keys.length; i++) {
      final RenderBox? renderBox =
          _keys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final Offset localPosition = renderBox.globalToLocal(globalPosition);
        final Size size = renderBox.size;

        if (localPosition.dx >= 0 &&
            localPosition.dx <= size.width &&
            localPosition.dy >= 0 &&
            localPosition.dy <= size.height) {
          if (widget.allowHalfRating && widget.type == RatingCellType.star) {
            // Check if tap/drag is on left or right half
            final bool isLeftHalf = localPosition.dx < size.width / 2;
            return i + (isLeftHalf ? 0.5 : 1.0);
          } else {
            return (i + 1).toDouble();
          }
        }
      }
    }
    return widget.rate ?? 0.0;
  }

  bool _isActiveForIndex(int index) {
    final double currentRate = widget.rate ?? 0.0;

    if (widget.type == RatingCellType.number) {
      return currentRate == index + 1;
    } else {
      return currentRate > index;
    }
  }

  bool _isHalfActiveForIndex(int index) {
    if (!widget.allowHalfRating || widget.type != RatingCellType.star) {
      return false;
    }

    final double currentRate = widget.rate ?? 0.0;
    return currentRate > index && currentRate < index + 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final double newRating = _getRatingFromPosition(details.globalPosition);
        widget.onPressed(newRating);
      },
      onTapUp: (details) {
        final double newRating = _getRatingFromPosition(details.globalPosition);
        widget.onPressed(newRating);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...List.generate(5, (index) {
            return AppRatingCell(
              key: _keys[index],
              onPressed: () {
                if (widget.allowHalfRating &&
                    widget.type == RatingCellType.star) {
                  // Default to full star when tapped directly
                  widget.onPressed((index + 1).toDouble());
                } else {
                  widget.onPressed((index + 1).toDouble());
                }
              },
              isActive: _isActiveForIndex(index),
              isHalfActive: _isHalfActiveForIndex(index),
              isRounded: widget.isRounded,
              number: widget.type == RatingCellType.number ? index + 1 : null,
              size: widget.size,
              style: widget.style,
              type: widget.type,
            );
          }).toList().separated(separator: const SizedBox(width: 8)),
        ],
      ),
    );
  }
}
