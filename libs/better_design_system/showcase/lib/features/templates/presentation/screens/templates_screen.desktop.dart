part of 'templates_screen.dart';

class TemplatesScreenDesktop extends StatefulWidget {
  const TemplatesScreenDesktop({super.key});

  @override
  State<TemplatesScreenDesktop> createState() => _TemplatesScreenDesktopState();
}

class _TemplatesScreenDesktopState extends State<TemplatesScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceVariantLow,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Padding(
                    padding: const EdgeInsets.fromLTRB(108, 40, 108, 48),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: context.colors.surface,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: context.colors.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Templates',
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        color: context.colors.onSurfaceVariant,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 484,
                          child: Column(
                            children: [
                              Text(
                                'Product Templates',
                                style: context.textTheme.displayLarge,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Explore a variety of pre-designed templates to kickstart your next product with ease.',
                                style: context.textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fade(delay: 300.ms)
                  .slideY(curve: Curves.easeIn, begin: -0.5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: StaggeredGrid.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 24,
                  children: [
                    AppEcommerceList(),
                    AppFintechList(),
                    AppHrPlatformList(),
                    AppSalesMarketingList(),
                  ],
                ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
              ),
              const SizedBox(height: 40),
              AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
