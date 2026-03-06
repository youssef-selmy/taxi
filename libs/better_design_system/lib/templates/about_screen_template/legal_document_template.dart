import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'legal_document_item.dart';

/// A template for displaying legal documents (privacy policy, terms of service, etc.)
/// as markdown content.
///
/// This template should be used as a separate route when navigating from
/// [AppAboutTemplate].
class AppLegalDocumentTemplate extends StatelessWidget {
  /// The legal document item containing title and markdown URL.
  final LegalDocumentItem item;

  /// Called when the back button is pressed.
  final VoidCallback? onBackPressed;

  const AppLegalDocumentTemplate({
    super.key,
    required this.item,
    this.onBackPressed,
  });

  Future<String> _loadMarkdown(BuildContext context) async {
    final source = item.markdownUrl;
    if (source.startsWith('http')) {
      final uri = Uri.parse(source);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load markdown from server');
      }
    }

    return await DefaultAssetBundle.of(context).loadString(source);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppMobileTopBar(
                onBackPressed: onBackPressed,
                title: item.title,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<String>(
                future: _loadMarkdown(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: context.colors.primary,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Failed to load document',
                        style: context.textTheme.bodyMedium,
                      ),
                    );
                  }

                  return Markdown(
                    data: snapshot.data!,
                    selectable: true,
                    styleSheet: _markdownStyle(context),
                    onTapLink: (text, href, title) =>
                        _handleMarkdownLink(context, href),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  MarkdownStyleSheet _markdownStyle(BuildContext context) {
    return MarkdownStyleSheet(
      h1: context.textTheme.headlineLarge,
      h2: context.textTheme.headlineSmall,
      h3: context.textTheme.titleLarge,
      p: context.textTheme.bodyMedium?.variant(context),
      a: context.textTheme.bodyMedium?.copyWith(
        color: context.colors.primary,
        decoration: TextDecoration.underline,
      ),
      codeblockDecoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.outline),
      ),
      codeblockPadding: const EdgeInsets.all(16),
      pPadding: const EdgeInsets.only(bottom: 24),
    );
  }

  Future<void> _handleMarkdownLink(BuildContext context, String? href) async {
    if (href == null) return;

    final uri = Uri.tryParse(href);
    if (uri == null) return;

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
