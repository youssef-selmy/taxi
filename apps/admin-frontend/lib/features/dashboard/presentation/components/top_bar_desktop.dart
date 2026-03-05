import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/dark_light_switch.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/language_button.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/profile_dropdown.dart';

class TopBarDesktop extends StatelessWidget {
  const TopBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border(bottom: BorderSide(color: context.colors.outline)),
          ),
          child: BlocBuilder<ConfigBloc, ConfigState>(
            builder: (context, state) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state.config.data?.config?.companyLogo != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 24,
                        right: 10,
                      ),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: state.config.data!.config!.companyLogo!,
                            height: 28,
                            filterQuality: FilterQuality.high,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, size: 28),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            state.config.data!.config!.companyName ?? "",
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                  const Spacer(),
                  const LanguageButton(),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const DarkLightSwitch()],
                  ),
                  // TODO: Add Notifications
                  // const SizedBox(width: 16),
                  // const NotificationButton(),
                  const SizedBox(width: 16),
                  const ProfileDropdown(),
                  const SizedBox(width: 40),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
