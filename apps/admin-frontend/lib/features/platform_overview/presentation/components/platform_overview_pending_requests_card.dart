import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_request_info_card.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_localization/localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlatformOverviewPendingRequestsCard extends StatelessWidget {
  const PlatformOverviewPendingRequestsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformOverviewCubit, PlatformOverviewState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.pendingOrders.isLoading,
          enableSwitchAnimation: true,
          child: PlatformOverviewRequestInfoCard(
            icon: BetterIcons.userAdd01Filled,
            title: context.tr.pendingOrders,
            type: PlatformOverviewRequestInfoCardType.orderRequests,
            taxiCount: state.pendingOrders.data?.taxiOrders.totalCount
                .toString(),
            shopCount: state.pendingOrders.data?.shopOrders.totalCount
                .toString(),
            parkingCount: state.pendingOrders.data?.parkOrders.totalCount
                .toString(),
          ),
        );
      },
    );
  }
}
