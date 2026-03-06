part of 'docs.cubit.dart';

@freezed
sealed class DocsState with _$DocsState {
  const factory DocsState({
    /// The currently selected documentation page
    @Default('welcome') String selectedPage,

    /// The markdown content of the selected page
    @Default('') String content,

    /// Whether the content is currently loading
    @Default(false) bool isLoading,

    /// Error message if content failed to load
    String? error,

    /// List of headings extracted from the current page (for "On This Page" navigation)
    @Default([]) List<String> headings,

    /// Currently active heading (for scroll highlighting)
    String? activeHeading,
  }) = _DocsState;
}
