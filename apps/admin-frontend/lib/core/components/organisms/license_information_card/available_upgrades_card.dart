import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/gen/assets.gen.dart';
import 'package:better_icons/better_icons.dart';

class AvailableUpgradesCard extends StatelessWidget {
  final Fragment$license license;

  const AvailableUpgradesCard({super.key, required this.license});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: context.isDark
                ? Assets.images.gradient1.provider()
                : Assets.images.gradient2.provider(),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: context.tr.byUpgradingYourPlan,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: context.tr.youCanAccessToMoreFeatures,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            for (final feature
                in license.availableUpgrades?.firstOrNull?.benefits ?? []) ...[
              Row(
                children: [
                  const Icon(BetterIcons.tick02Filled, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    feature,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  launchUrlString('https://bettersuite.io');
                },
                child: Text(
                  context.tr.upgradePlan,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
