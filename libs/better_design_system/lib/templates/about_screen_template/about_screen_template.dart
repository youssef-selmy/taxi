import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'about_social_links.dart';
import 'legal_document_item.dart';

export 'legal_document_item.dart';
export 'about_social_links.dart';
export 'legal_document_template.dart';

/// A template for the About screen showing app info, legal documents, and social links.
///
/// When a legal item is tapped, [onLegalItemTapped] is called. The parent app
/// should navigate to a separate route using [AppLegalDocumentTemplate] to
/// display the legal document content.
class AppAboutTemplate extends StatelessWidget {
  final Widget logo;
  final String appName;
  final String? copyrightNotice;
  final List<LegalDocumentItem> legalItems;
  final List<Widget> additionalListItems;
  final Function()? onMobileBackPressed;
  final SocialLinks? socialLinks;
  final String? version;
  final String? flutterVersion;

  /// Called when a legal item is tapped.
  /// The parent app should navigate to a route showing [AppLegalDocumentTemplate].
  final void Function(LegalDocumentItem item) onLegalItemTapped;

  const AppAboutTemplate({
    super.key,
    required this.legalItems,
    required this.logo,
    required this.appName,
    this.copyrightNotice,
    this.onMobileBackPressed,
    this.additionalListItems = const [],
    this.socialLinks,
    this.version,
    this.flutterVersion,
    required this.onLegalItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: Column(
          children: [
            if (context.isMobile) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: AppMobileTopBar(
                  onBackPressed: onMobileBackPressed,
                  title: 'About',
                ),
              ),
              const SizedBox(height: 8),
            ],
            logo,
            const SizedBox(height: 16),
            Text(appName, style: context.textTheme.headlineSmall),
            const SizedBox(height: 24),
            ...[
              ...legalItems.map(
                (legalItem) => Row(
                  children: [
                    Expanded(
                      child: AppClickableCard(
                        borderLess: true,
                        onTap: () {
                          onLegalItemTapped.call(legalItem);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              legalItem.title,
                              style: context.textTheme.labelLarge,
                            ),
                            Icon(
                              BetterIcons.arrowRight01Outline,
                              size: 20,
                              color: context.colors.onSurface,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...additionalListItems,
            ].toList().separated(separator: const AppDivider(height: 36)),

            const Spacer(),

            if (socialLinks != null) socialLinks!.buildIcons(context),

            if (version != null || flutterVersion != null) ...[
              const SizedBox(height: 40),

              Column(
                spacing: 4,
                children: [
                  if (version != null)
                    Text(
                      version!,
                      style: context.textTheme.titleSmall?.variant(context),
                    ),
                  if (flutterVersion != null)
                    Text(
                      flutterVersion!,
                      style: context.textTheme.bodyMedium?.variant(context),
                    ),
                  if (copyrightNotice != null)
                    Text(
                      copyrightNotice!,
                      style: context.textTheme.bodySmall?.variant(context),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
