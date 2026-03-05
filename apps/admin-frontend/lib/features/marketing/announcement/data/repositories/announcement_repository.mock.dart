import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/announcement.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/announcement.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/marketing/announcement/data/graphql/announcement.graphql.dart';
import 'package:admin_frontend/features/marketing/announcement/data/repositories/announcement_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: AnnouncementRepository)
class AnnouncementRepositoryMock implements AnnouncementRepository {
  @override
  Future<ApiResponse<Fragment$announcementDetails>> create({
    required Input$CreateAnnouncementInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockAnnouncementDetails);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Fragment$announcementDetails>> get({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockAnnouncementDetails);
  }

  @override
  Future<ApiResponse<Query$announcements>> getAll({
    required Input$OffsetPaging? paging,
    required Input$AnnouncementFilter filter,
    required List<Input$AnnouncementSort> sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$announcements(
        announcements: Query$announcements$announcements(
          nodes: mockAnnouncementList,
          pageInfo: mockPageInfo,
          totalCount: mockAnnouncementList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$announcementDetails>> update({
    required String id,
    required Input$UpdateAnnouncementInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockAnnouncementDetails);
  }
}
