part of 'login_scaffold_template.dart';

extension LoginTemplateDesktop on AppLoginScaffoldTemplate {
  Widget _buildDesktop(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: Center(child: _buildLogin),
    );
  }
}
