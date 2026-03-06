import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

enum TextFieldDensity {
  dense,
  noDense,
  comfortable,
  responsive;

  EdgeInsets padding(BuildContext context) => switch (this) {
    TextFieldDensity.dense => const EdgeInsets.all(8),
    TextFieldDensity.noDense => EdgeInsets.zero,
    TextFieldDensity.comfortable => const EdgeInsets.all(14),
    TextFieldDensity.responsive =>
      context.isDesktop ? const EdgeInsets.all(14) : const EdgeInsets.all(8),
  };

  TextFieldDensity resolveDensity(BuildContext context) => switch (this) {
    TextFieldDensity.dense => TextFieldDensity.dense,
    TextFieldDensity.noDense => TextFieldDensity.noDense,
    TextFieldDensity.comfortable => TextFieldDensity.comfortable,
    TextFieldDensity.responsive =>
      context.isDesktop ? TextFieldDensity.comfortable : TextFieldDensity.dense,
  };
}
