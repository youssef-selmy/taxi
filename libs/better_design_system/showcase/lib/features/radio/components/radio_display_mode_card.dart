import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class RadioDisplayModeCard extends StatefulWidget {
  const RadioDisplayModeCard({super.key});

  @override
  State<RadioDisplayModeCard> createState() => _RadioDisplayModeCardState();
}

class _RadioDisplayModeCardState extends State<RadioDisplayModeCard> {
  final List<String> displayMode = ['Full Screen', 'Stretch', '100%', '50%'];

  String selectedDisplayMode = 'Full Screen';

  void _onDisplayModeChanged(String value) {
    setState(() {
      selectedDisplayMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  spacing: 16,
                  children: [
                    Icon(
                      BetterIcons.computerOutline,
                      size: 24,
                      color: context.colors.onSurfaceVariant,
                    ),
                    Text('Display Mode', style: context.textTheme.labelLarge),
                  ],
                ),
                Icon(
                  BetterIcons.cancelCircleOutline,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          AppDivider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              spacing: 16,
              children: [
                ...displayMode.map(
                  (e) => _buildDisplayItem(
                    context,
                    title: e,
                    onTap: (String value) {
                      _onDisplayModeChanged(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          AppDivider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Reset to Default',
                    color: SemanticColor.neutral,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayItem<T>(
    BuildContext context, {
    required String title,
    void Function(String)? onTap,
  }) {
    return Row(
      spacing: 8,
      children: [
        AppRadio(value: title, groupValue: selectedDisplayMode, onTap: onTap),
        Text(title, style: context.textTheme.labelLarge),
      ],
    );
  }
}
