import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/list_item_cards/components/list_item_cards_add_payment_method_card.dart';
import 'package:better_design_showcase/features/list_item_cards/components/list_item_cards_select_language_card.dart';
import 'package:better_design_showcase/features/list_item_cards/components/list_item_cards_user_access_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class ListItemCardsScreen extends StatelessWidget {
  const ListItemCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            currentTitle: 'List Item Cards',
            previousTitle: 'Blocks',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'List Item Cards',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 408,
                title: 'Add Payment Method Card',
                desktopSourceCode:
                    'blocks/list_item_cards/list_item_cards_add_payment_method_card.txt',
                desktopWidget: const ListItemCardsAddPaymentMethodCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 568,
                title: 'Select Language Card',
                desktopSourceCode:
                    'blocks/list_item_cards/list_item_cards_select_language_card.txt',
                desktopWidget: const ListItemCardsSelectLanguageCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 578,
                title: 'User Access Card',
                desktopSourceCode:
                    'blocks/list_item_cards/list_item_cards_user_access_card.txt',
                desktopWidget: const ListItemCardsUserAccessCard(),
              ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
            ],
          ),
        ],
      ),
    );
  }
}
