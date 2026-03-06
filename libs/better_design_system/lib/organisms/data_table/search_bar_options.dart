part of 'data_table.dart';

class TableSearchBarOptions {
  final bool enabled;
  final String? query;
  final String? hintText;
  final Function(String)? onChanged;
  final bool isCompact;

  const TableSearchBarOptions({
    this.enabled = true,
    this.hintText,
    this.query,
    this.onChanged,
    this.isCompact = false,
  });
}
