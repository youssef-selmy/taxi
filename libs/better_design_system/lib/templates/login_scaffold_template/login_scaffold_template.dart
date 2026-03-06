import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'models/login_page.dart';
export 'models/login_page.dart';

part 'login_scaffold_template.mobile.dart';
part 'login_scaffold_template.desktop.dart';

typedef BetterLoginScaffoldTemplate = AppLoginScaffoldTemplate;

class AppLoginScaffoldTemplate<T> extends StatelessWidget {
  final List<LoginScreen<T>> screens;
  final T selectedPage;

  final bool isDesktop;

  const AppLoginScaffoldTemplate({
    super.key,
    required this.screens,
    required this.selectedPage,
    required this.isDesktop,
    // this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: isDesktop ? _buildDesktop(context) : _buildMobile(context),
    );
  }

  Widget get _buildLogin {
    return screens.firstWhere((page) => page.model == selectedPage).child;
  }
}
