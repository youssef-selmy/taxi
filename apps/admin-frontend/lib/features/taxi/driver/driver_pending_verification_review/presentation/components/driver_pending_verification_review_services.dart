import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverPendingVerificationReviewServices extends StatelessWidget {
  const DriverPendingVerificationReviewServices({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch is now called from parent screen when step changes
    return BlocBuilder<
      DriverPendingVerificationReviewBloc,
      DriverPendingVerificationReviewState
    >(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                AppAvatar(
                  imageUrl: state.driverReview?.media?.address,
                  size: AvatarSize.size40px,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      context.tr.driver,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    Text(
                      state.driverReview?.firstName ?? '',
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            LargeHeader(title: context.tr.serviceSelectedByDriver),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              itemCount: state.driverReview?.enabledServices.length ?? 0,
              separatorBuilder: (context, index) =>
                  const AppDivider(height: 32),
              itemBuilder: (context, index) {
                var service = state.driverReview!.enabledServices[index];
                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colors.outline),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: state.servicesState.data?.services
                            .firstWhereOrNull(
                              (e) => e.categoryId == service.service.categoryId,
                            )
                            ?.media
                            .widget(width: 32, height: 32),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              service.service.name,
                              style: context.textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 4),
                            if (service.service.personCapacity != null) ...[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    BetterIcons.userFilled,
                                    size: 12,
                                    color: context.colors.surfaceVariantLow,
                                  ),
                                  Transform.translate(
                                    offset: const Offset(0, -6),
                                    child: Text(
                                      service.service.personCapacity!
                                          .toString(),
                                      style: context.textTheme.labelMedium
                                          ?.variant(context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        Text(
                          state.servicesState.data?.serviceCategories
                                  .firstWhereOrNull(
                                    (e) => e.id == service.service.categoryId,
                                  )
                                  ?.name ??
                              '',
                          style: context.textTheme.labelMedium?.variant(
                            context,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const AppDivider(height: 16),
            const SizedBox(height: 24),
            Text(
              context.tr.selectService,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Skeletonizer(
              enableSwitchAnimation: true,
              enabled: state.servicesState.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTabMenuHorizontal(
                    style: TabMenuHorizontalStyle.soft,
                    selectedValue:
                        state.servicesState.data?.serviceCategories[0].id,
                    onChanged: (value) {
                      context
                          .read<DriverPendingVerificationReviewBloc>()
                          .onServiceTabChange(value as String);
                    },
                    tabs:
                        state.servicesState.data?.serviceCategories
                            .map(
                              (e) => TabMenuHorizontalOption(
                                title: e.name,
                                value: e.id,
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                  const AppDivider(height: 32),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.servicesState.isLoading
                        ? 4
                        : state.servicesFilter.length,
                    separatorBuilder: (context, index) {
                      return const AppDivider(height: 32);
                    },
                    itemBuilder: (context, index) {
                      var service = state.servicesState.isLoading
                          ? mockTaxiPricing1
                          : state.servicesFilter[index];
                      return Row(
                        children: [
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: AppCheckbox(
                              value: state.servicesState.isLoading
                                  ? false
                                  : state.selectedServiceCheckBox
                                        .firstWhere(
                                          (e) => e.serviceId == service.id,
                                        )
                                        .isSelectedService,
                              onChanged: (value) {
                                context
                                    .read<DriverPendingVerificationReviewBloc>()
                                    .onSelectServiceChange(service.id, value);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: kBorder(context),
                            ),
                            child: Center(
                              child: service.media.widget(
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            service.name,
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: context.responsive(
                      MainAxisAlignment.spaceBetween,
                      lg: MainAxisAlignment.start,
                    ),
                    textDirection: context.responsive(
                      TextDirection.rtl,
                      lg: TextDirection.ltr,
                    ),
                    children: [
                      Switch(
                        value: state.canDeliverServices,
                        onChanged: context
                            .read<DriverPendingVerificationReviewBloc>()
                            .onCanDeliverServicesChange,
                      ),
                      context.responsive(
                        const SizedBox(),
                        lg: const SizedBox(width: 8),
                      ),
                      Text(
                        context.tr.deliveryServices,
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const AppDivider(height: 1),
                  const SizedBox(height: 22),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: Enum$DeliveryPackageSize.values
                        .where((e) => e != Enum$DeliveryPackageSize.$unknown)
                        .length,
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 22),
                        child: AppDivider(height: 1),
                      );
                    },
                    itemBuilder: (context, index) {
                      var service = state.servicesState.isLoading
                          ? Enum$DeliveryPackageSize.Medium
                          : Enum$DeliveryPackageSize.values[index];
                      return Row(
                        children: [
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: AppCheckbox(
                              value: state.servicesState.isLoading
                                  ? false
                                  : state
                                            .deliveryServicesOption[index]
                                            .isSelectedServiceOption ??
                                        false,
                              onChanged: state.canDeliverServices
                                  ? (value) {
                                      context
                                          .read<
                                            DriverPendingVerificationReviewBloc
                                          >()
                                          .onChangeCanDeliverServicesOption(
                                            value,
                                            index,
                                            Enum$DeliveryPackageSize
                                                .values[index],
                                          );
                                    }
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            service.name,
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
          ],
        );
      },
    );
  }
}
