import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/components/taxi_order_detail_tab_bar.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/components/taxi_order_ride_detail_map.dart';
import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/blocs/taxi_order_detail.bloc.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/components/taxi_order_customer_and_driver.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/components/taxi_order_ride_detail.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/components/taxi_order_ride_histories.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_chat_histories/presentation/screens/taxi_order_detail_chat_histories_screen.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/presentation/screens/taxi_order_detail_complaints_screen.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/presentation/blocs/taxi_order_detail_notes.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_notes/presentation/screens/taxi_order_detail_notes_screen.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/presentation/screens/taxi_order_detail_reviews_screen.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_transactions/presentation/screens/taxi_order_detail_transactions_screen.dart';

part 'taxi_order_detail_archive.desktop.dart';
part 'taxi_order_detail_archive.mobile.dart';
part 'taxi_order_detail_active.desktop.dart';
part 'taxi_order_detail_active.mobile.dart';

@RoutePage()
class TaxiOrderDetailScreen extends StatelessWidget {
  const TaxiOrderDetailScreen({
    super.key,
    @PathParam('orderId') required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TaxiOrderDetailBloc()..onStarted(orderId: orderId),
        ),
        BlocProvider(
          create: (context) => TaxiOrderDetailNotesBloc()..onStarted(orderId),
        ),
      ],
      child: BlocBuilder<TaxiOrderDetailBloc, TaxiOrderDetailState>(
        builder: (context, state) {
          return switch (state.orderDetailResponse) {
            ApiResponseLoading() => Center(child: CupertinoActivityIndicator()),
            ApiResponseError(:final errorMessage) => Center(
              child: AppEmptyState(
                image: Assets.images.emptyStates.noRecord,
                title: errorMessage ?? context.tr.somethingWentWrong,
              ),
            ),
            ApiResponseLoaded(:final data) =>
              data.status.statusGrouped == TaxiOrderStatusGrouped.booked ||
                      data.status.statusGrouped ==
                          TaxiOrderStatusGrouped.inProgress
                  ? (context.isDesktop
                        ? TaxiOrderDetailActiveScreenDesktop(id: orderId)
                        : TaxiOrderDetailActiveScreenMobile(id: orderId))
                  : (context.isDesktop
                        ? TaxiOrderDetailArchiveScreenDesktop(id: orderId)
                        : TaxiOrderDetailArchiveScreenMobile(id: orderId)),
            _ => SizedBox(),
          };
        },
      ),
    );
  }
}
