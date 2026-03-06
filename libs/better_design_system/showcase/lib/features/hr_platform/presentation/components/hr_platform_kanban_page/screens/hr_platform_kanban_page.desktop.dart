import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_sidebar.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_kanban_page/components/hr_platform_kanban_board_card.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/navbar/navbar_icon.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class HrPlatformKanbanPageDesktop extends StatefulWidget {
  final Widget? header;
  const HrPlatformKanbanPageDesktop({super.key, this.header});

  @override
  State<HrPlatformKanbanPageDesktop> createState() =>
      _HrPlatformKanbanPageDesktopState();
}

class _HrPlatformKanbanPageDesktopState
    extends State<HrPlatformKanbanPageDesktop> {
  String selectedTab = 'Candidate Pipeline';

  void _onTabChanged(String value) {
    setState(() {
      selectedTab = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.header != null) widget.header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HrPlatformSidebar(
                selectedItem: HrPlatformSidebarPage.recruitment,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Recruitment',
                            style: context.textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          AppNavbarIcon(
                            icon: BetterIcons.search01Filled,
                            iconColor: context.colors.onSurfaceVariant,
                            iconSize: 22,
                            size: ButtonSize.medium,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          const SizedBox(width: 10),
                          AppNavbarIcon(
                            icon: BetterIcons.notification02Outline,
                            iconColor: context.colors.onSurfaceVariant,
                            iconSize: 24,
                            badgeNumber: 2,
                            size: ButtonSize.medium,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          const SizedBox(width: 10),
                          AppProfileButton(
                            avatarUrl: ImageFaker().person.four,
                            title: 'Paityn Baptista',
                            items: [
                              AppPopupMenuItem(
                                title: 'Profile',
                                onPressed: () {},
                                icon: BetterIcons.userFilled,
                              ),
                              AppPopupMenuItem(
                                title: 'Profile',
                                onPressed: () {},
                                icon: BetterIcons.wallet01Filled,
                              ),
                              AppPopupMenuItem(
                                hasDivider: true,
                                title: 'Logout',
                                onPressed: () {},
                                icon: BetterIcons.logout01Filled,
                                color: SemanticColor.error,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 38),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppOutlinedButton(
                            onPressed: () {},
                            size: ButtonSize.medium,
                            borderRadius: BorderRadius.circular(50),
                            prefixIcon: BetterIcons.arrowLeft02Outline,
                            color: SemanticColor.neutral,
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Product Designer',
                                style: context.textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '25 Applications',
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: context.colors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      AppTabMenuHorizontal(
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
                        isFullWidth: true,
                      ),
                      const SizedBox(height: 24),
                      Row(
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
                            borderRadius: BorderRadius.circular(18),
                            type: DropdownFieldType.compact,
                          ),
                          const SizedBox(width: 8),
                          AppDropdownField.single(
                            prefixIcon: BetterIcons.arrowUpDownOutline,
                            items: [
                              AppDropdownItem(value: 'Sort', title: 'Sort'),
                            ],
                            onChanged: (value) {},
                            initialValue: 'Sort',
                            width: 100,
                            isFilled: false,
                            fillColor: context.colors.surface,
                            borderRadius: BorderRadius.circular(18),
                            type: DropdownFieldType.compact,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 358,
                            height: 40,
                            child: AppTextField(
                              prefixIcon: Icon(
                                BetterIcons.search01Filled,
                                color: context.colors.onSurfaceVariant,
                              ),
                              hint: 'Search',
                              isFilled: false,
                              fillColor: context.colors.surface,
                              borderRadius: BorderRadius.circular(50),
                              density: TextFieldDensity.noDense,
                            ),
                          ),
                          AppOutlinedButton(
                            onPressed: () {},
                            text: 'Filter',
                            borderRadius: BorderRadius.circular(50),
                            prefixIcon: BetterIcons.filterHorizontalOutline,
                            foregroundColor: context.colors.onSurfaceVariant,
                            color: SemanticColor.neutral,
                            size: ButtonSize.medium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const HrPlatformKanbanBoardCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
