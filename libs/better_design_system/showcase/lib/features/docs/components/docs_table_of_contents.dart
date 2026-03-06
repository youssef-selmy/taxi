import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_showcase/features/docs/blocs/docs.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Table of contents showing headings on the current documentation page.
///
/// Displays "On This Page" navigation with extracted headings from the
/// markdown content, allowing users to quickly jump to specific sections.
class DocsTableOfContents extends StatelessWidget {
  /// Callback when a heading is selected from the table of contents.
  final void Function(String heading)? onHeadingSelected;

  const DocsTableOfContents({super.key, this.onHeadingSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocsCubit, DocsState>(
      builder: (context, state) {
        if (state.headings.isEmpty) {
          return const SizedBox.shrink();
        }

        return Align(
          alignment: Alignment.topRight,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ON THIS PAGE',
                  style: context.textTheme.labelSmall?.variant(context),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 250,
                  child: Column(
                    spacing: 2,
                    children:
                        state.headings.map((heading) {
                          return AppSidebarNavigationItem(
                            item: NavigationItem(
                              title: heading,
                              value: heading,
                            ),
                            selectedItem: state.activeHeading ?? '',
                            onItemSelected: (value) {
                              onHeadingSelected?.call(value);
                            },
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
