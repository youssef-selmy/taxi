import 'package:admin_frontend/core/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/presentation/blocs/taxi_support_request_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/presentation/components/taxi_support_request_detail_activity.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/presentation/components/taxi_support_request_detail_overview.dart';

@RoutePage()
class TaxiSupportRequestDetailScreen extends StatelessWidget {
  const TaxiSupportRequestDetailScreen({
    super.key,
    @PathParam('supportRequestId') required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaxiSupportRequestDetailBloc()..onStarted(id),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child:
            BlocBuilder<
              TaxiSupportRequestDetailBloc,
              TaxiSupportRequestDetailState
            >(
              builder: (context, state) {
                return switch (state.supportRequestState) {
                  ApiResponseInitial() => const SizedBox(),
                  ApiResponseError(:final message) => Center(
                    child: Text(message),
                  ),
                  ApiResponseLoaded() || ApiResponseLoading() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PageHeader(
                        showBackButton: true,
                        title: context.tr.supportRequestDetails,
                        onBackButtonPressed: () {
                          context.router.replace(
                            const TaxiSupportRequestListRoute(),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Skeletonizer(
                          enabled: state.supportRequestState.isLoading,
                          enableSwitchAnimation: true,
                          child: LayoutGrid(
                            rowGap: 16,
                            columnGap: 16,
                            columnSizes: context.responsive(
                              [1.fr],
                              lg: [1.fr, 1.fr],
                            ),
                            rowSizes: context.responsive(
                              [600.px, 600.px],
                              lg: [1.fr],
                            ),
                            children: const <Widget>[
                              TaxiSupportRequestDetailOverview(),
                              TaxiSupportRequestDetailActivity(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                };
              },
            ),
      ),
    );
  }
}
