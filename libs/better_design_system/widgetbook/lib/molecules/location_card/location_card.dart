import 'package:better_design_system/molecules/location_card/location_card.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppLocationCard)
Widget defaultLocationCard(BuildContext context) {
  final bool isClickable = context.knobs.boolean(
    label: 'Is Clickable',
    initialValue: true,
  );
  return SizedBox(
    width: 350,
    child: AppLocationCard(
      title: context.knobs.string(
        label: 'Title',
        initialValue: 'Location Card',
      ),
      onTap: isClickable ? () {} : null,
      address: context.knobs.string(
        label: 'Address',
        initialValue: '123 Main St, Springfield, USA',
      ),
      type: context.knobs.object.dropdown(
        label: 'Type',
        options: LocationCardType.values,
        initialOption: LocationCardType.location,
        labelBuilder: (value) => value.name,
      ),
      showArrow: context.knobs.boolean(label: 'Show Arrow', initialValue: true),
      distance:
          context.knobs.boolean(label: 'Show Distance', initialValue: true)
              ? 1432
              : null,
    ),
  );
}
