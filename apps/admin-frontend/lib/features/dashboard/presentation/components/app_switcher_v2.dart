import 'package:admin_frontend/config/env.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/popup_menu_button/popup_menu_button.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class AppSwitcherV2 extends StatelessWidget {
  final bool isCollapsed;
  const AppSwitcherV2({super.key, this.isCollapsed = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, stateAuth) {
            if (!stateAuth.isAuthenticated) {
              return const SizedBox();
            }
            final selectedAppConfig = state.appConfig(
              stateAuth.selectedAppType,
            );
            return Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  if (selectedAppConfig.logo != null)
                    CachedNetworkImage(
                      imageUrl: selectedAppConfig.logo!,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 32,
                        color: context.colors.error,
                      ),
                    ),
                  if (!isCollapsed)
                    Expanded(
                      child: Text(
                        selectedAppConfig.name ?? "Admin Panel",
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  if (state.enabledApps.length > 1 || Env.showCentralHub)
                    AppPopupMenuButton(
                      dropdownWidth: 200,
                      showArrow: false,
                      items: [
                        ...state.enabledApps.map((app) {
                          return AppPopupMenuItem(
                            title: state.appConfig(app).name ?? app.name,
                            prefix: state.appConfig(app).logo != null
                                ? CachedNetworkImage(
                                    imageUrl: state.appConfig(app).logo!,
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 24,
                                      color: context.colors.error,
                                    ),
                                  )
                                : null,
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                AuthEvent.changeAppType(app),
                              );
                            },
                          );
                        }),
                        if (Env.showCentralHub)
                          AppPopupMenuItem(
                            title: "Suite Hub",
                            prefix:
                                state.config.data?.config?.companyLogo != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        state.config.data!.config!.companyLogo!,
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 24,
                                      color: context.colors.error,
                                    ),
                                  )
                                : null,
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                AuthEvent.changeAppType(null),
                              );
                            },
                          ),
                      ],
                      childBuilder: (onPressed) => AppIconButton(
                        icon: BetterIcons.arrowDown01Outline,
                        size: ButtonSize.small,
                        style: IconButtonStyle.outline,
                        onPressed: onPressed,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
