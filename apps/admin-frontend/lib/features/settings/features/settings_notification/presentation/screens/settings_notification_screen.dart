import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/settings/features/settings_notification/presentation/blocs/settings_notification.bloc.dart';
import 'package:admin_frontend/features/settings/presentation/components/setting_switch_item.dart';
import 'package:admin_frontend/features/settings/presentation/components/settings_page_header.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class SettingsNotificationScreen extends StatelessWidget {
  const SettingsNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsNotificationBloc()..onStarted(),
      child: BlocBuilder<SettingsNotificationBloc, SettingsNotificationState>(
        builder: (context, state) {
          return Column(
            children: [
              SettingsPageHeader(title: context.tr.notifications, actions: []),
              SettingSwitchItem(
                title: context.tr.sosRequests,
                subtitle: context.tr.receiveSosNotifications,
                value: state.isNotificationEnabled(
                  Enum$EnabledNotification.SOS,
                ),
                onChanged: (value) => context
                    .read<SettingsNotificationBloc>()
                    .changeNotificationSetting(
                      Enum$EnabledNotification.SOS,
                      value,
                    ),
              ),
              SettingSwitchItem(
                title: context.tr.supportRequests,
                subtitle: context.tr.receiveSupportNotifications,
                value: state.isNotificationEnabled(
                  Enum$EnabledNotification.SupportRequest,
                ),
                onChanged: (value) => context
                    .read<SettingsNotificationBloc>()
                    .changeNotificationSetting(
                      Enum$EnabledNotification.SupportRequest,
                      value,
                    ),
              ),
              SettingSwitchItem(
                title: context.tr.newPendingVerificationUsers,
                subtitle: context.tr.receiveNewUserNotifications,
                value: state.isNotificationEnabled(
                  Enum$EnabledNotification.UserPendingVerification,
                ),
                onChanged: (value) => context
                    .read<SettingsNotificationBloc>()
                    .changeNotificationSetting(
                      Enum$EnabledNotification.UserPendingVerification,
                      value,
                    ),
              ),
              SettingSwitchItem(
                title: context.tr.newOrders,
                subtitle: context.tr.receiveOrderNotifications,
                value: state.isNotificationEnabled(
                  Enum$EnabledNotification.NewOrder,
                ),
                onChanged: (value) => context
                    .read<SettingsNotificationBloc>()
                    .changeNotificationSetting(
                      Enum$EnabledNotification.NewOrder,
                      value,
                    ),
              ),
            ].separated(separator: const SizedBox(height: 16)),
          );
        },
      ),
    );
  }
}
