import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/gift_card.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/gift_card.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/graphql/gift_card.graphql.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/repositories/gift_card_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: GiftCardRepository)
class GiftCardRepositoryMock implements GiftCardRepository {
  @override
  Future<ApiResponse<Fragment$giftBatchListItem>> create({
    required Input$CreateGiftBatchInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockGiftBatchListItem1);
  }

  @override
  Future<ApiResponse<String>> exportGiftCodes({required String batchId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded('https://google.com');
  }

  @override
  Future<ApiResponse<Query$giftBatches>> getAll({
    required Input$OffsetPaging? paging,
    required Input$GiftBatchFilter filter,
    required List<Input$GiftBatchSort> sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$giftBatches(
        giftBatches: Query$giftBatches$giftBatches(
          nodes: mockGiftBatchList,
          totalCount: mockGiftBatchList.length,
          pageInfo: mockPageInfo,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$giftCodeConnection>> getGiftCodes({
    required String batchId,
    required Input$OffsetPaging? paging,
    required List<Input$GiftCodeSort> sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Fragment$giftCodeConnection(
        nodes: mockGiftCodeItems,
        totalCount: mockGiftCodeItems.length,
        pageInfo: mockPageInfo,
      ),
    );
  }

  @override
  Future<ApiResponse<Query$giftBatch>> getOne(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(Query$giftBatch(giftBatch: mockGiftBatchDetails));
  }
}
