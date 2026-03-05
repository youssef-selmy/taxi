// import 'package:flutter/material.dart';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:admin_frontend/core/blocs/auth.bloc.dart';
// import 'package:admin_frontend/core/blocs/config.bloc.dart';
// import 'package:admin_frontend/core/components/molecules/dropdown/app_dropdown_item.dart';
// import 'package:admin_frontend/core/components/molecules/dropdown/dropdown.dart';
// import 'package:admin_frontend/core/extensions/extensions.dart';
// import 'package:admin_frontend/schema.graphql.dart';

// class AppSwitcher extends StatelessWidget {
//   const AppSwitcher({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ConfigBloc, ConfigState>(
//       builder: (context, state) {
//         final config = state.config.data?.config;
//         return BlocBuilder<AuthBloc, AuthState>(
//           builder: (context, stateAuth) {
//             if (!stateAuth.isAuthenticated) {
//               return const SizedBox();
//             }
//             return AppDropdownMenu<Enum$AppType?>(
//               onChanged: (value) {
//                 context.read<AuthBloc>().add(AuthEvent$ChangeAppType(value));
//                 // This breaks the navigation
//                 // switch (value) {
//                 //   case Enum$AppType.Taxi:
//                 //     context.router.navigate(
//                 //       DashboardRoute(
//                 //         children: [
//                 //           TaxiShellRoute(children: [TaxiOverviewRoute()]),
//                 //         ],
//                 //       ),
//                 //     );
//                 //     // context.read<DashboardBloc>().goToRoute(
//                 //     //   TaxiOverviewRoute(),
//                 //     // );
//                 //     break;
//                 //   case Enum$AppType.Shop:
//                 //     context.navigateTo(
//                 //       ShopShellRoute(children: [ShopOverviewRoute()]),
//                 //     );
//                 //     context.read<DashboardBloc>().goToRoute(
//                 //       ShopOverviewRoute(),
//                 //     );
//                 //     break;
//                 //   case Enum$AppType.Parking:
//                 //     context.navigateTo(
//                 //       ParkingShellRoute(children: [ParkingOverviewRoute()]),
//                 //     );
//                 //     context.read<DashboardBloc>().goToRoute(
//                 //       ParkingOverviewRoute(),
//                 //     );
//                 //     break;
//                 //   case null:
//                 //     context.read<DashboardBloc>().goToRoute(
//                 //       PlatformOverviewShellRoute(),
//                 //     );
//                 //     context.navigateTo(PlatformOverviewShellRoute());
//                 //     break;
//                 //   default:
//                 //     break;
//                 // }
//               },
//               fillColor: context.colors.surface,
//               initialSelection: stateAuth.selectedAppType,
//               // backgroundColor: context.colors.surface,
//               // initialValue: [stateAuth.selectedAppType],
//               items: <AppDropdownItem<Enum$AppType?>>[
//                 if (stateAuth.appTypeAllowed(Enum$AppType.Taxi) &&
//                     state.taxiEnabled)
//                   AppDropdownItem(
//                     title: config?.taxi?.name ?? context.tr.taxi,
//                     value: Enum$AppType.Taxi,
//                     prefix: config?.taxi?.logo != null
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(4),
//                             child: CachedNetworkImage(
//                               imageUrl: config!.taxi!.logo!,
//                               width: 32,
//                               height: 32,
//                               fit: BoxFit.cover,
//                               filterQuality: FilterQuality.high,
//                               errorWidget: (context, url, error) => Icon(
//                                 Icons.error,
//                                 size: 32,
//                                 color: context.colors.error,
//                               ),
//                             ),
//                           )
//                         : null,
//                   ),
//                 if (stateAuth.appTypeAllowed(Enum$AppType.Shop) &&
//                     state.shopEnabled)
//                   AppDropdownItem(
//                     title: config?.shop?.name ?? context.tr.shop,
//                     value: Enum$AppType.Shop,
//                     prefix: config?.shop?.logo == null
//                         ? null
//                         : ClipRRect(
//                             borderRadius: BorderRadius.circular(4),
//                             child: CachedNetworkImage(
//                               imageUrl: config!.shop!.logo!,
//                               width: 32,
//                               height: 32,
//                               fit: BoxFit.cover,
//                               filterQuality: FilterQuality.high,
//                               errorWidget: (context, url, error) => Icon(
//                                 Icons.error,
//                                 size: 32,
//                                 color: context.colors.error,
//                               ),
//                             ),
//                           ),
//                   ),
//                 if (stateAuth.appTypeAllowed(Enum$AppType.Parking) &&
//                     state.parkingEnabled)
//                   AppDropdownItem(
//                     title: config?.parking?.name ?? context.tr.parking,
//                     value: Enum$AppType.Parking,
//                     prefix: config?.parking?.logo == null
//                         ? null
//                         : ClipRRect(
//                             borderRadius: BorderRadius.circular(4),
//                             child: CachedNetworkImage(
//                               imageUrl: config!.parking!.logo!,
//                               width: 32,
//                               height: 32,
//                               fit: BoxFit.cover,
//                               filterQuality: FilterQuality.high,
//                               errorWidget: (context, url, error) => Icon(
//                                 Icons.error,
//                                 size: 32,
//                                 color: context.colors.error,
//                               ),
//                             ),
//                           ),
//                   ),
//                 AppDropdownItem(title: context.tr.allPanels, value: null),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
