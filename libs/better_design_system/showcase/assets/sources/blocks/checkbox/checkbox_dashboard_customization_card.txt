import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CheckboxDashboardCustomizationCard extends StatefulWidget {
  const CheckboxDashboardCustomizationCard({super.key});

  @override
  State<CheckboxDashboardCustomizationCard> createState() =>
      _CheckboxDashboardCustomizationCardState();
}

class _CheckboxDashboardCustomizationCardState
    extends State<CheckboxDashboardCustomizationCard> {
  List<String> selectedCheckboxes = ['Calendar'];

  void onCheckBoxTapped(String value) {
    if (selectedCheckboxes.contains(value)) {
      setState(() {
        selectedCheckboxes.removeWhere((element) => element == value);
      });
    } else {
      setState(() {
        selectedCheckboxes.add(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 496,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 8,
              top: 14,
              bottom: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.outline),
                        color: context.colors.surface,
                      ),
                      child: Icon(
                        BetterIcons.dashboardSquare01Filled,
                        size: 24,
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          'Dashboard Customization',
                          style: context.textTheme.labelLarge,
                        ),
                        Text(
                          'Activate the tools you use most.',
                          style: context.textTheme.bodyMedium?.variantLow(
                            context,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AppIconButton(icon: BetterIcons.cancelCircleOutline),
              ],
            ),
          ),
          AppDivider(height: 1),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              spacing: 20,
              children: [
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: _buildDashboardItem(
                        context,
                        icon: BetterIcons.calendar03Filled,
                        iconColor: context.colors.primary,
                        isSelected: selectedCheckboxes.contains('Calendar'),
                        title: 'Calendar',
                        subtitle: 'Stay on schedule',
                        onChanged: (_) {
                          onCheckBoxTapped('Calendar');
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildDashboardItem(
                        context,
                        icon: BetterIcons.userGroup03Filled,
                        iconColor: context.colors.insight,
                        isSelected: selectedCheckboxes.contains(
                          'Team Activity',
                        ),
                        title: 'Team Activity',
                        subtitle: 'Team updates at a glance',
                        onChanged: (_) {
                          onCheckBoxTapped('Team Activity');
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: _buildDashboardItem(
                        context,
                        icon: BetterIcons.pieChart01Filled,
                        iconColor: context.colors.error,
                        isSelected: selectedCheckboxes.contains(
                          'Financial Reports',
                        ),
                        title: 'Financial Reports',
                        subtitle: 'Track your earnings',
                        onChanged: (_) {
                          onCheckBoxTapped('Financial Reports');
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildDashboardItem(
                        context,
                        icon: BetterIcons.folder01Filled,
                        iconColor: context.colors.warning,
                        isSelected: selectedCheckboxes.contains(
                          'Project Status',
                        ),
                        title: 'Project Status',
                        subtitle: 'Monitor progress',
                        onChanged: (_) {
                          onCheckBoxTapped('Project Status');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppDivider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Cancel',
                    color: SemanticColor.neutral,
                  ),
                ),
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Save Changes',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required String title,
    required String subtitle,
    required void Function(bool)? onChanged,
  }) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: context.colors.outline),
      color:
          isSelected
              ? context.colors.surfaceVariantLow
              : context.colors.surface,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon, size: 24, color: iconColor),
            AppCheckbox(value: isSelected, onChanged: onChanged),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(title, style: context.textTheme.labelLarge),
            Text(
              subtitle,
              style: context.textTheme.bodySmall?.variant(context),
            ),
          ],
        ),
      ],
    ),
  );
}
