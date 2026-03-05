import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class PlatformOverviewRequestInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? taxiCount;
  final String? shopCount;
  final String? parkingCount;
  final PlatformOverviewRequestInfoCardType type;

  const PlatformOverviewRequestInfoCard({
    super.key,
    required this.icon,
    required this.title,
    this.taxiCount,
    this.shopCount,
    this.parkingCount,
    this.type = PlatformOverviewRequestInfoCardType.supportRequests,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 8,
            color: context.colors.shadow,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 24, color: context.colors.primary),
              Text(title, style: context.textTheme.labelLarge),
            ],
          ),
          SizedBox(height: 12),
          AppListItem(
            isCompact: true,
            leading: Icon(
              BetterIcons.taxiOutline,
              size: 20,
              color: context.colors.onSurfaceVariant,
            ),
            title: context.tr.taxi,
            trailing: Row(
              spacing: 8,
              children: <Widget>[
                AppBadge(
                  text: taxiCount ?? '0',
                  color:
                      type ==
                          PlatformOverviewRequestInfoCardType.supportRequests
                      ? SemanticColor.error
                      : SemanticColor.warning,
                ),
                Icon(
                  BetterIcons.arrowRight01Outline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            onTap: (_) {
              locator<AuthBloc>().add(
                AuthEvent.changeAppType(Enum$AppType.Taxi),
              );
              if (type == PlatformOverviewRequestInfoCardType.supportRequests) {
                context.router.navigate(
                  TaxiShellRoute(
                    children: [
                      TaxiSupportRequestShellRoute(
                        children: [TaxiSupportRequestListRoute()],
                      ),
                    ],
                  ),
                );
              } else {
                context.router.navigate(
                  TaxiShellRoute(
                    children: [
                      TaxiOrderShellRoute(children: [TaxiOrderListRoute()]),
                    ],
                  ),
                );
              }
            },
          ),
          SizedBox(height: 8),
          AppListItem(
            isCompact: true,
            leading: Icon(
              BetterIcons.store01Outline,
              size: 20,
              color: context.colors.onSurfaceVariant,
            ),
            title: context.tr.shop,
            trailing: Row(
              spacing: 8,
              children: <Widget>[
                AppBadge(
                  text: shopCount ?? '0',
                  color:
                      type ==
                          PlatformOverviewRequestInfoCardType.supportRequests
                      ? SemanticColor.error
                      : SemanticColor.warning,
                ),
                Icon(
                  BetterIcons.arrowRight01Outline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            onTap: (_) {
              locator<AuthBloc>().add(
                AuthEvent.changeAppType(Enum$AppType.Shop),
              );
              if (type == PlatformOverviewRequestInfoCardType.supportRequests) {
                context.router.navigate(
                  ShopShellRoute(
                    children: [
                      ShopSupportRequestShellRoute(
                        children: [ShopSupportRequestListRoute()],
                      ),
                    ],
                  ),
                );
              } else {
                context.router.navigate(
                  ShopShellRoute(
                    children: [
                      ShopOrderShellRoute(children: [ShopOrderListRoute()]),
                    ],
                  ),
                );
              }
            },
          ),
          SizedBox(height: 8),
          AppListItem(
            isCompact: true,
            leading: Icon(
              BetterIcons.parkingAreaSquareOutline,
              size: 20,
              color: context.colors.onSurfaceVariant,
            ),
            title: context.tr.parking,
            trailing: Row(
              spacing: 8,
              children: <Widget>[
                AppBadge(
                  text: parkingCount ?? '0',
                  color:
                      type ==
                          PlatformOverviewRequestInfoCardType.supportRequests
                      ? SemanticColor.error
                      : SemanticColor.warning,
                ),
                Icon(
                  BetterIcons.arrowRight01Outline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            onTap: (_) {
              locator<AuthBloc>().add(
                AuthEvent.changeAppType(Enum$AppType.Parking),
              );
              if (type == PlatformOverviewRequestInfoCardType.supportRequests) {
                context.router.navigate(
                  ParkingShellRoute(
                    children: [
                      ParkingSupportRequestShellRoute(
                        children: [ParkingSupportRequestListRoute()],
                      ),
                    ],
                  ),
                );
              } else {
                context.router.navigate(
                  ParkingShellRoute(
                    children: [
                      ParkingOrderShellRoute(
                        children: [ParkingOrderListRoute()],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

enum PlatformOverviewRequestInfoCardType { supportRequests, orderRequests }
