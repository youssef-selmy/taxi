import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/info_tile/info_tile.dart';
import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail_order_detail_dialog.bloc.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/components/parking_expanded_detail_card.dart';
import 'package:better_icons/better_icons.dart';

class ParkSpotDetailOrderDetailDialog extends StatelessWidget {
  final String orderId;

  const ParkSpotDetailOrderDetailDialog({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkSpotDetailOrderDetailDialogBloc()..onStarted(orderId: orderId),
      child:
          BlocBuilder<
            ParkSpotDetailOrderDetailDialogBloc,
            ParkSpotDetailOrderDetailDialogState
          >(
            builder: (context, state) {
              return AppResponsiveDialog(
                maxWidth: 700,
                icon: BetterIcons.informationCircleFilled,
                title: context.tr.orderDetails,
                primaryButton: AppOutlinedButton(
                  onPressed: () {
                    context.router.popAndPush(
                      ParkingOrderDetailRoute(parkingOrderId: orderId),
                    );
                  },
                  text: context.tr.viewDetails,
                  suffixIcon: BetterIcons.arrowRight02Outline,
                ),
                child: switch (state.orderDetailState) {
                  ApiResponseInitial() => const SizedBox.shrink(),
                  ApiResponseError(:final message) => Center(
                    child: Text(
                      message,
                      style: context.textTheme.bodyMedium?.variant(context),
                    ),
                  ),
                  ApiResponseLoading() => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  ApiResponseLoaded(:final data) => SizedBox(
                    width: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (data.carOwner != null)
                          data.carOwner!.tableView(context, showTitle: true),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            InfoTile(
                              isLoading: false,
                              iconData: BetterIcons.calendar04Filled,
                              data: data.createdAt.formatDateTime,
                            ),
                            const SizedBox(width: 16),
                            InfoTile(
                              isLoading: false,
                              iconData: BetterIcons.calendar04Filled,
                              data:
                                  '${data.enterTime.formatDateTime} | ${data.exitTime.formatDateTime}',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "${context.tr.spotDetails}:",
                          style: context.textTheme.bodyMedium?.variant(context),
                        ),
                        const SizedBox(height: 8),
                        ParkingExpandedDetailCard(
                          item: state.parkSpotDetailState.data!,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "${context.tr.paymentMethod}:",
                          style: context.textTheme.bodyMedium?.variant(context),
                        ),
                        const SizedBox(height: 8),
                        data.paymentMode.tableViewPaymentMethod(
                          context,
                          data.savedPaymentMethod,
                          data.paymentGateway,
                        ),
                      ],
                    ),
                  ),
                },
              );
            },
          ),
    );
  }
}
