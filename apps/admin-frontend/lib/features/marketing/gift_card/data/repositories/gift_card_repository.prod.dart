import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/gift_card.graphql.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/graphql/gift_card.graphql.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/repositories/gift_card_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: GiftCardRepository)
class GiftCardRepositoryImpl implements GiftCardRepository {
  final GraphqlDatasource graphQLDatasource;

  GiftCardRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$giftBatchListItem>> create({
    required Input$CreateGiftBatchInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createGiftBatch(
        variables: Variables$Mutation$createGiftBatch(input: input),
      ),
    );
    return result.mapData((r) => r.createGiftCardBatch);
  }

  @override
  Future<ApiResponse<String>> exportGiftCodes({required String batchId}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$exportGiftBatch(
        variables: Variables$Mutation$exportGiftBatch(batchId: batchId),
      ),
    );
    return result.mapData((r) => r.exportGiftCardBatch);
  }

  @override
  Future<ApiResponse<Query$giftBatches>> getAll({
    required Input$OffsetPaging? paging,
    required Input$GiftBatchFilter filter,
    required List<Input$GiftBatchSort> sort,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$giftBatches(
        variables: Variables$Query$giftBatches(
          paging: paging,
          filter: filter,
          sorting: sort,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$giftCodeConnection>> getGiftCodes({
    required String batchId,
    required Input$OffsetPaging? paging,
    required List<Input$GiftCodeSort> sort,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$giftCodes(
        variables: Variables$Query$giftCodes(
          giftBatchId: batchId,
          paging: paging,
          sorting: sort,
        ),
      ),
    );
    return result.mapData((r) => r.giftCodes);
  }

  @override
  Future<ApiResponse<Query$giftBatch>> getOne(String id) async {
    final result = await graphQLDatasource.query(
      Options$Query$giftBatch(variables: Variables$Query$giftBatch(id: id)),
    );
    return result;
  }
}
