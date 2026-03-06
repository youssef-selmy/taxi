import 'package:better_design_showcase/gen/fonts.gen.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

/// A reusable code block widget with syntax highlighting and copy functionality.
///
/// Uses flutter_syntax_view's syntax highlighter with custom font rendering
/// to support JetBrains Mono font (the SyntaxView widget hardcodes 'monospace').
///
/// Can be used in two modes:
/// - **Compact mode** (default): Shows header with language label and copy button
/// - **Expanded mode**: Full height with line numbers, suitable for preview components
class AppCodeBlock extends StatelessWidget {
  const AppCodeBlock({
    super.key,
    required this.code,
    this.language,
    this.isDarkMode = false,
    this.showHeader = true,
    this.showLineNumbers = false,
    this.maxHeight,
    this.expanded = false,
  });

  /// The source code to display.
  final String code;

  /// The programming language for syntax highlighting.
  /// Supports: dart, javascript, java, kotlin, swift, python, c, cpp, yaml.
  final String? language;

  /// Whether to use dark theme colors.
  final bool isDarkMode;

  /// Whether to show the header with language label and copy button.
  final bool showHeader;

  /// Whether to show line numbers on the left.
  final bool showLineNumbers;

  /// Maximum height constraint for the code block.
  final double? maxHeight;

  /// Whether the code block should expand to fill available space.
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDarkMode
            ? const Color(0xFF1E1E1E) // VS Code dark background
            : context.colors.surface;

    final content = _buildContent(context);

    return Container(
      constraints:
          maxHeight != null ? BoxConstraints(maxHeight: maxHeight!) : null,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colors.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (showHeader) _buildHeader(context),
          if (expanded) Expanded(child: content) else content,
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final hasLanguage = language != null && language!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? const Color(0xFF1E1E1E)
                : context.colors.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasLanguage)
            Text(
              _formatLanguageName(language!),
              style: context.textTheme.labelSmall?.copyWith(
                color:
                    isDarkMode
                        ? Colors.white70
                        : context.colors.onSurfaceVariant,
              ),
            )
          else
            const SizedBox.shrink(),
          _CopyButton(code: code, isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final syntaxTheme =
        isDarkMode ? SyntaxTheme.vscodeDark() : SyntaxTheme.vscodeLight();

    final syntax = _mapLanguageToSyntax(language);
    final highlighter = _getSyntaxHighlighter(syntax, syntaxTheme);
    final highlightedSpan = highlighter.format(code);

    final baseStyle = context.textTheme.bodyMedium!.copyWith(
      fontFamily: FontFamily.jetBrainsMono,
      fontSize: 14,
      height: 1.5,
      color:
          syntaxTheme.baseStyle?.color ??
          (isDarkMode ? Colors.white : Colors.black),
    );

    final borderRadius = BorderRadius.only(
      bottomLeft: const Radius.circular(7),
      bottomRight: const Radius.circular(7),
      topLeft: showHeader ? Radius.zero : const Radius.circular(7),
      topRight: showHeader ? Radius.zero : const Radius.circular(7),
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        color: syntaxTheme.backgroundColor,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:
                showLineNumbers
                    ? _buildCodeWithLineNumbers(
                      context,
                      baseStyle,
                      highlightedSpan,
                      syntaxTheme,
                    )
                    : SelectableText.rich(
                      TextSpan(style: baseStyle, children: [highlightedSpan]),
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeWithLineNumbers(
    BuildContext context,
    TextStyle baseStyle,
    TextSpan highlightedSpan,
    SyntaxTheme syntaxTheme,
  ) {
    final lines = code.split('\n');
    final lineNumberStyle = baseStyle.copyWith(
      color:
          isDarkMode
              ? Colors.white38
              : context.colors.onSurfaceVariant.withValues(alpha: 0.5),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Line numbers
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (int i = 1; i <= lines.length; i++)
              Text('$i', style: lineNumberStyle),
          ],
        ),
        const SizedBox(width: 16),
        // Code content
        SelectableText.rich(
          TextSpan(style: baseStyle, children: [highlightedSpan]),
        ),
      ],
    );
  }

  SyntaxBase _getSyntaxHighlighter(Syntax syntax, SyntaxTheme theme) =>
      switch (syntax) {
        Syntax.DART => DartSyntaxHighlighter(theme),
        Syntax.C => CSyntaxHighlighter(theme),
        Syntax.CPP => CPPSyntaxHighlighter(theme),
        Syntax.JAVA => JavaSyntaxHighlighter(theme),
        Syntax.KOTLIN => KotlinSyntaxHighlighter(theme),
        Syntax.SWIFT => SwiftSyntaxHighlighter(theme),
        Syntax.JAVASCRIPT => JavaScriptSyntaxHighlighter(theme),
        Syntax.YAML => YamlSyntaxHighlighter(theme),
        Syntax.RUST => RustSyntaxHighlighter(theme),
        Syntax.LUA => LuaSyntaxHighlighter(theme),
        Syntax.PYTHON => PythonSyntaxHighlighter(theme),
      };

  Syntax _mapLanguageToSyntax(String? language) => switch (language
      ?.toLowerCase()) {
    'dart' => Syntax.DART,
    'javascript' || 'js' => Syntax.JAVASCRIPT,
    'java' => Syntax.JAVA,
    'kotlin' || 'kt' => Syntax.KOTLIN,
    'swift' => Syntax.SWIFT,
    'python' || 'py' => Syntax.PYTHON,
    'c' => Syntax.C,
    'cpp' || 'c++' => Syntax.CPP,
    'yaml' || 'yml' => Syntax.YAML,
    _ => Syntax.DART,
  };

  String _formatLanguageName(String language) => switch (language
      .toLowerCase()) {
    'dart' => 'Dart',
    'javascript' || 'js' => 'JavaScript',
    'typescript' || 'ts' => 'TypeScript',
    'python' || 'py' => 'Python',
    'java' => 'Java',
    'kotlin' || 'kt' => 'Kotlin',
    'swift' => 'Swift',
    'rust' || 'rs' => 'Rust',
    'go' => 'Go',
    'c' => 'C',
    'cpp' || 'c++' => 'C++',
    'csharp' || 'c#' || 'cs' => 'C#',
    'ruby' || 'rb' => 'Ruby',
    'php' => 'PHP',
    'html' => 'HTML',
    'css' => 'CSS',
    'scss' || 'sass' => 'SCSS',
    'json' => 'JSON',
    'yaml' || 'yml' => 'YAML',
    'xml' => 'XML',
    'sql' => 'SQL',
    'bash' || 'sh' || 'shell' => 'Bash',
    'markdown' || 'md' => 'Markdown',
    _ => language.toUpperCase(),
  };
}

class _CopyButton extends StatefulWidget {
  const _CopyButton({required this.code, required this.isDarkMode});

  final String code;
  final bool isDarkMode;

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _copied = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _copyToClipboard,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _copied ? Icons.check : Icons.copy_outlined,
              size: 14,
              color:
                  _copied
                      ? context.colors.success
                      : (widget.isDarkMode
                          ? Colors.white70
                          : context.colors.onSurfaceVariant),
            ),
            const SizedBox(width: 4),
            Text(
              _copied ? 'Copied!' : 'Copy',
              style: context.textTheme.labelSmall?.copyWith(
                color:
                    _copied
                        ? context.colors.success
                        : (widget.isDarkMode
                            ? Colors.white70
                            : context.colors.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
