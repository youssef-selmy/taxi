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
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CreateNewDriverServices extends StatelessWidget {
  const CreateNewDriverServices({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewDriverBloc>();
    return BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LargeHeader(title: context.tr.service),
            const Divider(height: 16),
            const SizedBox(height: 24),
            Text(
              context.tr.selectAService,
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
                    tabs: (state.servicesState.data?.serviceCategories ?? [])
                        .map(
                          (e) => TabMenuHorizontalOption(
                            title: e.name,
                            value: e.id,
                          ),
                        )
                        .toList(),
                    selectedValue: state.selectedServiceCategoryId,
                    onChanged: (value) {
                      bloc.onSelectedServiceCategoryId(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  ...(state.servicesState.isLoading
                          ? List.generate(
                              4,
                              (index) => mockTaxiPricingListItem1,
                            )
                          : state.services)
                      .mapIndexed((index, service) {
                        final isSelected = state.servicesState.isLoading
                            ? false
                            : state.selectedServiceIds.firstWhereOrNull(
                                    (e) => e == service.id,
                                  ) !=
                                  null;
                        return AppListItem(
                          title: service.name,
                          subtitle: service.description,
                          leading: service.media.widget(width: 32, height: 32),
                          isSelected: isSelected,
                          actionType: ListItemActionType.checkbox,
                          onTap: (value) {
                            bloc.onSelectServiceChange(service.id, value);
                          },
                        );
                      })
                      .toList()
                      .separated(separator: const SizedBox(height: 16)),
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
                        isSelected: state.canDeliver,
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
                  const AppDivider(height: 32),
                  ...Enum$DeliveryPackageSize.values
                      .where((e) => e != Enum$DeliveryPackageSize.$unknown)
                      .map((packageSize) {
                        return AppListItem(
                          title: packageSize.name,
                          actionType: ListItemActionType.radio,
                          isSelected: state.deliveryPackageSize == packageSize,
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
