import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:flutter/material.dart';

class DropdownLanguage extends StatelessWidget {
  const DropdownLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 326,
        child: AppDropdownField.single(
          isFilled: false,
          type: DropdownFieldType.compact,
          label: 'Language',
          items: [
            AppDropdownItem(
              showRadio: true,
              prefix: Assets.images.countries.unitedStates.image(
                width: 20,
                height: 20,
              ),
              title: 'English',
              value: 'English',
            ),
            AppDropdownItem(
              showRadio: true,
              prefix: Assets.images.countries.germany.image(
                width: 20,
                height: 20,
              ),
              title: 'German',
              value: 'German',
            ),
            AppDropdownItem(
              showRadio: true,
              prefix: Assets.images.countries.spain.image(
                width: 20,
                height: 20,
              ),
              title: 'Spanish',
              value: 'Spanish',
            ),
            AppDropdownItem(
              showRadio: true,
              prefix: Assets.images.countries.france.image(
                width: 20,
                height: 20,
              ),
              title: 'French',
              value: 'French',
            ),
            AppDropdownItem(
              showRadio: true,
              prefix: Assets.images.countries.netherlands.image(
                width: 20,
                height: 20,
              ),
              title: 'Dutch',
              value: 'Dutch',
            ),
          ],
        ),
      ),
    );
  }
}
