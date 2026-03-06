import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'docs.state.dart';
part 'docs.cubit.freezed.dart';

class DocsCubit extends Cubit<DocsState> {
  DocsCubit() : super(const DocsState());

  /// Initialize the docs page and load the default content
  Future<void> onStarted() async {
    await loadPage('welcome');
  }

  /// Load a documentation page by its slug
  Future<void> loadPage(String pageSlug) async {
    emit(state.copyWith(selectedPage: pageSlug, isLoading: true, error: null));

    try {
      final content = await _loadMarkdownContent(pageSlug);
      final headings = _extractHeadings(content);

      emit(
        state.copyWith(
          content: content,
          headings: headings,
          isLoading: false,
          activeHeading: headings.isNotEmpty ? headings.first : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load documentation: $e',
        ),
      );
    }
  }

  /// Update the active heading (for scroll highlighting)
  void setActiveHeading(String heading) {
    emit(state.copyWith(activeHeading: heading));
  }

  /// Load markdown content from assets
  Future<String> _loadMarkdownContent(String pageSlug) async {
    try {
      return await rootBundle.loadString('assets/docs/$pageSlug.md');
    } catch (e) {
      throw Exception('Could not load documentation page: $pageSlug');
    }
  }

  /// Extract H2 and H3 headings from markdown content for the "On This Page" section
  List<String> _extractHeadings(String markdown) {
    final headings = <String>[];
    final lines = markdown.split('\n');

    for (final line in lines) {
      // Match H2 (##) and H3 (###) headings
      if (line.startsWith('## ') || line.startsWith('### ')) {
        final heading = line.replaceFirst(RegExp(r'^#{2,3}\s+'), '').trim();
        if (heading.isNotEmpty) {
          headings.add(heading);
        }
      }
    }

    return headings;
  }
}
