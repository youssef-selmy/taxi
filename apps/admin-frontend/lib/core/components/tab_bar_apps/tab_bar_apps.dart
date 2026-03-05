import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class TabBarApps extends StatefulWidget {
  final Widget? taxiChild;
  final Widget? shopChild;
  final Widget? parkingChild;

  const TabBarApps({
    super.key,
    required this.taxiChild,
    required this.shopChild,
    required this.parkingChild,
  });

  @override
  State<TabBarApps> createState() => _TabBarAppsState();
}

class _TabBarAppsState extends State<TabBarApps> {
  late Enum$AppType selectedAppType;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    selectedAppType =
        locator<AuthBloc>().state.selectedAppType ??
        locator<ConfigBloc>().state.enabledApps.first;
    pageController = PageController(
      initialPage: indexFromAppType(selectedAppType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.selectedAppType != null) {
          setState(() {
            selectedAppType = state.selectedAppType!;
            pageController.jumpToPage(indexFromAppType(selectedAppType));
          });
        }
      },
      buildWhen: (previous, current) =>
          previous.selectedAppType != current.selectedAppType,
      builder: (context, authBlocState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (authBlocState.selectedAppType == null) ...[
              AppTabMenuHorizontal<Enum$AppType>(
                style: TabMenuHorizontalStyle.soft,
                selectedValue: selectedAppType,
                onChanged: (value) {
                  setState(() {
                    selectedAppType = value;
                    pageController.jumpToPage(
                      indexFromAppType(selectedAppType),
                    );
                  });
                },
                tabs: [
                  if (authBlocState.appTypeAllowed(Enum$AppType.Taxi) &&
                      widget.taxiChild != null)
                    TabMenuHorizontalOption(
                      title: context.tr.taxi,
                      icon: BetterIcons.taxiFilled,
                      value: Enum$AppType.Taxi,
                    ),
                  if (authBlocState.appTypeAllowed(Enum$AppType.Shop) &&
                      widget.shopChild != null)
                    TabMenuHorizontalOption(
                      title: context.tr.shop,
                      icon: BetterIcons.shoppingBag02Filled,
                      value: Enum$AppType.Shop,
                    ),
                  if (authBlocState.appTypeAllowed(Enum$AppType.Parking) &&
                      widget.parkingChild != null)
                    TabMenuHorizontalOption(
                      title: context.tr.parking,
                      icon: BetterIcons.parkingAreaSquareFilled,
                      value: Enum$AppType.Parking,
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  if (authBlocState.appTypeAllowed(Enum$AppType.Taxi) &&
                      widget.taxiChild != null)
                    widget.taxiChild!,
                  if (authBlocState.appTypeAllowed(Enum$AppType.Shop) &&
                      widget.shopChild != null)
                    widget.shopChild!,
                  if (authBlocState.appTypeAllowed(Enum$AppType.Parking) &&
                      widget.parkingChild != null)
                    widget.parkingChild!,
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  int indexFromAppType(Enum$AppType appType) {
    return appType == Enum$AppType.Taxi
        ? 0
        : appType == Enum$AppType.Shop
        ? 1
        : 2;
  }
}
