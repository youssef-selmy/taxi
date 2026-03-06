import 'package:better_design_system/atoms/accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppAccordion)
Widget appAccordion(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 100),
    child: AppAccordion(
      title: 'Accordion label',
      subtitle: 'Description here',
      initiallyExpanded: context.knobs.boolean(
        label: 'Active',
        initialValue: false,
      ),
      style: context.knobs.object.dropdown(
        label: 'Style',
        options: AccordionStyle.values,
        labelBuilder: (value) => value.name,
      ),
    ),
  );
}
