part of 'data_table.dart';

class TableSortOptions<T> {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) labelBuilder;
  final void Function(List<T>)? onChanged;
  final double overlayWidth;

  TableSortOptions({
    required this.items,
    required this.selectedItems,
    required this.labelBuilder,
    required this.onChanged,
    this.overlayWidth = 200,
  });
}
