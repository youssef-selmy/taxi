part of 'platform_overview_screen.dart';

class PlatformOverviewScreenMobile extends StatelessWidget {
  const PlatformOverviewScreenMobile({super.key});

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
                Expanded(child: PlatformOverviewSupportRequestsCard()),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: PlatformOverviewPendingRequestsCard()),
              ],
            ),
            const SizedBox(height: 8),
            Row(children: [Expanded(child: PlatformOverviewCartBarCard())]),
            const SizedBox(height: 24),
            SizedBox(height: 620, child: PlatformOverviewTable()),
          ],
        ),
      ),
    );
  }
}
