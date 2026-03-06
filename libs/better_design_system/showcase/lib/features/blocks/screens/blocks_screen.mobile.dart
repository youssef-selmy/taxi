part of 'blocks_screen.dart';

class BlocksScreenMobile extends StatelessWidget {
  const BlocksScreenMobile({
    super.key,
    required this.filteredBlocks,
    required this.onSearchChanged,
  });

  final List<BlocksComponent> filteredBlocks;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceVariantLow,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                children: [
                  BlocksHeader(onSearchChanged: onSearchChanged),
                  Wrap(
                    spacing: 16,
                    children: [
                      ...filteredBlocks.map(
                        (e) => BlocksCard(
                          image: e.image,
                          componentName: e.componentName,
                          blockCount: e.blockCount,
                          route: e.route,
                        ).animate().fadeIn(
                          duration: 700.ms,
                          curve: Curves.easeIn,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
