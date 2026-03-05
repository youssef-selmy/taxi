import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/dropdown_status.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/enums/sos_status_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/sos/features/sos_detail/presentation/blocs/sos_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SosDetailBox extends StatelessWidget {
  const SosDetailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: kBorder(context),
        boxShadow: kElevation1(context),
        color: context.colors.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: [
                Expanded(child: SosDetailContent()),
                SizedBox(width: 32),
                Expanded(child: SosOrderContent()),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            Text(context.tr.comment, style: context.textTheme.titleMedium),
            const SizedBox(height: 10),
            BlocBuilder<SosDetailBloc, SosDetailState>(
              builder: (context, state) {
                final distressSignal = state.distressSignalDetail.data;
                return Skeletonizer(
                  enabled: state.distressSignalDetail.isLoading,
                  child: Text(
                    distressSignal?.comment ?? context.tr.noComment,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SosDetailContent extends StatelessWidget {
  const SosDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SosDetailBloc, SosDetailState>(
      builder: (context, state) {
        final distressSignal = state.distressSignalDetail.data;
        return switch (state.distressSignalDetail) {
          ApiResponseLoaded() || ApiResponseLoading() => Skeletonizer(
            enabled: state.distressSignalDetail.isLoading,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      context.tr.details,
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: <Widget>[
                    Text(
                      context.tr.dateAndTime,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const Spacer(),
                    Text(
                      distressSignal?.createdAt.formatDateTime ?? "---",
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: <Widget>[
                    Text(
                      context.tr.status,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const Spacer(),
                    AppDropdownStatus(
                      initialValue: distressSignal?.status,
                      onChanged: context.read<SosDetailBloc>().onStatusChanged,
                      items: Enum$SOSStatus.values
                          .where((e) => e != Enum$SOSStatus.$unknown)
                          .map(
                            (e) => DropDownStatusItem(
                              value: e,
                              text: e.name(context),
                              chipType: e.chipType,
                              icon: e.icon,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: <Widget>[
                    Text(
                      context.tr.reason,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const Spacer(),
                    Text(
                      distressSignal?.reason?.name ?? '',
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ApiResponseError(:final message) => Center(child: Text(message)),
          ApiResponseInitial() => const SizedBox(),
        };
      },
    );
  }
}

class SosOrderContent extends StatelessWidget {
  const SosOrderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SosDetailBloc, SosDetailState>(
      builder: (context, state) {
        final distressSignal = state.distressSignalDetail.data;
        return Skeletonizer(
          enabled: state.distressSignalDetail.isLoading,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(context.tr.orders, style: context.textTheme.bodyMedium),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.navigateTo(
                        TaxiShellRoute(
                          children: [
                            TaxiOrderShellRoute(
                              children: [
                                TaxiOrderDetailRoute(
                                  orderId: distressSignal!.order.id,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          context.tr.orderDetails,
                          style: context.textTheme.labelMedium?.apply(
                            color: context.colors.primary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          BetterIcons.arrowRight02Outline,
                          color: context.colors.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      AppAvatar(
                        imageUrl: distressSignal?.order.rider?.media?.address,
                        size: AvatarSize.size32px,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            context.tr.rider,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                          Text(
                            distressSignal?.order.rider?.fullName ?? '',
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppLinkButton(
                    text:
                        distressSignal?.order.rider?.mobileNumber
                            .formatPhoneNumber(null) ??
                        "---",
                    onPressed: () {
                      launchUrlString(
                        "tel:+${distressSignal?.order.rider?.mobileNumber}",
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      AppAvatar(
                        imageUrl: distressSignal?.order.driver?.media?.address,
                        size: AvatarSize.size32px,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            context.tr.driver,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                          Text(
                            distressSignal?.order.driver?.fullName ?? '',
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppLinkButton(
                    text:
                        distressSignal?.order.driver!.mobileNumber
                            .formatPhoneNumber(null) ??
                        "----",
                    onPressed: () {
                      launchUrlString(
                        "tel:+${distressSignal?.order.driver!.mobileNumber}",
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
