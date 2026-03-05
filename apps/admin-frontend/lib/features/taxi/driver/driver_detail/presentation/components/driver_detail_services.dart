import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:collection/collection.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/blocs/driver_detail.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverDetailServices extends StatelessWidget {
  const DriverDetailServices({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverDetailBloc>();
    return BlocBuilder<DriverDetailBloc, DriverDetailState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LargeHeader(title: context.tr.service),
            const AppDivider(height: 16),
            const SizedBox(height: 24),
            Text(
              context.tr.selectService,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Skeletonizer(
              enableSwitchAnimation: true,
              enabled: state.driverDetailResponse.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTabMenuHorizontal(
                    style: TabMenuHorizontalStyle.soft,
                    tabs:
                        (state.driverDetailResponse.data?.serviceCategories ??
                                [
                                  mockTaxiPricingCategory1,
                                  mockTaxiPricingCategory2,
                                ])
                            .map(
                              (e) => TabMenuHorizontalOption(
                                title: e.name,
                                value: e.id,
                              ),
                            )
                            .toList(),
                    selectedValue: state.selectedServiceCategoryId,
                    onChanged: (value) {
                      bloc.onServiceTabChange(value);
                    },
                  ),
                  const AppDivider(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.driverDetailResponse.isLoading
                        ? List.generate(4, (index) => mockTaxiPricing1).map((
                            service,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 32),
                              child: AppListItem(
                                title: service.name,
                                leading: service.media.widget(
                                  width: 32,
                                  height: 32,
                                ),
                                actionType: ListItemActionType.switcher,
                                isSelected: false,
                                onTap: (value) {
                                  // Loading state, no action needed
                                },
                              ),
                            );
                          }).toList()
                        : state.selectedTabServices
                              .map((service) {
                                return AppListItem(
                                  title: service.name,
                                  subtitle: service.description,
                                  badge: AppBadge(
                                    text:
                                        state
                                            .driverDetailResponse
                                            .data
                                            ?.serviceCategories
                                            .firstWhereOrNull(
                                              (e) => e.id == service.categoryId,
                                            )
                                            ?.name ??
                                        '',
                                  ),
                                  leading: service.media.widget(
                                    width: 32,
                                    height: 32,
                                  ),
                                  actionType: ListItemActionType.switcher,
                                  isSelected:
                                      state.selectedServiceIds.firstWhereOrNull(
                                        (e) => e == service.id,
                                      ) !=
                                      null,
                                  onTap: (value) {
                                    bloc.onSelectServiceChange(
                                      service.id,
                                      value,
                                    );
                                  },
                                );
                              })
                              .toList()
                              .separated(
                                separator: const AppDivider(height: 32),
                              ),
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
                      AppSwitch(
                        isSelected:
                            state.updatedDriverDetail?.canDeliver ?? false,
                        onChanged: bloc.onChangeCanDeliver,
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
                  if (state.updatedDriverDetail?.canDeliver == true)
                    ...Enum$DeliveryPackageSize.values
                        .where((e) => e != Enum$DeliveryPackageSize.$unknown)
                        .map((packageSize) {
                          return AppListItem(
                            title: packageSize.name,
                            actionType: ListItemActionType.radio,
                            isSelected:
                                state
                                    .updatedDriverDetail
                                    ?.maxDeliveryPackageSize ==
                                packageSize,
                            onTap: (value) =>
                                bloc.onChangeDeliveryPackageSize(packageSize),
                          );
                        })
                        .toList()
                        .separated(separator: const SizedBox(height: 16)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
