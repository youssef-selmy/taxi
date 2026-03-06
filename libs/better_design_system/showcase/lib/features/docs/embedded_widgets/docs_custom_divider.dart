import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:flutter/material.dart';

class DocsCustomDivider extends StatefulWidget {
  const DocsCustomDivider({super.key});

  @override
  State<DocsCustomDivider> createState() => _DocsCustomDividerState();
}

class _DocsCustomDividerState extends State<DocsCustomDivider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: AppDivider(height: 20),
    );
  }
}
