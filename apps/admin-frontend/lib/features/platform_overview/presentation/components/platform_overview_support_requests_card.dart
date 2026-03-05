import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_request_info_card.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_localization/localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlatformOverviewSupportRequestsCard extends StatelessWidget {
  const PlatformOverviewSupportRequestsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformOverviewCubit, PlatformOverviewState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.pendingSupportRequests.isLoading,
          enableSwitchAnimation: true,
          child: PlatformOverviewRequestInfoCard(
            icon: BetterIcons.headphonesFilled,
            title: context.tr.supportRequest,
            type: PlatformOverviewRequestInfoCardType.supportRequests,
            taxiCount: state
                .pendingSupportRequests
                .data
                ?.taxiSupportRequests
                .totalCount
                .toString(),
            shopCount: state
                .pendingSupportRequests
                .data
                ?.shopSupportRequests
                .totalCount
                .toString(),
            parkingCount: state
                .pendingSupportRequests
                .data
                ?.parkingSupportRequests
                .totalCount
                .toString(),
          ),
        );
      },
    );
  }
}
