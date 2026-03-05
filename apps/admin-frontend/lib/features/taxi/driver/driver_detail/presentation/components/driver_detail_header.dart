import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_status/dropdown_status.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/enums/driver_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/blocs/driver_detail.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverDetailHeader extends StatelessWidget {
  const DriverDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverDetailBloc>();
    return BlocBuilder<DriverDetailBloc, DriverDetailState>(
      builder: (context, state) {
        var driver = state.driverDetailResponse.isLoading
            ? mockDriverDetail1
            : state.driverDetailResponse.data?.driver;
        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: state.driverDetailResponse.isLoading,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.tr.basicDetails,
                    style: context.textTheme.bodyMedium?.variant(context),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20,
                    runSpacing: 40,
                    children: [
                      UploadFieldSmall(
                        initialValue: driver?.media,
                        onChanged: bloc.onUpdateDriverImage,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driver?.firstName ?? "",
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            driver?.lastSeenTimestamp != null
                                ? context.tr.lastActivityAtWithPlaceholder(
                                    driver!.lastSeenTimestamp!.toTimeAgo,
                                  )
                                : "-",
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr.registeredOn,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            driver?.registrationTimestamp.toTimeAgo ?? "---",
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr.rating,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                          const SizedBox(height: 2),
                          RatingIndicator(rating: driver?.rating?.toInt()),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr.status,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                          const SizedBox(height: 2),
                          if (driver?.status != null)
                            AppDropdownStatus(
                              initialValue: driver?.status,
                              onChanged: bloc.onUpdateDriverStatus,
                              items: Enum$DriverStatus.values
                                  .toDropDownStatusItems(context),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
