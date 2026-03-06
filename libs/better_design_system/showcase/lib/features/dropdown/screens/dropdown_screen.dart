import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/dropdown_account_menu_card.dart';
import '../components/dropdown_language.dart';
import '../components/dropdown_phone_number.dart';
import '../components/dropdown_quick_account_menu_card.dart';

@RoutePage()
class DropdownScreen extends StatelessWidget {
  const DropdownScreen({super.key});

  static const double width = 1016;

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Dropdown',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            iconBackgroundColor: context.colors.warning,
            iconColor: context.colors.onWarning,
            title: 'Dropdown',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: width,
                maxHeight: 520,
                title: 'Language',
                desktopSourceCode: 'blocks/dropdown/dropdown_language.txt',
                desktopWidget: DropdownLanguage(),
              ),
              AppPreviewComponent(
                maxWidth: width,
                maxHeight: 400,
                title: 'Phone Number',
                desktopSourceCode: 'blcoks/dropdown/dropdown_phone_number.txt',
                desktopWidget: DropdownPhoneNumber(),
              ),
              AppPreviewComponent(
                maxWidth: width,
                maxHeight: 625,
                title: 'Account Menu Card',
                desktopSourceCode:
                    'blocks/dropdown/dropdown_account_menu_card.txt',
                desktopWidget: DropdownAccountMenuCard(),
              ),
              AppPreviewComponent(
                maxWidth: width,
                maxHeight: 540,
                title: 'Quick Account Menu Card',
                desktopSourceCode:
                    'blocks/dropdown/dropdown_quick_account_menu_card.txt',
                desktopWidget: DropdownQuickAccountMenuCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
