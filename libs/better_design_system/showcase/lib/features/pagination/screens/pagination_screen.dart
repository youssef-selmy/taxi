import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/pagination/components/pagination_orders_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class PaginationScreen extends StatelessWidget {
  const PaginationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            currentTitle: 'Pagination',
            previousTitle: 'Blocks',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Pagination',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          AppPreviewComponent(
            maxWidth: 1336,
            maxHeight: 900,
            title: 'Orders Card',
            desktopSourceCode: 'blocks/pagination/pagination_orders_card.txt',
            desktopWidget: const PaginationOrdersCard(),
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
