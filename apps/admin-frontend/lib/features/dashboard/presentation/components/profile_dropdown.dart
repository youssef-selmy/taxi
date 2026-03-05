import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/profile.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_icons/better_icons.dart';

class ProfileDropdown extends StatelessWidget {
  const ProfileDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AppProfileButton(
          avatarUrl: state.profile?.media?.address,
          title: state.profile?.fullName,
          subtitle: state.profile?.role?.title,
          statusBadge: state.profile == null
              ? StatusBadgeType.offline
              : StatusBadgeType.online,
          items: [
            AppPopupMenuItem(
              icon: BetterIcons.settings01Outline,
              title: context.tr.settings,
              onPressed: () {
                context.router.push(const SettingsShellRoute());
              },
            ),
            AppPopupMenuItem(
              icon: BetterIcons.logout01Outline,
              title: context.tr.logout,
              color: SemanticColor.error,
              hasDivider: true,
              onPressed: () {
                context.read<AuthBloc>().add(AuthEvent$Logout());
                context.router.replace(const LoginRoute());
              },
            ),
          ],
        );
      },
    );
  }
}
