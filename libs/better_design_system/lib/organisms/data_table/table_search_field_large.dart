import 'dart:async';

import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

// No border
class TableSearchFieldLarge extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final String? initialValue;

  const TableSearchFieldLarge({
    super.key,
    required this.hintText,
    this.onChanged,
    this.initialValue,
  });

  @override
  State<TableSearchFieldLarge> createState() => _TableSearchFieldLargeState();
}

class _TableSearchFieldLargeState extends State<TableSearchFieldLarge> {
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
    return TextField(
      controller: _filter,
      onChanged: (value) => _onSearchChanged(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(BetterIcons.search01Filled),
        fillColor: context.colors.transparent,
        filled: false,
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
