import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/modal/components/modal_add_wallet_balance_card.dart';
import 'package:better_design_showcase/features/modal/components/modal_delete_card.dart';
import 'package:better_design_showcase/features/modal/components/modal_email_verification_card.dart';
import 'package:better_design_showcase/features/modal/components/modal_user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class ModalScreen extends StatelessWidget {
  const ModalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(currentTitle: 'Modal', previousTitle: 'Blocks'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Modal',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 388,
                title: 'Email Verification Card',
                desktopSourceCode:
                    'blocks/modal/modal_email_verification_card.txt',
                desktopWidget: const ModalEmailVerificationCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 820,
                title: 'Add Wallet Balance Card',
                desktopSourceCode:
                    'blocks/modal/modal_add_wallet_balance_card.txt',
                desktopWidget: const ModalAddWalletBalanceCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 776,
                title: 'User Details',
                desktopSourceCode: 'blocks/modal/modal_user_details.txt',
                desktopWidget: const ModalUserDetails(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 376,
                title: 'Delete Card',
                desktopSourceCode: 'blocks/modal/modal_delete_card.txt',
                desktopWidget: const ModalDeleteCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
