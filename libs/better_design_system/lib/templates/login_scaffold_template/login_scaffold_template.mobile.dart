part of 'login_scaffold_template.dart';

extension LoginTemplateMobile on AppLoginScaffoldTemplate {
  Widget _buildMobile(BuildContext context) {
    return SizedBox(width: double.infinity, child: _buildLogin);
  }
}
