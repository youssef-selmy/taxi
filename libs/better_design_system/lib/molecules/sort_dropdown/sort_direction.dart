import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

enum SortDirection { ascending, descending }

extension SortDirectionX on SortDirection {
  String titleTime(BuildContext context) => switch (this) {
    SortDirection.ascending => context.strings.oldToNew,
    SortDirection.descending => context.strings.newToOld,
  };

  String titleText(BuildContext context) => switch (this) {
    SortDirection.ascending => context.strings.aToZ,
    SortDirection.descending => context.strings.zToA,
  };

  String titleAmount(BuildContext context) => switch (this) {
    SortDirection.ascending => context.strings.lowToHigh,
    SortDirection.descending => context.strings.highToLow,
  };

  String titleNumber(BuildContext context) => switch (this) {
    SortDirection.ascending => context.strings.ascending,
    SortDirection.descending => context.strings.descending,
  };
}
