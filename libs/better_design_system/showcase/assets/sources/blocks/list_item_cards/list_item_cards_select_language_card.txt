import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class ListItemCardsSelectLanguageCard extends StatefulWidget {
  const ListItemCardsSelectLanguageCard({super.key});

  @override
  State<ListItemCardsSelectLanguageCard> createState() =>
      _ListItemCardsSelectLanguageCardState();
}

class _ListItemCardsSelectLanguageCardState
    extends State<ListItemCardsSelectLanguageCard> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _languages = [
    {'name': 'United State', 'flag': Assets.images.countries.usSvg},
    {'name': 'United Kingdom', 'flag': Assets.images.countries.gbSvg},
    {'name': 'Germany', 'flag': Assets.images.countries.deSvg},
    {'name': 'Canada', 'flag': Assets.images.countries.caSvg},
    {'name': 'India', 'flag': Assets.images.countries.inSvg},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 385,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Language', style: context.textTheme.titleSmall),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: AppTextField(
                hint: 'Search',
                prefixIcon: Icon(
                  BetterIcons.search01Filled,
                  color: context.colors.onSurfaceVariant,
                ),
                density: TextFieldDensity.noDense,
              ),
            ),
            Column(
              children: List.generate(
                _languages.length,
                (index) => Column(
                  children: [
                    AppListItem(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: (_languages[index]['flag'] as AssetGenImage)
                            .image(width: 32, height: 32, fit: BoxFit.cover),
                      ),
                      title: _languages[index]['name']!,
                      isSelected: _selectedIndex == index,
                      isCompact: true,
                      actionType: ListItemActionType.radio,
                      onTap: (_) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                    if (index < _languages.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 9.5),
                        child: AppDivider(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
