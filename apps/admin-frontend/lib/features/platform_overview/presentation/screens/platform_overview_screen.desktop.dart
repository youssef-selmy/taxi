part of 'platform_overview_screen.dart';

class PlatformOverviewScreenDesktop extends StatelessWidget {
  const PlatformOverviewScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      child: SingleChildScrollView(
        padding: context.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlatformOverviewHeader(),
            const SizedBox(height: 24),
            PlatformOverviewTopStatCards(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PlatformOverviewSupportRequestsCard(),
                      PlatformOverviewPendingRequestsCard(),
                    ],
                  ),
                ),
                Expanded(flex: 3, child: PlatformOverviewCartBarCard()),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(height: 620, child: PlatformOverviewTable()),
            const SizedBox(height: 80),
            Center(child: CopyrightNotice()),
          ],
        ),
      ),
    );
  }
}
