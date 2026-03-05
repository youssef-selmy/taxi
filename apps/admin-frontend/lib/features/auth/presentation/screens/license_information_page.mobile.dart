part of 'license_information_page.dart';

class LicenseInformationPageMobile extends StatelessWidget {
  final Fragment$license data;

  const LicenseInformationPageMobile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppAlertBar(text: context.tr.licenseKeyActivated),
            const SizedBox(height: 16),
            LicenseInformationCard(
              license: data,
              onContinue: () {
                context.router.replaceAll([const DashboardRoute()]);
              },
            ),
            if (data.availableUpgrades?.isNotEmpty ?? false) ...[
              const SizedBox(height: 16),
              AvailableUpgradesCard(license: data),
            ],
          ],
        ),
      ),
    );
  }
}
