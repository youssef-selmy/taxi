import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/rating_arc_card.dart';
import '../components/rating_comment_card.dart';
import '../components/rating_feedback_card.dart';
import '../components/rating_review_card.dart';

@RoutePage()
class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Rating'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Rating',
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
                title: 'Feedback Card',
                desktopSourceCode: 'blocks/rating/rating_feedback_card.txt',
                desktopWidget: RatingFeedbackCard(),
              ),

              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1016,
                title: 'Review Card',
                desktopSourceCode: 'blocks/rating/rating_review_card.txt',
                desktopWidget: RatingReviewCard(),
              ),

              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1016,
                title: 'Comment Card',
                desktopSourceCode: 'blocks/rating/rating_comment_card.txt',
                desktopWidget: RatingCommentCard(),
              ),

              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1016,
                title: 'Arc Card',
                desktopSourceCode: 'blocks/rating/rating_arc_card.txt',
                desktopWidget: RatingArcCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
