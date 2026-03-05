import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/gift_card.graphql.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/graphql/gift_card.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class GiftCardRepository {
  Future<ApiResponse<Query$giftBatches>> getAll({
    required Input$OffsetPaging? paging,
    required Input$GiftBatchFilter filter,
    required List<Input$GiftBatchSort> sort,
  });

  Future<ApiResponse<Query$giftBatch>> getOne(String id);

  Future<ApiResponse<Fragment$giftCodeConnection>> getGiftCodes({
    required String batchId,
    required Input$OffsetPaging? paging,
    required List<Input$GiftCodeSort> sort,
  });

  Future<ApiResponse<Fragment$giftBatchListItem>> create({
    required Input$CreateGiftBatchInput input,
  });

  Future<ApiResponse<String>> exportGiftCodes({required String batchId});
}
