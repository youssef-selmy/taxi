import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/button/back_button.dart';
import 'package:admin_frontend/core/enums/app_color_scheme.enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/form_container.dart';

class ConfirmationForm extends StatelessWidget {
  const ConfirmationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
        builder: (context, state) {
          return FormContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppBackButton(
                    onPressed: () {
                      context.read<ConfigurerBloc>().goToPage(
                        ConfigurerPage.firebase,
                      );
                    },
                  ),
                ),
                Center(
                  child: Text(
                    context.tr.confirmation,
                    style: context.textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      context.tr.personalInformation,
                      style: context.textTheme.titleMedium?.variant(context),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 24),
                        height: 1.5,
                        color: context.colors.outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (state.profilePicture != null) ...[
                          CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: state.profilePicture!.address,
                            ),
                          ),
                        ],
                        const SizedBox(width: 16),
                        Text(
                          "${state.firstName} ${state.lastName}",
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr.phoneNumber,
                          style: context.textTheme.labelMedium?.variant(
                            context,
                          ),
                        ),
                        Text(
                          state.phoneNumber.$2 ?? "",
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr.email,
                          style: context.textTheme.labelMedium?.variant(
                            context,
                          ),
                        ),
                        Text(state.email, style: context.textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(width: 60),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      context.tr.brandingInformation,
                      style: context.textTheme.titleMedium,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 24),
                        height: 1.5,
                        color: context.colors.outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    if (state.companyLogo != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: state.companyLogo!.address,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    const SizedBox(width: 16),
                    Text(
                      state.companyName,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                if (state.taxiLogo != null) ...[
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: state.taxiLogo!.address,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(state.taxiName, style: context.textTheme.bodyMedium),
                    ],
                  ),
                ],
                if (state.taxiColorPalette != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    context.tr.colorPalette,
                    style: context.textTheme.bodyMedium?.variant(context),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      state.taxiColorPalette!.toBrandColor,
                      const SizedBox(width: 8),
                      Text(
                        state.taxiColorPalette!.title(context),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 32),
                if (state.shopLogo != null) ...[
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: state.shopLogo!.address,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(state.shopName, style: context.textTheme.bodyMedium),
                    ],
                  ),
                ],
                if (state.shopColorPalette != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    context.tr.colorPalette,
                    style: context.textTheme.bodyMedium?.variant(context),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      state.shopColorPalette!.toBrandColor,
                      const SizedBox(width: 8),
                      Text(
                        state.shopColorPalette!.title(context),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 32),
                if (state.parkingLogo != null) ...[
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: state.parkingLogo!.address,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        state.parkingName,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
                if (state.parkingColorPalette != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    context.tr.colorPalette,
                    style: context.textTheme.bodyMedium?.variant(context),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      state.parkingColorPalette!.toBrandColor,
                      const SizedBox(width: 8),
                      Text(
                        state.parkingColorPalette!.title(context),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppFilledButton(
                    onPressed: () {
                      context.read<ConfigurerBloc>().updateConfig();
                    },
                    text: context.tr.done,
                    suffixIcon: BetterIcons.checkmarkCircle02Filled,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
