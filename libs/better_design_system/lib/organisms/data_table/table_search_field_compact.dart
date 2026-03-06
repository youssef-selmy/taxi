import 'dart:async';

import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

// No border
class TableSearchFieldCompact extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final String? initialValue;

  const TableSearchFieldCompact({
    super.key,
    required this.hintText,
    this.onChanged,
    this.initialValue,
  });

  @override
  State<TableSearchFieldCompact> createState() =>
      _TableSearchFieldCompactState();
}

class _TableSearchFieldCompactState extends State<TableSearchFieldCompact> {
  late TextEditingController _filter;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _filter = TextEditingController(text: widget.initialValue);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      widget.onChanged?.call(_filter.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      density: TextFieldDensity.dense,
      controller: _filter,
      prefixIcon: const Icon(BetterIcons.search01Filled),
      onChanged: (value) => _onSearchChanged(),
      hint: widget.hintText,
    );
  }
}
