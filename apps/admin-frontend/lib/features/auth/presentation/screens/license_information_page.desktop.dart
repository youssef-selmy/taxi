part of 'license_information_page.dart';

class LicenseInformationPageDesktop extends StatelessWidget {
  final Fragment$license data;

  const LicenseInformationPageDesktop({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 84, left: 64, right: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAlertBar(text: context.tr.licenseKeyActivated),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: LicenseInformationCard(
                  license: data,
                  onContinue: () {
                    context.router.replaceAll([const DashboardRoute()]);
                  },
                ),
              ),
              if (data.availableUpgrades?.isNotEmpty ?? false) ...[
                Expanded(child: AvailableUpgradesCard(license: data)),
              ],
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
