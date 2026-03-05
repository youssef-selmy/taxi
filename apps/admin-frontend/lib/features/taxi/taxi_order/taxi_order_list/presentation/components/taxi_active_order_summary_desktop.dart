import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_method.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/blocs/taxi_orders_list.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/rating_indicator/rating_indicator.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:better_localization/localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:better_design_system/organisms/invoice_card/invoice_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TaxiActiveOrderSummaryDesktop extends StatelessWidget {
  const TaxiActiveOrderSummaryDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrdersListBloc, TaxiOrdersListState>(
      builder: (context, state) {
        final order = state.orderSummaryResponse.data;
        return SizedBox(
          height: 540,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 62,
                child: AppClickableCard(
                  type: ClickableCardType.filled,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              context.tr.orderDetails,
                              style: context.textTheme.titleSmall,
                            ),
                          ),
                          AppTextButton(
                            text: context.tr.viewDetails,
                            size: ButtonSize.medium,
                            color: SemanticColor.primary,
                            suffixIcon: BetterIcons.arrowRight02Outline,
                            onPressed: () {
                              context.router.navigate(
                                TaxiShellRoute(
                                  children: [
                                    TaxiOrderShellRoute(
                                      children: [
                                        TaxiOrderDetailRoute(
                                          orderId: order!.id,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      (order == null && !state.orderSummaryResponse.isLoading)
                          ? SizedBox(
                              height: 450,
                              child: AppEmptyState(
                                image: Assets.images.emptyStates.noRecord,
                                title: "No Active Order",
                              ),
                            )
                          : Expanded(
                              child: Skeletonizer(
                                enabled: state.orderSummaryResponse.isLoading,
                                child: Row(
                                  spacing: 10,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        spacing: 10,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: AppClickableCard(
                                              padding: EdgeInsets.all(0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                      color:
                                                          order?.status ==
                                                              Enum$OrderStatus
                                                                  .Requested
                                                          ? context
                                                                .colors
                                                                .warning
                                                          : context
                                                                .colors
                                                                .success,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            order
                                                                    ?.status
                                                                    .name ??
                                                                "------",
                                                            style: context
                                                                .textTheme
                                                                .labelSmall
                                                                ?.copyWith(
                                                                  color: context
                                                                      .colors
                                                                      .onPrimary,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (order?.driver !=
                                                      null) ...[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            16,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          AppAvatar(
                                                            imageUrl: order
                                                                ?.driver
                                                                ?.imageUrl,
                                                            size: AvatarSize
                                                                .size40px,
                                                            shape: AvatarShape
                                                                .rounded,
                                                          ),
                                                          SizedBox(width: 8),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              spacing: 2,
                                                              children: [
                                                                Text(
                                                                  order
                                                                          ?.driver
                                                                          ?.fullName ??
                                                                      "--------",
                                                                  style: context
                                                                      .textTheme
                                                                      .labelLarge,
                                                                ),
                                                                AppRatingIndicator(
                                                                  rating:
                                                                      order?.driver?.rating ==
                                                                          null
                                                                      ? null
                                                                      : (order!.driver!.rating!) /
                                                                            20,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          AppIconButton(
                                                            icon: BetterIcons
                                                                .call02Filled,
                                                            size: ButtonSize
                                                                .medium,
                                                            style:
                                                                IconButtonStyle
                                                                    .outline,
                                                            onPressed: () {
                                                              launchUrlString(
                                                                'tel:+${order?.driver?.mobileNumber}',
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              [
                                                                order
                                                                    ?.driver
                                                                    ?.vehicleModel,
                                                                order
                                                                    ?.driver
                                                                    ?.vehicleColor,
                                                              ].nonNulls.join(
                                                                " - ",
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4,
                                                                ),
                                                            decoration:
                                                                BoxDecoration(
                                                                  border:
                                                                      kBorder(
                                                                        context,
                                                                      ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                ),
                                                            child: Text(
                                                              order
                                                                      ?.driver
                                                                      ?.vehiclePlate ??
                                                                  "------",
                                                              style: context
                                                                  .textTheme
                                                                  .labelMedium,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                          ),
                                                      child: AppDivider(
                                                        height: 16,
                                                      ),
                                                    ),
                                                    if (order?.scheduledAt !=
                                                        null) ...[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                            ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Scheduled For:",
                                                                style: context
                                                                    .textTheme
                                                                    .bodySmall
                                                                    ?.variant(
                                                                      context,
                                                                    ),
                                                              ),
                                                            ),
                                                            Text(
                                                              order
                                                                      ?.scheduledAt
                                                                      ?.formatTime ??
                                                                  "-----------",
                                                              style: context
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                    ],
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "Pickup ETA:",
                                                              style: context
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.variant(
                                                                    context,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            order
                                                                    ?.pickupEta
                                                                    ?.formatTime ??
                                                                "-----------",
                                                            style: context
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "Drop-Off ETA:",
                                                              style: context
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.variant(
                                                                    context,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            order
                                                                    ?.dropoffEta
                                                                    ?.formatTime ??
                                                                "-----------",
                                                            style: context
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ] else ...[
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                BetterIcons
                                                                    .loading03Outline,
                                                                color: context
                                                                    .colors
                                                                    .onSurfaceVariant,
                                                              ),
                                                              Text(
                                                                "Driver not assigned yet",
                                                                style: context
                                                                    .textTheme
                                                                    .labelMedium
                                                                    ?.variant(
                                                                      context,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                          AppTag(
                                                            text:
                                                                "Sent to ${order?.driversSentTo ?? 0} Drivers",
                                                            color: SemanticColor
                                                                .neutral,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: AppClickableCard(
                                              child: Column(
                                                children: [
                                                  _userProfile(
                                                    context: context,
                                                    fullName:
                                                        order?.rider.fullName ??
                                                        "------",
                                                    caption: context.tr.rider,
                                                    imageUrl:
                                                        order?.rider.imageUrl,
                                                    mobileNumber:
                                                        order
                                                            ?.rider
                                                            .mobileNumber ??
                                                        "0000000000",
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(
                                                          6,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                          border: kBorder(
                                                            context,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          order
                                                              ?.paymentMethod
                                                              .entity
                                                              .iconData,
                                                          color: context
                                                              .colors
                                                              .primary,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Text(
                                                        order
                                                                ?.paymentMethod
                                                                .entity
                                                                .title ??
                                                            "------",
                                                        style: context
                                                            .textTheme
                                                            .labelMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: AppClickableCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${context.tr.dateAndTime}:",
                                                    style: context
                                                        .textTheme
                                                        .bodySmall
                                                        ?.variant(context),
                                                  ),
                                                ),
                                                Text(
                                                  order
                                                          ?.createdAt
                                                          .formatDateTime ??
                                                      "-----------",
                                                  style: context
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                if (order?.service.imageUrl !=
                                                    null)
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        order!.service.imageUrl,
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    order?.service.name ??
                                                        "-----",
                                                    style: context
                                                        .textTheme
                                                        .labelLarge,
                                                  ),
                                                ),
                                                Text(
                                                  order?.totalCost
                                                          .formatCompactCurrency(
                                                            order.currency,
                                                          ) ??
                                                      "-----",
                                                  style: context
                                                      .textTheme
                                                      .labelLarge,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            ?order?.waypoints.toWaypointsView(
                                              context,
                                            ),
                                            Spacer(),
                                            const AppDivider(height: 16),
                                            AppInvoiceCard(
                                              borderLess: true,
                                              currency:
                                                  order?.currency ??
                                                  Env.defaultCurrency,
                                              items: [
                                                InvoiceItem(
                                                  title: "Taxi Fare",
                                                  amount: order?.totalCost ?? 0,
                                                ),
                                                InvoiceItem(
                                                  title: "Coupon Discount",
                                                  amount:
                                                      -(order?.couponDiscount ??
                                                          0),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 47,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AppGenericMap(
                    padding: EdgeInsets.all(64),
                    markers: [
                      ...state.orderSummaryResponse.data?.waypoints.markers ??
                          [],
                      ?state.orderSummaryResponse.data?.driver?.location
                          ?.driverMarker(
                            state
                                    .orderSummaryResponse
                                    .data
                                    ?.driver
                                    ?.mobileNumber ??
                                'driver',
                          ),
                    ],
                    onControllerReady: (controller) {
                      context.read<TaxiOrdersListBloc>().add(
                        TaxiOrdersListEvent.mapViewControllerChanged(
                          controller,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _userProfile({
    required BuildContext context,
    required String fullName,
    required String caption,
    required String? imageUrl,
    required String mobileNumber,
  }) {
    return Row(
      children: [
        AppAvatar(
          imageUrl: imageUrl,
          size: AvatarSize.size40px,
          shape: AvatarShape.rounded,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                caption,
                style: context.textTheme.labelSmall?.variant(context),
              ),
              Text(fullName, style: context.textTheme.labelLarge),
            ],
          ),
        ),
        AppIconButton(
          icon: BetterIcons.call02Filled,
          size: ButtonSize.medium,
          style: IconButtonStyle.outline,
          onPressed: () {
            launchUrlString('tel:+$mobileNumber');
          },
        ),
      ],
    );
  }
}
