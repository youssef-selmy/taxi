import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/templates/about_screen_template/about_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppAboutTemplate)
Widget defaultAppAboutTemplate(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 88, vertical: 40),
    child: AppAboutTemplate(
      appName: "BetterUI",
      onLegalItemTapped: (item) {},
      logo: Assets.images.brands.lumeAgency.image(width: 113, height: 97),
      onMobileBackPressed: () {},
      legalItems: [
        LegalDocumentItem(
          title: 'About Appliaction',
          markdownUrl:
              'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md',
        ),
        LegalDocumentItem(
          title: 'Licenses',
          markdownUrl:
              'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md',
        ),
        LegalDocumentItem(
          title: 'Privacy Policy',
          markdownUrl:
              'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md',
        ),
        LegalDocumentItem(
          title: 'Terms of Use',
          markdownUrl:
              'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md',
        ),
      ],
      socialLinks: SocialLinks(
        instagramUrl: 'https://instagram.com/example',
        youtubeUrl: 'https://youtube.com/example',
        xUrl: 'https://x.com/example',
      ),
      version: 'v5.0.1',
      flutterVersion: '(Build 502, Build 10 hours ago, Flutter 3.36.0-0.4.pre)',
    ),
  );
}
