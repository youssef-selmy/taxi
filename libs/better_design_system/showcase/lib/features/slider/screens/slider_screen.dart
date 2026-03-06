import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/slider_image_clarity_card.dart';
import '../components/slider_price_range_card.dart';
import '../components/slider_volume_control_card.dart';

@RoutePage()
class SliderScreen extends StatelessWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Slider'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Slider',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1016,
                title: 'Price Range Card',
                desktopSourceCode: 'blocks/slider/slider_price_range_card.txt',
                desktopWidget: SliderPriceRangeCard(),
              ),

              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1016,
                title: 'Image Clarity Card',
                desktopSourceCode:
                    'blocks/slider/slider_image_clarity_card.txt',
                desktopWidget: SliderImageClarityCard(),
              ),

              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1016,
                title: 'Volume Control Card',
                desktopSourceCode:
                    'blocks/slider/slider_volume_control_card.txt',
                desktopWidget: SliderVolumeControlCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
