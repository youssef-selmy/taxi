import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_kanban_page/components/hr_platform_kanban_board_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_mobile_top_bar.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class HrPlatformKanbanPageMobile extends StatefulWidget {
  const HrPlatformKanbanPageMobile({super.key});

  @override
  State<HrPlatformKanbanPageMobile> createState() =>
      _HrPlatformKanbanPageMobileState();
}

class _HrPlatformKanbanPageMobileState
    extends State<HrPlatformKanbanPageMobile> {
  String selectedTab = 'Candidate Pipeline';

  void _onTabChanged(String value) {
    setState(() {
      selectedTab = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HrPlatformMobileTopBar.style2(
              title: 'Recruitment',
              prefixIcon: BetterIcons.menu01Outline,
              suffixIcons: [
                BetterIcons.search01Filled,
                BetterIcons.notification02Outline,
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                spacing: 16,
                children: [
                  AppIconButton(
                    icon: BetterIcons.arrowLeft02Outline,
                    size: ButtonSize.medium,
                    style: IconButtonStyle.outline,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Designer',
                          style: context.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '25 Application',
                          style: context.textTheme.labelMedium!.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: AppTabMenuHorizontal(
                  tabs: [
                    TabMenuHorizontalOption(
                      title: 'Overview',
                      value: 'Overview',
                      icon: BetterIcons.file02Outline,
                    ),
                    TabMenuHorizontalOption(
                      title: 'Candidate Pipeline',
                      value: 'Candidate Pipeline',
                      icon: BetterIcons.dashboardSquare02Outline,
                    ),
                    TabMenuHorizontalOption(
                      title: 'Candidate Profiles',
                      value: 'Candidate Profiles',
                      icon: BetterIcons.userCircle02Outline,
                    ),
                    TabMenuHorizontalOption(
                      title: 'Hiring Analytics',
                      value: 'Hiring Analytics',
                      icon: BetterIcons.analytics01Outline,
                    ),
                    TabMenuHorizontalOption(
                      title: 'Notes & Communication',
                      value: 'Notes & Communication',
                      icon: BetterIcons.pencilEdit02Outline,
                    ),
                  ],
                  selectedValue: selectedTab,
                  onChanged: _onTabChanged,
                  style: TabMenuHorizontalStyle.primary,
                  color: SemanticColor.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: AppTextField(
                            prefixIcon: Icon(
                              BetterIcons.search01Filled,
                              color: context.colors.onSurfaceVariant,
                            ),
                            hint: 'Search',
                            isFilled: false,
                            fillColor: context.colors.surface,
                            borderRadius: BorderRadius.circular(8),
                            density: TextFieldDensity.noDense,
                          ),
                        ),
                      ),
                      AppOutlinedButton(
                        onPressed: () {},
                        text: 'Filter',
                        borderRadius: BorderRadius.circular(8),
                        prefixIcon: BetterIcons.filterHorizontalOutline,
                        foregroundColor: context.colors.onSurfaceVariant,
                        color: SemanticColor.neutral,
                        size: ButtonSize.medium,
                      ),
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      AppDropdownField.single(
                        items: [
                          AppDropdownItem(
                            value: 'Kanban view',
                            title: 'Kanban view',
                          ),
                        ],
                        onChanged: (value) {},
                        initialValue: 'Kanban view',
                        width: 128,
                        isFilled: false,
                        fillColor: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        type: DropdownFieldType.compact,
                      ),
                      AppDropdownField.single(
                        prefixIcon: BetterIcons.arrowUpDownOutline,
                        items: [AppDropdownItem(value: 'Sort', title: 'Sort')],
                        onChanged: (value) {},
                        initialValue: 'Sort',
                        width: 100,
                        isFilled: false,
                        fillColor: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        type: DropdownFieldType.compact,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const HrPlatformKanbanBoardCard(),
            ),
          ],
        ),
      ),
    );
  }
}
