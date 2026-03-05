import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';

import 'package:admin_frontend/core/components/organisms/license_information_card/application_item.dart';
import 'package:admin_frontend/core/components/organisms/license_information_card/benefit_item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/gen/assets.gen.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class LicenseInformationCard extends StatelessWidget {
  final Fragment$license license;
  final Function()? onContinue;

  const LicenseInformationCard({
    super.key,
    required this.license,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  context.tr.buyerName,
                  style: context.textTheme.bodyMedium?.variant(context),
                ),
                Text(
                  license.license?.buyerName ?? "-",
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  context.tr.supportExpiryDate,
                  style: context.textTheme.bodyMedium?.variant(context),
                ),
                Text(
                  license.license?.supportExpireDate?.formatDateTime ?? "-",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color:
                        license.license?.supportExpireDate?.isAfter(
                              DateTime.now(),
                            ) ??
                            true
                        ? context.colors.onSurface
                        : context.colors.error,
                  ),
                ),
                if (license.license?.supportExpireDate?.isBefore(
                      DateTime.now(),
                    ) ??
                    false) ...[
                  const SizedBox(width: 4),
                  Text(
                    context.tr.expired,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colors.error,
                    ),
                  ),
                ],
              ],
            ),
            const Divider(height: 48),
            Text(
              context.tr.yourPlanIncludesTheFollowingApps,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ApplicationItem(
              imagePath: Assets.images.taxiSmall.path,
              text: context.tr.taxi,
              isAvailable:
                  license.license?.connectedApps.contains(Enum$AppType.Taxi) ??
                  false,
            ),
            const SizedBox(height: 8),
            ApplicationItem(
              imagePath: Assets.images.shopSmall.path,
              text: context.tr.shop,
              isAvailable:
                  license.license?.connectedApps.contains(Enum$AppType.Shop) ??
                  false,
            ),
            const SizedBox(height: 8),
            ApplicationItem(
              imagePath: Assets.images.parkingSmall.path,
              text: context.tr.parking,
              isAvailable:
                  license.license?.connectedApps.contains(
                    Enum$AppType.Parking,
                  ) ??
                  false,
            ),
            const Divider(height: 48),
            Row(
              children: [
                Icon(
                  BetterIcons.diamond02Filled,
                  color: context.colors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  "${license.license?.licenseType.name} ${context.tr.plan}",
                  style: context.textTheme.headlineMedium,
                ),
              ],
            ),

            const SizedBox(height: 16),
            if (license.benefits != null && license.benefits!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                "${context.tr.benefitsAvailableIn} ${license.license?.licenseType.name} ${context.tr.plan}:",
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              for (final benefit in license.benefits ?? []) ...[
                BenefitItem(text: benefit, isAvailable: true),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 24),
            ],
            if (license.benefits != null && license.drawbacks!.isNotEmpty) ...[
              Text(
                context.tr.featuresThatAreNotAvailableInYourPlan,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              for (final drawback in license.drawbacks ?? []) ...[
                BenefitItem(text: drawback, isAvailable: false),
                const SizedBox(height: 8),
              ],
            ],
            if (onContinue != null)
              Align(
                alignment: Alignment.centerRight,
                child: AppFilledButton(
                  onPressed: onContinue!,
                  text: context.tr.actionContinue,
                  suffixIcon: BetterIcons.arrowRight02Outline,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
