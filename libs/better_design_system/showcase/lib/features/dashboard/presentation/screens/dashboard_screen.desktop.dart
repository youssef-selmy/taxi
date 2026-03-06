part of 'dashboard_screen.dart';

class DashboardScreenDesktop extends StatelessWidget {
  const DashboardScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [AppHeader(), Expanded(child: AutoRouter())]);
  }
}
