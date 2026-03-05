import 'package:api_response/api_response.dart';
import 'package:image_faker/image_faker.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:admin_frontend/core/graphql/documents/config.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/config.mock.dart';
import 'package:admin_frontend/core/repositories/config_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ConfigRepository)
class LicenseRepositoryMock implements ConfigRepository {
  @override
  Stream<ApiResponse<Fragment$Config>> get configInformation =>
      _configInformation.stream;
  @override
  Stream<ApiResponse<Fragment$license?>> get licenseInformation =>
      _licenseInformation.stream;

  final _configInformation = BehaviorSubject<ApiResponse<Fragment$Config>>();
  final _licenseInformation = BehaviorSubject<ApiResponse<Fragment$license?>>();

  @override
  Future<void> getConfigInformation() async {
    // _configInformation.add(ApiResponse.error('Error'));
    // _licenseInformation.add(ApiResponse.error('Error'));
    _configInformation.add(ApiResponse.loaded(mockConfig));
    _licenseInformation.add(ApiResponse.loaded(mockLicense));
  }

  @override
  Future<ApiResponse<void>> updateConfig({
    required Input$UpdateConfigInputV2 input,
  }) async {
    _configInformation.add(
      ApiResponse.loaded(
        Fragment$Config(
          isValid: true,
          config: Fragment$Config$config(
            companyName: "BetterSuite",
            companyLogo: ImageFaker().appLogo.bettersuiteTyped,
            taxi: Fragment$AppConfigInfo(
              logo: ImageFaker().appLogo.taxi,
              name: input.taxi?.name ?? "BetterTaxi",
              color: input.taxi?.color,
            ),
            shop: Fragment$AppConfigInfo(
              logo: ImageFaker().appLogo.shop,
              name: input.shop?.name ?? "BetterShop",
              color: input.shop?.color,
            ),
            parking: Fragment$AppConfigInfo(
              logo: ImageFaker().appLogo.parking,
              name: input.parking?.name ?? "BetterParking",
              color: input.parking?.color,
            ),
          ),
        ),
      ),
    );
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Mutation$updateLicense>> updateLicense({
    required String purchaseCode,
    required String email,
  }) async {
    _licenseInformation.add(ApiResponse.loaded(mockLicense));
    return ApiResponse.loaded(
      Mutation$updateLicense(
        updatePurchaseCode: Mutation$updateLicense$updatePurchaseCode(
          status: Enum$UpdatePurchaseCodeStatus.OK,
          data: mockLicense,
          clients: [],
        ),
      ),
    );
  }
}
