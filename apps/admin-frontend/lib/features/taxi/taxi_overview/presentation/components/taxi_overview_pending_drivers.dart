import 'package:admin_frontend/core/graphql/fragments/driver.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/header_tag.dart';
import 'package:admin_frontend/core/enums/driver_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/blocs/taxi_overview.bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TaxiOverviewPendingDrivers extends StatelessWidget {
  const TaxiOverviewPendingDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOverviewBloc, TaxiOverviewState>(
      builder: (context, state) {
        final data = state.pendingDriversState.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      context.tr.pendingDrivers,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(width: 8),
                    HeaderTag(
                      text: "${data?.drivers.totalCount ?? 0} unverified",
                    ),
                    Spacer(),
                    AppOutlinedButton(
                      onPressed: () {
                        context.router.push(DriverListRoute());
                      },
                      color: SemanticColor.neutral,
                      text: context.tr.viewAll,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 320,
                  child: switch (state.pendingDriversState) {
                    ApiResponseInitial() => const SizedBox(),
                    ApiResponseError() => AppEmptyState(
                      image: Assets.images.emptyStates.error,
                      title: context.tr.somethingWentWrong,
                      actionText: context.tr.retry,
                      onActionPressed: () {
                        context.read<TaxiOverviewBloc>().add(
                          TaxiOverviewEvent.pendingDriversRefresh(),
                        );
                      },
                    ),
                    ApiResponseLoading() || ApiResponseLoaded() => Skeletonizer(
                      enabled: state.pendingDriversState.isLoading,
                      child: _listView(
                        context,
                        state.pendingDriversState.isLoaded
                            ? state.pendingDriversState.data!.drivers.nodes
                            : List.generate(4, (_) => mockDriverListItem1),
                      ),
                    ),
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listView(BuildContext context, List<Fragment$driverListItem> items) {
    if (items.isEmpty) {
      return AppEmptyState(
        image: Assets.images.emptyStates.cyberThreat,
        title: context.tr.noDataAvailable,
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final driver = items[index];
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: context.isDesktop
              ? null
              : () async {
                  final bloc = context.read<TaxiOverviewBloc>();
                  await context.router.push(
                    DriverDetailRoute(driverId: driver.id),
                  );
                  bloc.add(TaxiOverviewEvent.pendingDriversRefresh());
                },
          minimumSize: Size(0, 0),
          child: Row(
            children: [
              if (driver.media != null) ...[
                driver.media!.roundedWidget(size: 40),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  driver.fullName,
                  style: context.textTheme.labelMedium?.apply(
                    color: context.colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (context.isDesktop) ...[
                Expanded(
                  child: Text(
                    driver.registrationTimestamp.toTimeAgo,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [driver.status.chip(context)],
                ),
              ),
              const SizedBox(width: 16),
              if (context.isDesktop)
                AppTextButton(
                  text: context.tr.viewProfile,
                  onPressed: () async {
                    final bloc = context.read<TaxiOverviewBloc>();
                    await context.router.push(
                      DriverDetailRoute(driverId: driver.id),
                    );
                    bloc.add(TaxiOverviewEvent.pendingDriversRefresh());
                  },
                ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 24),
    );
  }
}
