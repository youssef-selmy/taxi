// import 'package:admin_frontend/core/entities/payment_method.dart';
// import 'package:admin_frontend/core/extensions/extensions.dart';
// import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.dart';
// import 'package:admin_frontend/core/locator/locator.dart';
// import 'package:admin_frontend/core/widgets/selectable_list_tile.dart';
// import 'package:admin_frontend/my_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:admin_frontend/core/enums/saved_payment_method_provider_brand.dart';

// import '../../blocs/parking_dispatcher.dart';

// class PaymentMethods extends StatelessWidget {
//   const PaymentMethods({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
//       builder: (context, state) {
//         return state.checkoutOptions.map(
//           initial: (initial) => const SizedBox(),
//           loading: (loading) => const SizedBox(),
//           loaded: (loaded) {
//             return AlignedGridView.count(
//               itemCount: (loaded.data.savedPaymentMethods.nodes?.length ?? 0) + 2,
//               shrinkWrap: true,
//               crossAxisCount: 2,
//               mainAxisSpacing: 8,
//               crossAxisSpacing: 8,
//               itemBuilder: (context, index) {
//                 if (index == 0) {
//                   return AppSelectableListTile(
//                     title: Text(context.translate.wallet),
//                     isSelected: state.paymentMethod.isWallet,
//                     value: const PaymentMethod.wallet(),
//                     trailing: Icon(
//                       BetterIcons.wallet01Filled,
//                       color: context.colors.primary,
//                     ),
//                     onSelected: context.read<ParkingDispatcherBloc>().onPaymentMethodSelected,
//                   );
//                 } else if (index == 1) {
//                   return AppSelectableListTile(
//                     title: Text(context.translate.cash),
//                     isSelected: state.paymentMethod.isCash,
//                     value: const PaymentMethod.cash(),
//                     trailing: Icon(
//                       BetterIcons.money03Filled,
//                       color: context.colors.primary,
//                     ),
//                     onSelected: context.read<ParkingDispatcherBloc>().onPaymentMethodSelected,
//                   );
//                 } else {
//                   final Fragment$SavedPaymentMethod paymentMethod = loaded.data.savedPaymentMethods.nodes[index - 2];
//                   return AppSelectableListTile(
//                     title: Text(paymentMethod.title),
//                     isSelected: state.paymentMethod.isSaved(paymentMethod.id),
//                     value: PaymentMethod.online(savedPaymentMethod: paymentMethod),
//                     trailing: paymentMethod.providerBrand?.image.image(width: 24, height: 24),
//                     onSelected: context.read<ParkingDispatcherBloc>().onPaymentMethodSelected,
//                   );
//                 }
//               },
//             );
//           },
//           error: (error) => Text(context.tr.error),
//         );
//       },
//     );
//   }
// }
