import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/announcement.graphql.dart';
import 'package:admin_frontend/features/marketing/announcement/data/graphql/announcement.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class AnnouncementRepository {
  Future<ApiResponse<Fragment$announcementDetails>> create({
    required Input$CreateAnnouncementInput input,
  });

  Future<ApiResponse<Fragment$announcementDetails>> update({
    required String id,
    required Input$UpdateAnnouncementInput input,
  });

  Future<ApiResponse<void>> delete({required String id});

  Future<ApiResponse<Query$announcements>> getAll({
    required Input$OffsetPaging? paging,
    required Input$AnnouncementFilter filter,
    required List<Input$AnnouncementSort> sort,
  });

  Future<ApiResponse<Fragment$announcementDetails>> get({required String id});
}
