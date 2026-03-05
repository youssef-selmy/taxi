import 'package:admin_frontend/core/components/atoms/copyright_notice/copyright_notice.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/components/organisms/license_information_card/available_upgrades_card.dart';
import 'package:admin_frontend/core/components/organisms/license_information_card/license_information_card.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/settings/features/settings_subscription/presentation/blocs/settings_subscription.bloc.dart';
import 'package:admin_frontend/features/settings/presentation/components/settings_page_header.dart';

@RoutePage()
class SettingsSubscriptionScreen extends StatelessWidget {
  const SettingsSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsSubscriptionBloc(),
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          return Column(
            children: [
              SettingsPageHeader(title: context.tr.subscription),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      LicenseInformationCard(license: state.license.data!),
                      const SizedBox(height: 24),
                      if (state.license.data?.availableUpgrades?.isNotEmpty ??
                          false) ...[
                        AvailableUpgradesCard(license: state.license.data!),
                      ],
                      const SizedBox(height: 24),

                      CopyrightNotice(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
