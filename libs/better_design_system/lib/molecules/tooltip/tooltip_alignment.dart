import 'package:flutter/material.dart';

enum TooltipAlignment {
  top,
  left,
  right,
  bottom;

  Offset getTooltipOffset() {
    switch (this) {
      case TooltipAlignment.top:
        return const Offset(0, -15);
      case TooltipAlignment.bottom:
        return const Offset(0, 15);
      case TooltipAlignment.left:
        return const Offset(-15, 0);
      case TooltipAlignment.right:
        return const Offset(15, 0);
    }
  }

  Alignment getTargetAnchor() {
    switch (this) {
      case TooltipAlignment.top:
        return Alignment.topCenter;
      case TooltipAlignment.bottom:
        return Alignment.bottomCenter;
      case TooltipAlignment.left:
        return Alignment.centerLeft;
      case TooltipAlignment.right:
        return Alignment.centerRight;
    }
  }

  Alignment getFollowerAnchor() {
    switch (this) {
      case TooltipAlignment.top:
        return Alignment.bottomCenter;
      case TooltipAlignment.bottom:
        return Alignment.topCenter;
      case TooltipAlignment.left:
        return Alignment.centerRight;
      case TooltipAlignment.right:
        return Alignment.centerLeft;
    }
  }
}
