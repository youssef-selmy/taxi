import 'package:flutter/material.dart';

enum RatingCellSize {
  small,
  medium,
  large;

  EdgeInsets get padding {
    switch (this) {
      case RatingCellSize.small:
        return const EdgeInsets.all(8);
      case RatingCellSize.medium:
        return const EdgeInsets.all(10);
      case RatingCellSize.large:
        return const EdgeInsets.all(12);
    }
  }

  double get iconSize {
    switch (this) {
      case RatingCellSize.small:
      case RatingCellSize.medium:
        return 20;
      case RatingCellSize.large:
        return 24;
    }
  }
}
