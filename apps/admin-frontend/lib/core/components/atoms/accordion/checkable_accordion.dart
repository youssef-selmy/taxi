import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class CheckableAccordion extends StatefulWidget {
  final bool defaultValue;
  final Function(bool) onChanged;
  final String title;
  final IconData iconData;
  final Widget child;

  const CheckableAccordion({
    super.key,
    this.defaultValue = false,
    required this.onChanged,
    required this.title,
    required this.iconData,
    required this.child,
  });
  @override
  State<CheckableAccordion> createState() => _CheckableAccordionState();
}

class _CheckableAccordionState extends State<CheckableAccordion> {
  late bool value;

  @override
  void initState() {
    value = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (val) {
                setState(() {
                  value = !value;
                  widget.onChanged(value);
                });
              },
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colors.primaryContainer,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: context.colors.primary),
              ),
              child: Icon(widget.iconData, color: context.colors.primary),
            ),
            const SizedBox(width: 16),
            Text(widget.title, style: context.textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 24),
        Visibility(visible: value, child: widget.child),
      ],
    );
  }
}
