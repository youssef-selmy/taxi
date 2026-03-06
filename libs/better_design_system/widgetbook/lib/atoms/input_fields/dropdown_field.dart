import 'package:flutter/widgets.dart';

import 'package:better_icons/better_icons.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:better_design_system/atoms/buttons/soft_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';

@UseCase(name: 'Default', type: AppDropdownField)
Widget defaultDropdown(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppDropdownField(
      label: context.knobs.title,
      helpText: context.knobs.subtitle,
      prefixIcon: context.knobs.iconOrNull,
      sublabel: context.knobs.subLabel,
      isFilled: context.knobs.isFilled,
      type: context.knobs.dropdownFieldType,
      isDisabled: context.knobs.isDisabled,
      showChips: context.knobs.boolean(
        label: 'Show Chips',
        initialValue: false,
        description: 'Display selected items as chips below the dropdown',
      ),
      items: [
        AppDropdownItem(
          title: "Item 1",
          value: "1",
          subtitle: "Subtitle 1",
          prefixIcon: BetterIcons.globalOutline,
          sublabel: 'Sublabel',
        ),
        AppDropdownItem(
          title: "Item 2",
          value: "2",
          subtitle: "Subtitle 2",
          prefixIcon: BetterIcons.globalOutline,
        ),
        AppDropdownItem(
          title: "Item 3",
          value: "3",
          subtitle: "Subtitle 3",
          prefixIcon: BetterIcons.globalOutline,
        ),
      ],
    ),
  );
}

@UseCase(name: 'Single Select', type: AppDropdownField)
Widget singleSelectDropdown(BuildContext context) {
  return SizedBox(
    width: 350,
    child: AppDropdownField.single(
      label: context.knobs.title,
      helpText: context.knobs.subtitle,
      prefixIcon: context.knobs.iconOrNull,
      sublabel: context.knobs.subLabel,
      isFilled: context.knobs.isFilled,
      type: context.knobs.dropdownFieldType,
      isDisabled: context.knobs.isDisabled,
      items: [
        AppDropdownItem(title: "Item 1", value: "1"),
        AppDropdownItem(title: "Item 2", value: "2"),
        AppDropdownItem(title: "Item 3", value: "3"),
      ],
    ),
  );
}

@UseCase(name: 'Full Item', type: AppDropdownField)
Widget dropdownFullItem(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppDropdownField(
      label: context.knobs.title,
      helpText: context.knobs.subtitle,
      prefixIcon: context.knobs.iconOrNull,
      sublabel: context.knobs.subLabel,
      isFilled: context.knobs.isFilled,
      type: context.knobs.dropdownFieldType,
      isDisabled: context.knobs.isDisabled,
      items: [
        AppDropdownItem(
          title: "Item 1",
          value: "1",
          subtitle: "Subtitle 1",
          prefixIcon: BetterIcons.globalOutline,
          sublabel: 'Sublabel',
          showCheckbox: context.knobs.boolean(
            label: 'Show Checkbox',
            initialValue: true,
          ),
          showRadio: context.knobs.boolean(
            label: 'Show Radio',
            initialValue: true,
          ),
          showArrow: context.knobs.boolean(
            label: 'Show Arrow',
            initialValue: true,
          ),
          suffix: [
            AppBadge(
              text: 'Badge',
              size: BadgeSize.small,
              color: SemanticColor.warning,
            ),
            AppSoftButton(
              onPressed: () {},
              color: SemanticColor.primary,
              text: 'Button',
              size: ButtonSize.small,
            ),
            AppSwitch(
              isSelected: context.knobs.boolean(
                label: 'Switch',
                initialValue: true,
              ),
              onChanged: (p0) {},
            ),
          ],
          isDisabled: context.knobs.isDisabled,
        ),
        AppDropdownItem(
          title: "Item 2",
          value: "2",
          subtitle: "Subtitle 2",
          sublabel: 'Sublabel',
          prefixIcon: BetterIcons.globalOutline,
          showCheckbox: context.knobs.boolean(
            label: 'Checkbox',
            initialValue: true,
          ),
          showRadio: context.knobs.boolean(label: 'Radio', initialValue: true),
          showArrow: context.knobs.boolean(label: 'Arrow', initialValue: true),
          suffix: [
            AppBadge(
              text: 'Badge',
              size: BadgeSize.small,
              color: SemanticColor.warning,
            ),
            AppSoftButton(
              onPressed: () {},
              color: SemanticColor.primary,
              text: 'Button',
              size: ButtonSize.small,
            ),
            AppSwitch(
              isSelected: context.knobs.boolean(
                label: 'Switch',
                initialValue: true,
              ),
              onChanged: (p0) {},
            ),
          ],
          isDisabled: context.knobs.boolean(
            label: 'Disabled Item',
            initialValue: false,
          ),
        ),
        AppDropdownItem(
          title: "Item 3",
          value: "3",
          subtitle: "Subtitle 3",
          sublabel: 'Sublabel',
          prefixIcon: BetterIcons.globalOutline,
          showCheckbox: context.knobs.boolean(
            label: 'Checkbox',
            initialValue: true,
          ),
          showRadio: context.knobs.boolean(label: 'Radio', initialValue: true),
          showArrow: context.knobs.boolean(label: 'Arrow', initialValue: true),
          suffix: [
            AppBadge(
              text: 'Badge',
              size: BadgeSize.small,
              color: SemanticColor.warning,
            ),
            AppSoftButton(
              onPressed: () {},
              color: SemanticColor.primary,
              text: 'Button',
              size: ButtonSize.small,
            ),
            AppSwitch(
              isSelected: context.knobs.boolean(
                label: 'Switch',
                initialValue: true,
              ),
              onChanged: (p0) {},
            ),
          ],
          isDisabled: context.knobs.boolean(
            label: 'Disabled Item',
            initialValue: false,
          ),
        ),
      ],
    ),
  );
}
