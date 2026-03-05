import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension GenderEnumExtension on Enum$Gender {
  String name(BuildContext context) => switch (this) {
    Enum$Gender.Male => context.tr.genderMale,
    Enum$Gender.Female => context.tr.genderFemale,
    Enum$Gender.Other => context.tr.genderOther,
    Enum$Gender.Unknown => context.tr.genderUnknown,
    _ => context.tr.genderUnknown,
  };

  Color get color => switch (this) {
    Enum$Gender.Male => const Color(0xFF0078D4),
    Enum$Gender.Female => const Color(0xFFE80054),
    Enum$Gender.Other => const Color(0xFF6B5B95),
    Enum$Gender.Unknown => Colors.grey,
    _ => Colors.grey,
  };
}

extension GenderEnumListExtension on List<Enum$Gender> {
  List<FilterItem<Enum$Gender>> toFilterItems(BuildContext context) => where(
    (type) => type != Enum$Gender.Unknown,
  ).map((type) => FilterItem(value: type, label: type.name(context))).toList();

  List<AppDropdownItem<Enum$Gender>> toDropdownItems(BuildContext context) =>
      where((type) => type != Enum$Gender.Unknown)
          .map(
            (type) => AppDropdownItem(value: type, title: type.name(context)),
          )
          .toList();
}
