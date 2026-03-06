part of 'docs_screen.dart';

class DocsScreenDesktop extends StatefulWidget {
  const DocsScreenDesktop({super.key});

  @override
  State<DocsScreenDesktop> createState() => _DocsScreenDesktopState();
}

class _DocsScreenDesktopState extends State<DocsScreenDesktop> {
  void Function(String heading)? _scrollToHeading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocsCubit, DocsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 108),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left sidebar - Main navigation
              const DocsSidebar(),

              // Divider
              Column(
                children: [
                  Expanded(
                    child: Container(width: 1, color: context.colors.outline),
                  ),
                ],
              ),

              // Main content area
              Expanded(child: _buildContent(context, state)),

              // Right sidebar - Table of contents
              Row(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 1,
                          color: context.colors.outline,
                        ),
                      ),
                    ],
                  ),
                  DocsTableOfContents(
                    onHeadingSelected: (heading) {
                      _scrollToHeading?.call(heading);
                      context.read<DocsCubit>().setActiveHeading(heading);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, DocsState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: context.colors.error),
            const SizedBox(height: 16),
            Text(
              state.error!,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.error,
              ),
            ),
          ],
        ),
      );
    }

    if (state.content.isEmpty) {
      return Center(
        child: Text(
          'No content available',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      );
    }

    return DocsContent(
      content: state.content,
      onHeadingTap: (heading) {
        context.read<DocsCubit>().setActiveHeading(heading);
      },
      onScrollToHeading: (scrollFn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _scrollToHeading = scrollFn;
            });
          }
        });
      },
      onInternalLinkTap: (slug) {
        context.read<DocsCubit>().loadPage(slug);
      },
      widgetBuilder: (widgetName) => buildCustomWidget(widgetName, context),
    );
  }
}
