import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class CheckboxMobileBrandCard extends StatefulWidget {
  const CheckboxMobileBrandCard({super.key});

  @override
  State<CheckboxMobileBrandCard> createState() =>
      _CheckboxMobileBrandCardState();
}

class _CheckboxMobileBrandCardState extends State<CheckboxMobileBrandCard> {
  final List<String> brandsList = [
    'Samsung',
    'Huawei',
    'Apple',
    'SONY',
    'Xiaomi',
    'HTC',
    'LG',
    'Nokia',
  ];

  List<String> selectedBrands = [
    'Samsung',
    'Huawei',
    'Apple',
    'SONY',
    'Xiaomi',
    'LG',
  ];

  void onBrandSelected(String value) {
    if (selectedBrands.contains(value)) {
      setState(() {
        selectedBrands.removeWhere((element) => element == value);
      });
    } else {
      setState(() {
        selectedBrands.add(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mobile Brand', style: context.textTheme.titleSmall),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: AppTextField(
                      density: TextFieldDensity.noDense,
                      prefixIcon: Icon(
                        BetterIcons.search01Filled,
                        size: 20,
                        color: context.colors.onSurfaceVariant,
                      ),
                      hint: 'Search',
                    ),
                  ),
                ),
              ],
            ),

            Row(
              spacing: 8,
              children: [
                Icon(
                  BetterIcons.removeSquareFilled,
                  size: 20,
                  color: context.colors.primary,
                ),
                Text(
                  'Select All Brand',
                  style: context.textTheme.labelLarge?.variant(context),
                ),
              ],
            ),

            SizedBox(
              height: 138,
              child: GridView.count(
                childAspectRatio: 8,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                children: List.generate(brandsList.length, (index) {
                  return Row(
                    spacing: 8,
                    children: <Widget>[
                      AppCheckbox(
                        value: selectedBrands.contains(brandsList[index]),
                        onChanged: (_) {
                          onBrandSelected(brandsList[index]);
                        },
                      ),
                      Text(
                        brandsList[index],
                        style: context.textTheme.labelLarge,
                      ),
                    ],
                  );
                }),
              ),
            ),
            AppTextButton(
              onPressed: () {},
              prefixIcon: BetterIcons.add01Outline,
              text: 'Show more',
              color: SemanticColor.info,
            ),

            AppDivider(height: 4),

            Row(
              children: [
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Apply',
                    color: SemanticColor.neutral,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
