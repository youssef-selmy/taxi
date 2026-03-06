import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppProfileCell)
Widget defaultProfileCell(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 200,
        child: AppProfileCell(
          name: 'John Doe',
          subtitle: 'Software Engineer',
          imageUrl: ImageFaker().person.random(),
        ),
      ),
    ],
  );
}
