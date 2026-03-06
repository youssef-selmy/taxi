import 'package:better_design_showcase/core/components/app_code_block.dart';
import 'package:better_design_showcase/gen/fonts.gen.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// A component that renders markdown documentation content.
///
/// The [DocsContent] widget displays formatted markdown content with
/// proper styling, syntax highlighting for code blocks, and handles
/// internal navigation links.
///
/// Supports embedding custom widgets within markdown using the syntax:
/// `{{WIDGET:widget_name}}`
///
/// Example:
/// ```markdown
/// # Title
/// Some content...
/// {{WIDGET:button_demo}}
/// More content...
/// ```
class DocsContent extends StatefulWidget {
  /// The markdown content to display.
  final String content;

  /// Optional callback when a heading is tapped.
  /// Used for updating the "On This Page" navigation.
  final void Function(String heading)? onHeadingTap;

  /// Optional callback to receive the scroll-to-heading function.
  final void Function(void Function(String heading))? onScrollToHeading;

  /// Optional callback to build custom widgets embedded in markdown.
  /// Receives the widget name from `{{WIDGET:name}}` pattern.
  final Widget Function(String widgetName)? widgetBuilder;

  /// Optional callback when an internal doc link is tapped.
  /// Receives the page slug (e.g., 'theming', 'installation').
  final void Function(String pageSlug)? onInternalLinkTap;

  /// Creates a [DocsContent] widget.
  const DocsContent({
    super.key,
    required this.content,
    this.onHeadingTap,
    this.onScrollToHeading,
    this.widgetBuilder,
    this.onInternalLinkTap,
  });

  @override
  State<DocsContent> createState() => _DocsContentState();
}

class _DocsContentState extends State<DocsContent> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _headingKeys = {};

  @override
  void initState() {
    super.initState();
    _extractHeadings();
    widget.onScrollToHeading?.call(_scrollToHeading);
  }

  @override
  void didUpdateWidget(DocsContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content != widget.content) {
      _extractHeadings();
      widget.onScrollToHeading?.call(_scrollToHeading);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Extracts headings from markdown and creates keys for them.
  void _extractHeadings() {
    _headingKeys.clear();
    final lines = widget.content.split('\n');
    for (final line in lines) {
      if (line.startsWith('#')) {
        final heading = line.replaceAll(RegExp(r'^#+\s*'), '').trim();
        final key = heading.toLowerCase().replaceAll(' ', '-');
        _headingKeys[key] = GlobalKey();
      }
    }
  }

  /// Scrolls to a specific heading with smooth animation.
  void _scrollToHeading(String heading) {
    final key = heading.toLowerCase().replaceAll(' ', '-');
    final globalKey = _headingKeys[key];

    if (globalKey?.currentContext == null) {
      // If render box not available yet, wait for next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _performScroll(key);
      });
      return;
    }

    _performScroll(key);
  }

  /// Performs the actual scroll animation to the target heading.
  void _performScroll(String key) {
    final globalKey = _headingKeys[key];

    if (globalKey?.currentContext == null || !_scrollController.hasClients) {
      return;
    }

    final renderBox =
        globalKey!.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    // Get the position of the heading relative to the viewport
    final position = renderBox.localToGlobal(Offset.zero);

    // Calculate target scroll position to place heading at top with padding
    // Using 100px padding so the heading is visible with some space from top
    final targetScroll = _scrollController.offset + position.dy - 100;

    // Ensure we don't scroll beyond bounds
    final maxScroll = _scrollController.position.maxScrollExtent;
    final clampedScroll = targetScroll.clamp(0.0, maxScroll);

    _scrollController.animateTo(
      clampedScroll,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  /// Parses markdown content and extracts widget placeholders.
  /// Returns a list of sections alternating between markdown and widgets.
  List<_Section> _parseContentSections() {
    final sections = <_Section>[];
    final pattern = RegExp(r'\{\{WIDGET:(\w+)\}\}');
    final matches = pattern.allMatches(widget.content).toList();

    if (matches.isEmpty) {
      // No widgets, return single markdown section
      return [_MarkdownSection(widget.content)];
    }

    int currentIndex = 0;

    for (final match in matches) {
      // Add markdown section before widget
      if (match.start > currentIndex) {
        final markdownContent =
            widget.content.substring(currentIndex, match.start).trim();
        if (markdownContent.isNotEmpty) {
          sections.add(_MarkdownSection(markdownContent));
        }
      }

      // Add widget section
      final widgetName = match.group(1)!;
      sections.add(_WidgetSection(widgetName));

      currentIndex = match.end;
    }

    // Add remaining markdown after last widget
    if (currentIndex < widget.content.length) {
      final markdownContent = widget.content.substring(currentIndex).trim();
      if (markdownContent.isNotEmpty) {
        sections.add(_MarkdownSection(markdownContent));
      }
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final sections = _parseContentSections();

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 896),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:
              sections.map((section) {
                if (section is _MarkdownSection) {
                  return _buildMarkdownWithKeys(section.content, context);
                } else if (section is _WidgetSection) {
                  // Build custom widget if builder is provided
                  if (widget.widgetBuilder != null) {
                    return widget.widgetBuilder!(section.widgetName);
                  }
                  // Fallback: show placeholder if no builder provided
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Text(
                        '{{WIDGET:${section.widgetName}}}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }).toList(),
        ),
      ),
    );
  }

  /// Builds markdown content with GlobalKeys attached to headings.
  /// Code blocks are extracted and rendered separately with SyntaxView.
  Widget _buildMarkdownWithKeys(String content, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final segments = _parseMarkdownSegments(content);
    final widgetList = <Widget>[];

    for (final segment in segments) {
      switch (segment) {
        case _HeadingSegment(:final text, :final line):
          final key = text.toLowerCase().replaceAll(' ', '-');
          final globalKey = _headingKeys[key];
          if (globalKey != null) {
            widgetList.add(
              Container(
                key: globalKey,
                child: Markdown(
                  padding: EdgeInsets.zero,
                  data: line,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  selectable: true,
                  styleSheet: _buildMarkdownStyleSheet(context),
                  onTapLink:
                      (text, href, title) => _handleLinkTap(context, href),
                ),
              ),
            );
          }
        case _CodeBlockSegment(:final code, :final language):
          widgetList.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppCodeBlock(
                code: code,
                language: language,
                isDarkMode: isDarkMode,
              ),
            ),
          );
        case _MarkdownSegment(:final content):
          if (content.trim().isNotEmpty) {
            widgetList.add(
              Markdown(
                padding: EdgeInsets.zero,
                data: content,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                selectable: true,
                styleSheet: _buildMarkdownStyleSheet(context),
                onTapLink: (text, href, title) => _handleLinkTap(context, href),
              ),
            );
          }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgetList,
    );
  }

  /// Parses markdown content into segments: headings, code blocks, and regular markdown.
  List<_ContentSegment> _parseMarkdownSegments(String content) {
    final segments = <_ContentSegment>[];
    final lines = content.split('\n');
    final buffer = StringBuffer();
    bool insideCodeFence = false;
    String? codeLanguage;
    final codeBuffer = StringBuffer();

    for (final line in lines) {
      final trimmedLine = line.trimLeft();

      // Check for code fence start/end
      if (trimmedLine.startsWith('```') || trimmedLine.startsWith('~~~')) {
        if (!insideCodeFence) {
          // Starting a code block - flush markdown buffer first
          if (buffer.isNotEmpty) {
            segments.add(_MarkdownSegment(buffer.toString()));
            buffer.clear();
          }
          insideCodeFence = true;
          // Extract language from fence (e.g., ```dart -> dart)
          codeLanguage = trimmedLine.substring(3).trim();
          if (codeLanguage.isEmpty) codeLanguage = null;
        } else {
          // Ending a code block
          insideCodeFence = false;
          segments.add(
            _CodeBlockSegment(
              code: codeBuffer.toString().trimRight(),
              language: codeLanguage,
            ),
          );
          codeBuffer.clear();
          codeLanguage = null;
        }
        continue;
      }

      if (insideCodeFence) {
        // Inside code block - add to code buffer
        codeBuffer.writeln(line);
      } else if (line.startsWith('#')) {
        // Heading - flush buffer first
        if (buffer.isNotEmpty) {
          segments.add(_MarkdownSegment(buffer.toString()));
          buffer.clear();
        }
        final headingText = line.replaceAll(RegExp(r'^#+\s*'), '').trim();
        segments.add(_HeadingSegment(text: headingText, line: line));
      } else {
        // Regular markdown content
        buffer.writeln(line);
      }
    }

    // Flush any remaining content
    if (buffer.isNotEmpty) {
      segments.add(_MarkdownSegment(buffer.toString()));
    }

    return segments;
  }

  /// Builds the markdown style sheet based on the app theme.
  MarkdownStyleSheet _buildMarkdownStyleSheet(BuildContext context) {
    return MarkdownStyleSheet(
      // Headings
      h1: context.textTheme.headlineLarge,
      h2: context.textTheme.headlineSmall,
      h3: context.textTheme.titleLarge,
      h4: context.textTheme.titleMedium,
      h5: context.textTheme.titleSmall,
      h6: context.textTheme.labelLarge,

      // Body text
      p: context.textTheme.bodyMedium,

      // Lists
      listBullet: context.textTheme.bodyMedium?.variant(context),
      listBulletPadding: const EdgeInsets.only(right: 8),
      listIndent: 24,

      // Links
      a: context.textTheme.bodyMedium?.copyWith(
        color: context.colors.primary,
        decoration: TextDecoration.underline,
        decorationColor: context.colors.primary.withValues(alpha: 0.5),
      ),

      // Inline code (backticks)
      code: context.textTheme.bodySmall?.copyWith(
        fontFamily: FontFamily.jetBrainsMono,
        color: context.colors.primary,
      ),
      // Code blocks are handled by CodeElementBuilder
      codeblockDecoration: const BoxDecoration(),
      codeblockPadding: EdgeInsets.zero,

      // Blockquotes
      blockquote: context.textTheme.bodyMedium?.copyWith(
        fontStyle: FontStyle.italic,
        color: context.colors.onSurfaceVariant,
      ),
      blockquoteDecoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(4),
        border: Border(
          left: BorderSide(color: context.colors.primary, width: 4),
        ),
      ),
      blockquotePadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      // Horizontal rule
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.outline, width: 1),
        ),
      ),

      // Tables
      tableHead: context.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      tableBody: context.textTheme.bodyMedium,
      tableBorder: TableBorder.all(
        color: context.colors.outline,
        width: 1,
        borderRadius: BorderRadius.circular(8),
      ),
      tableHeadAlign: TextAlign.start,
      tableCellsPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      tableCellsDecoration: const BoxDecoration(),

      // Spacing - Standard markdown conventions
      // h1: Large top margin for clear section separation
      h1Padding: const EdgeInsets.only(top: 32, bottom: 16),
      // h2: Section headers with good separation
      h2Padding: const EdgeInsets.only(top: 32, bottom: 12),
      // h3: Subsection headers
      h3Padding: const EdgeInsets.only(top: 24, bottom: 8),
      // h4-h6: Minor headings
      h4Padding: const EdgeInsets.only(top: 16, bottom: 4),
      h5Padding: const EdgeInsets.only(top: 12, bottom: 4),
      h6Padding: const EdgeInsets.only(top: 8, bottom: 4),
      // Paragraphs
      pPadding: const EdgeInsets.only(bottom: 16),
    );
  }

  /// Handles link taps in the markdown content.
  Future<void> _handleLinkTap(BuildContext context, String? href) async {
    if (href == null) return;

    // Handle internal navigation (e.g., #introduction)
    if (href.startsWith('#')) {
      final heading = href.substring(1);
      widget.onHeadingTap?.call(heading);
      _scrollToHeading(heading);
      return;
    }

    // Handle external URLs
    if (href.startsWith('http://') || href.startsWith('https://')) {
      final uri = Uri.parse(href);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return;
    }

    // Handle internal doc navigation (e.g., installation, theming)
    widget.onInternalLinkTap?.call(href);
  }
}

/// Base class for content sections (markdown or widget).
sealed class _Section {}

/// Represents a markdown content section.
class _MarkdownSection extends _Section {
  final String content;
  _MarkdownSection(this.content);
}

/// Represents an embedded widget section.
class _WidgetSection extends _Section {
  final String widgetName;
  _WidgetSection(this.widgetName);
}

/// Base class for parsed markdown content segments.
sealed class _ContentSegment {}

/// Represents a heading in the markdown.
class _HeadingSegment extends _ContentSegment {
  final String text;
  final String line;
  _HeadingSegment({required this.text, required this.line});
}

/// Represents a fenced code block.
class _CodeBlockSegment extends _ContentSegment {
  final String code;
  final String? language;
  _CodeBlockSegment({required this.code, this.language});
}

/// Represents regular markdown content (not headings or code blocks).
class _MarkdownSegment extends _ContentSegment {
  final String content;
  _MarkdownSegment(this.content);
}
