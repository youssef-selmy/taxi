import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_presets_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopDetailPresetsRepository)
class ShopDetailPresetsRepositoryImpl implements ShopDetailPresetsRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailPresetsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopPresets>> getShopPresets({
    required Input$ShopItemPresetFilter filter,
    required List<Input$ShopItemPresetSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final presetsOrError = await graphQLDatasource.query(
      Options$Query$shopPresets(
        variables: Variables$Query$shopPresets(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );
    return presetsOrError;
  }

  @override
  Future<ApiResponse<Fragment$shopItemPresetDetail>> getShopItemPreset({
    required String id,
  }) async {
    final presetOrError = await graphQLDatasource.query(
      Options$Query$itemPreset(variables: Variables$Query$itemPreset(id: id)),
    );
    return presetOrError.mapData((r) => r.shopItemPreset);
  }

  @override
  Future<ApiResponse<void>> deleteShopItemPreset({required String id}) async {
    final deleteOrError = await graphQLDatasource.mutate(
      Options$Mutation$deleteItemPreset(
        variables: Variables$Mutation$deleteItemPreset(id: id),
      ),
    );
    return deleteOrError;
  }

  @override
  Future<ApiResponse<void>> createShopItemPreset({
    required Input$CreateShopItemPresetInput input,
  }) async {
    final createOrError = await graphQLDatasource.mutate(
      Options$Mutation$createShopItemPreset(
        variables: Variables$Mutation$createShopItemPreset(input: input),
      ),
    );
    return createOrError;
  }

  @override
  Future<ApiResponse<void>> updateShopItemPreset({
    required String id,
    required Input$UpdateShopItemPresetInput input,
  }) async {
    final updateOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShopItemPreset(
        variables: Variables$Mutation$updateShopItemPreset(
          id: id,
          update: input,
        ),
      ),
    );
    return updateOrError;
  }
}
