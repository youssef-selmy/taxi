import 'package:admin_frontend/core/features/view_on_map_dialog/view_on_map_dialog.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/blocs/parking_order_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ParkingOrderDetailCustomerDetail extends StatelessWidget {
  const ParkingOrderDetailCustomerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOrderDetailBloc, ParkingOrderDetailState>(
      builder: (context, state) {
        final parkingOrder = state.parkingOrderDetailState.data;
        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Skeletonizer(
            enabled: state.parkingOrderDetailState.isLoading,
            enableSwitchAnimation: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: LargeHeader(title: context.tr.customersParkingDetails),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                context.tr.customer,
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  AppAvatar(
                                    imageUrl:
                                        parkingOrder?.carOwner?.media?.address,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    parkingOrder?.carOwner?.fullName ??
                                        context.tr.unknown,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    BetterIcons.call02Filled,
                                    color: context.colors.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse(
                                          'tel:+${parkingOrder?.carOwner?.mobileNumber}',
                                        ),
                                      );
                                    },
                                    minimumSize: Size(0, 0),
                                    child: Text(
                                      parkingOrder?.carOwner?.mobileNumber
                                              .formatPhoneNumber(
                                                parkingOrder
                                                    .carOwner
                                                    ?.countryIso,
                                              ) ??
                                          '',
                                      style: context.textTheme.labelMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 1),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  context.tr.spot,
                                  style: context.textTheme.labelMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                parkingOrder?.parkSpot.tableView(context) ??
                                    const SizedBox(),
                                // Row(
                                //   children: <Widget>[
                                //     AppAvatar(imageUrl: parkingOrder?.parkSpot.mainImage?.address),
                                //     const SizedBox(width: 8),
                                //     Text(
                                //       parkingOrder?.parkSpot.name ?? '',
                                //       style: context.textTheme.bodyMedium,
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(height: 16),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      BetterIcons.gps01Filled,
                                      color: context.colors.primary,
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context.tr.location,
                                          style: context.textTheme.bodyMedium,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          parkingOrder?.parkSpot.address ?? '',
                                          style: context.textTheme.labelMedium
                                              ?.variant(context),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      BetterIcons.call02Filled,
                                      color: context.colors.primary,
                                    ),
                                    const SizedBox(width: 8),
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        launchUrl(
                                          Uri.parse(
                                            'tel:${parkingOrder?.parkSpot.phoneNumber}',
                                          ),
                                        );
                                      },
                                      minimumSize: Size(0, 0),
                                      child: Text(
                                        parkingOrder?.parkSpot.phoneNumber
                                                ?.formatPhoneNumber(null) ??
                                            '',
                                        style: context.textTheme.labelMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          AppTextButton(
                            text: context.tr.viewOnMap,
                            size: ButtonSize.small,
                            suffixIcon: BetterIcons.arrowRight02Outline,
                            onPressed: () {
                              showDialog(
                                context: context,
                                useSafeArea: false,
                                builder: (context) {
                                  return ViewOnMapDialog(
                                    latLng: parkingOrder!.parkSpot.location
                                        .toLatLngLib(),
                                    title: parkingOrder.parkSpot.name,
                                    subtitle: parkingOrder.parkSpot.address,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
