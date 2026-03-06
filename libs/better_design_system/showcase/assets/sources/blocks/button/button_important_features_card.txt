import 'package:better_design_system/atoms/buttons/bordered_toggle_button.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

/// A card displaying important feature selection for team setup.
///
/// This card allows users to select features they need from predefined
/// categories like Team Collaboration and File Management.
class ButtonImportantFeaturesCard extends StatelessWidget {
  const ButtonImportantFeaturesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const AppDivider(height: 52),
            _buildFeatureCategory(
              context,
              icon: BetterIcons.userGroup03Filled,
              title: 'Team Collaboration',
              features: _teamCollaborationFeatures,
            ),
            const SizedBox(height: 24),
            _buildFeatureCategory(
              context,
              icon: BetterIcons.folder02Filled,
              title: 'File Management',
              features: _fileManagementFeatures,
            ),
            const AppDivider(height: 52),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What features are important for your team?',
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'You can always change these later in your settings',
          style: context.textTheme.bodyMedium?.variant(context),
        ),
      ],
    );
  }

  Widget _buildFeatureCategory(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<_FeatureOption> features,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryHeader(context, icon: icon, title: title),
        const SizedBox(height: 16),
        _buildFeatureOptions(features),
      ],
    );
  }

  Widget _buildCategoryHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return Row(
      spacing: 12,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.colors.outline),
          ),
          child: Icon(icon, size: 24, color: context.colors.primary),
        ),
        Text(title, style: context.textTheme.titleSmall),
      ],
    );
  }

  Widget _buildFeatureOptions(List<_FeatureOption> features) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          features.map((feature) {
            final button = AppBorderedToggleButton(
              label: feature.label,
              isSelected: feature.isSelected,
              onPressed: () {},
            );

            return feature.isSelected
                ? AppBorderedToggleButton(
                  label: feature.label,
                  isSelected: true,
                  onPressed: () {},
                  color: SemanticColor.primary,
                )
                : button;
          }).toList(),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppOutlinedButton(
          onPressed: () {},
          text: 'Cancel',
          color: SemanticColor.error,
        ),
        Row(
          spacing: 8,
          children: [
            AppOutlinedButton(
              onPressed: () {},
              text: 'Go back',
              color: SemanticColor.neutral,
              prefixIcon: BetterIcons.arrowLeft01Outline,
            ),
            AppFilledButton(
              onPressed: () {},
              text: 'Continue',
              suffixIcon: BetterIcons.arrowRight01Outline,
            ),
          ],
        ),
      ],
    );
  }

  // Feature data - extracted for better maintainability
  static const List<_FeatureOption> _teamCollaborationFeatures = [
    _FeatureOption(label: 'Task comments', isSelected: false),
    _FeatureOption(label: 'Mention teammates', isSelected: false),
    _FeatureOption(label: 'Shared calendar', isSelected: true),
    _FeatureOption(label: 'Real-time editing', isSelected: false),
  ];

  static const List<_FeatureOption> _fileManagementFeatures = [
    _FeatureOption(label: 'Auto-save changes', isSelected: false),
    _FeatureOption(label: 'Version history', isSelected: false),
    _FeatureOption(label: 'Cloud storage', isSelected: true),
    _FeatureOption(label: 'Offline mode', isSelected: false),
  ];
}

/// Internal data class for feature options.
class _FeatureOption {
  final String label;
  final bool isSelected;

  const _FeatureOption({required this.label, required this.isSelected});
}
