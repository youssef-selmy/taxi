import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/checkbox/components/checkbox_plan_dropdown.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/checkbox_dashboard_customization_card.dart';
import '../components/checkbox_mobile_brand_card.dart';

@RoutePage()
class CheckboxScreen extends StatelessWidget {
  const CheckboxScreen({super.key});
  static const double width = 1016;
  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Checkbox',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            iconBackgroundColor: context.colors.warning,
            iconColor: context.colors.onWarning,
            title: 'Checkboxes',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: width,
                maxHeight: 520,
                title: 'Dashboard Customization Card',
                desktopSourceCode:
                    'blocks/checkbox/checkbox_dashboard_customization_card.txt',
                desktopWidget: CheckboxDashboardCustomizationCard(),
              ),

              AppPreviewComponent(
                borderRadius: BorderRadius.circular(8),
                maxWidth: width,
                maxHeight: 520,
                title: 'Plan Dropdown',
                desktopSourceCode: 'blocks/checkbox/checkbox_plan_dropdown.txt',
                desktopWidget: CheckboxPlanDropdown(),
              ),
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: width,
                maxHeight: 545,
                title: 'Mobile Brand Card',
                desktopSourceCode:
                    'blocks/checkbox/checkbox_mobile_brand_card.txt',
                desktopWidget: CheckboxMobileBrandCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
