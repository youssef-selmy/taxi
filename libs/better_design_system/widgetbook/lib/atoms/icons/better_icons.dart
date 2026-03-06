import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:better_icons/better_icons.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: BetterIcons)
Widget lumeIcons(BuildContext context) {
  return IconExplorer();
}

class IconExplorer extends StatefulWidget {
  const IconExplorer({super.key});

  @override
  State<IconExplorer> createState() => _IconExplorerState();
}

class _IconExplorerState extends State<IconExplorer> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final filteredIcons =
        _search.isEmpty
            ? betterIconsDictionary
            : Map.fromEntries(
              betterIconsDictionary.entries.where(
                (entry) =>
                    entry.key.toLowerCase().contains(_search.toLowerCase()),
              ),
            );

    return SizedBox(
      width: 600,
      height: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _search = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              if (filteredIcons.isNotEmpty)
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: LayoutGrid(
                        rowSizes: List.generate(
                          (filteredIcons.length / 4).ceil(),
                          (index) => auto,
                        ),
                        columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
                        columnGap: 8,
                        rowGap: 8,
                        children:
                            filteredIcons.keys.map((key) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(filteredIcons[key], size: 32),
                                    const SizedBox(height: 8),
                                    Text(
                                      key,
                                      style: context.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
