/// Represents the current state of the async dropdown search.
enum AsyncDropdownState {
  /// Initial state before any search is performed.
  /// Shows [initialItems] if provided, otherwise shows empty prompt.
  initial,

  /// User is typing but debounce timer hasn't fired yet.
  typing,

  /// Search request is in progress.
  loading,

  /// Search completed successfully with results.
  success,

  /// Search completed with no results.
  empty,

  /// Search failed with an error.
  error,
}
