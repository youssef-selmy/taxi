import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/navbar/navbar_icon.dart';
import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

/// Common search field widget used in Sales & Marketing dashboards
class SalesAndMarketingNavbarSearchField extends StatelessWidget {
  const SalesAndMarketingNavbarSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: AppTextField(
        density: TextFieldDensity.noDense,
        hint: 'Search',
        prefixIcon: Icon(
          BetterIcons.search01Filled,
          color: context.colors.onSurfaceVariant,
          size: 20,
        ),
      ),
    );
  }
}

class SalesAndMarketingSearchButton extends StatelessWidget {
  const SalesAndMarketingSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: BetterIcons.search01Filled,
      size: ButtonSize.medium,
    );
  }
}

/// Common filter icon button used in navbars
class SalesAndMarketingNavbarFilterButton extends StatelessWidget {
  const SalesAndMarketingNavbarFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNavbarIcon(icon: BetterIcons.filterHorizontalFilled);
  }
}

/// Common notification icon button used in navbars
class SalesAndMarketingNavbarNotificationButton extends StatelessWidget {
  const SalesAndMarketingNavbarNotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNavbarIcon(icon: BetterIcons.notification02Outline);
  }
}

/// Common profile button used in navbars
class SalesAndMarketingNavbarProfileButton extends StatelessWidget {
  const SalesAndMarketingNavbarProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProfileButton(
      avatarUrl: ImageFaker().person.one,
      statusBadge: StatusBadgeType.online,
    );
  }
}

/// Common menu icon for mobile view
class SalesAndMarketingNavbarMenuButton extends StatelessWidget {
  const SalesAndMarketingNavbarMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNavbarIcon(icon: BetterIcons.menu01Outline);
  }
}

/// Calendar dropdown for selecting month in Sales & Marketing dashboards
class SalesAndMarketingCalendarDropdown extends StatelessWidget {
  const SalesAndMarketingCalendarDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: AppDropdownField.single(
        items: [
          AppDropdownItem(value: 'Sep', title: 'Sep'),
          AppDropdownItem(value: 'Oct', title: 'Oct'),
          AppDropdownItem(value: 'Nov', title: 'Nov'),
        ],
        isFilled: false,
        initialValue: 'Sep',
        type: DropdownFieldType.compact,
        prefixIcon: BetterIcons.calendar03Outline,
      ),
    );
  }
}

/// Sales category dropdown for filtering sales data in dashboards
class SalesAndMarketingSalesDropdown extends StatelessWidget {
  const SalesAndMarketingSalesDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: AppDropdownField.single(
        items: [
          AppDropdownItem(value: 'Sales', title: 'Sales'),
          AppDropdownItem(value: 'Sales1', title: 'Sales1'),
          AppDropdownItem(value: 'Sales2', title: 'Sales2'),
        ],
        isFilled: false,
        initialValue: 'Sales',
        type: DropdownFieldType.compact,
      ),
    );
  }
}
