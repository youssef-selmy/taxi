import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/auth/data/graphql/auth.graphql.dart';
import 'package:admin_frontend/features/auth/data/repositories/auth_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: AuthRepository)
class AuthRepositoryMock implements AuthRepository {
  // @override
  // Future<ApiResponse<Mutation$ActivateServer>> activateServer({
  //   required String purchaseCode,
  //   required String email,
  // }) async {
  //   if (purchaseCode == 'used') {
  //     return ApiResponse.loaded(
  //       Mutation$ActivateServer(
  //         updatePurchaseCode: Mutation$ActivateServer$updatePurchaseCode(
  //           status: Enum$UpdatePurchaseCodeStatus.CLIENT_FOUND,
  //           clients: [
  //             Mutation$ActivateServer$updatePurchaseCode$clients(
  //               id: 1,
  //               ip: "844.11.223.412",
  //               enabled: true,
  //               lastVerifiedAt: DateTime.now(),
  //               firstVerifiedAt: DateTime.now(),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //   return ApiResponse.loaded(
  //     Mutation$ActivateServer(
  //       updatePurchaseCode: Mutation$ActivateServer$updatePurchaseCode(
  //         status: Enum$UpdatePurchaseCodeStatus.OK,
  //         data: Mutation$ActivateServer$updatePurchaseCode$data(
  //             license: Fragment$License(
  //               buyerName: "John Doe",
  //               licenseType: Enum$LicenseType.Extended,
  //               supportExpireDate: DateTime.now().add(
  //                 const Duration(days: 365),
  //               ),
  //               connectedApps: [
  //                 Enum$AppType.Taxi,
  //                 Enum$AppType.Shop,
  //               ],
  //             ),
  //             benefits: [
  //               "Benefit 1",
  //               "Benefit 2",
  //               "Benefit 3",
  //               "Benefit 4",
  //             ],
  //             drawbacks: [
  //               "Drawback 1",
  //               "Drawback 2",
  //               "Drawback 3",
  //               "Drawback 4",
  //             ],
  //             availableUpgrades: [
  //               Mutation$ActivateServer$updatePurchaseCode$data$availableUpgrades(
  //                 type: "Extended",
  //                 benefits: [
  //                   "Benefit 1",
  //                   "Benefit 2",
  //                   "Benefit 3",
  //                   "Benefit 4",
  //                 ],
  //                 price: 100,
  //               ),
  //             ]),
  //       ),
  //     ),
  //   );
  // }

  @override
  Future<ApiResponse<Mutation$DisableServer>> disableServer({
    required String purchaseCode,
    required String ip,
  }) async {
    return ApiResponse.loaded(
      Mutation$DisableServer(
        disablePreviousServer: Mutation$DisableServer$disablePreviousServer(
          status: Enum$UpdateConfigStatus.OK,
        ),
      ),
    );
  }
}
