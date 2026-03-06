import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_showcase/features/docs/blocs/docs.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Sidebar navigation for the documentation feature.
///
/// Displays a hierarchical list of documentation pages organized by category.
class DocsSidebar extends StatelessWidget {
  const DocsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocsCubit, DocsState>(
      builder: (context, state) {
        return SizedBox(
          width: 270,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: context.colors.transparent,
              splashColor: context.colors.transparent,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: <Widget>[
                  _buildSection(
                    context: context,
                    title: 'Get Started',
                    selectedPage: state.selectedPage,
                    items: [
                      ('Welcome', 'welcome'),
                      ('Installation', 'installation'),
                    ],
                  ),
                  _buildSection(
                    context: context,
                    title: 'Foundations',
                    selectedPage: state.selectedPage,
                    items: [
                      ('Theming', 'theming'),
                      ('Colors', 'colors'),
                      ('Typography', 'typography'),
                      ('Spacing', 'spacing'),
                      ('Shadows', 'shadows'),
                    ],
                  ),
                  _buildSection(
                    context: context,
                    title: 'Components',
                    selectedPage: state.selectedPage,
                    items: [
                      ('Atoms', 'atoms'),
                      ('Molecules', 'molecules'),
                      ('Organisms', 'organisms'),
                      ('Templates', 'templates'),
                    ],
                  ),
                  _buildSection(
                    context: context,
                    title: 'AI Assistant',
                    selectedPage: state.selectedPage,
                    items: [
                      ('Overview', 'ai-overview'),
                      ('Figma to Flutter', 'figma-to-flutter'),
                      ('Build UI with AI', 'build-ui-with-ai'),
                      ('Theme Generation', 'theme-generation'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required String selectedPage,
    required List<(String, String)> items,
  }) {
    return ExpansionTile(
      initiallyExpanded: true,
      tilePadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      title: Text(title, style: context.textTheme.labelMedium),
      iconColor: context.colors.onSurfaceVariantLow,
      childrenPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          width: 238,
          child: Column(
            spacing: 2,
            children:
                items.map((item) {
                  final (label, slug) = item;
                  return AppSidebarNavigationItem(
                    item: NavigationItem(title: label, value: slug),
                    selectedItem: selectedPage,
                    onItemSelected: (value) {
                      context.read<DocsCubit>().loadPage(value);
                    },
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
