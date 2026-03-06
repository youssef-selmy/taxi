import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

export 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item.dart';

enum ListActionType { clickable, dropdown, checkable }

@Deprecated('Use AppListItem instead')
typedef BetterListAction = AppListAction;

class AppListAction<T> extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final SemanticColor color;
  final String? badgeText;
  final VoidCallback? onPressed;
  final List<AppDropdownItem<T>> items;
  final Function(T?)? onItemChanged;
  final T? initialSelectedItem;
  final ListActionType actionType;
  final Function(bool)? onCheckboxChanged;
  final bool? initialCheckboxValue;

  const AppListAction({
    super.key,
    required this.title,
    this.subtitle,
    this.onPressed,
    required this.icon,
    this.badgeText,
    this.color = SemanticColor.primary,
    this.items = const [],
    this.onItemChanged,
    this.initialSelectedItem,
    this.actionType = ListActionType.clickable,
    this.onCheckboxChanged,
    this.initialCheckboxValue,
  });

  factory AppListAction.clickable({
    required String title,
    String? subtitle,
    required IconData icon,
    VoidCallback? onPressed,
    SemanticColor color = SemanticColor.primary,
    String? badgeText,
  }) {
    return AppListAction(
      title: title,
      subtitle: subtitle,
      icon: icon,
      onPressed: onPressed,
      color: color,
      badgeText: badgeText,
      actionType: ListActionType.clickable,
    );
  }

  factory AppListAction.checkable({
    required String title,
    String? subtitle,
    required IconData icon,
    bool? initialValue,
    Function(bool)? onChanged,
    SemanticColor color = SemanticColor.primary,
    String? badgeText,
  }) {
    return AppListAction(
      title: title,
      subtitle: subtitle,
      icon: icon,
      actionType: ListActionType.checkable,
      initialCheckboxValue: initialValue,
      onCheckboxChanged: onChanged,
      badgeText: badgeText,
      color: color,
    );
  }

  factory AppListAction.dropdown({
    required String title,
    String? subtitle,
    required IconData icon,
    required List<AppDropdownItem<T>> items,
    T? initialSelectedItem,
    Function(T?)? onItemChanged,
    String? badgeText,
    SemanticColor color = SemanticColor.primary,
  }) {
    return AppListAction<T>(
      title: title,
      subtitle: subtitle,
      icon: icon,
      items: items,
      initialSelectedItem: initialSelectedItem,
      onItemChanged: onItemChanged,
      actionType: ListActionType.dropdown,
      badgeText: badgeText,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.outline, width: 1),
              color: context.colors.surfaceVariantLow,
            ),
            child: Icon(icon, color: color.main(context)),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.labelLarge),
              const SizedBox(height: 4),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: context.textTheme.bodySmall?.variant(context),
                ),
            ],
          ),
          const Spacer(),
          switch (actionType) {
            ListActionType.clickable => Icon(
              BetterIcons.arrowRight01Outline,
              color: context.colors.onSurface,
              size: 20,
            ),
            ListActionType.checkable => AppCheckbox(
              value: initialCheckboxValue ?? false,
              onChanged: (value) {
                onCheckboxChanged?.call(value);
              },
            ),
            ListActionType.dropdown => SizedBox(
              width: 140,
              child: AppDropdownField.single(
                items: items,
                type: DropdownFieldType.compact,
                onChanged: (value) {
                  onItemChanged?.call(value);
                },
                initialValue: initialSelectedItem,
              ),
            ),
          },
        ],
      ),
    );
  }
}
