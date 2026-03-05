import 'package:api_response/api_response.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/announcement.graphql.dart';
import 'package:admin_frontend/features/marketing/announcement/data/graphql/announcement.graphql.dart';
import 'package:admin_frontend/features/marketing/announcement/data/repositories/announcement_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: AnnouncementRepository)
class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final GraphqlDatasource graphQLDatasource;

  AnnouncementRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$announcementDetails>> create({
    required Input$CreateAnnouncementInput input,
  }) async {
    final createResponse = await graphQLDatasource.mutate(
      Options$Mutation$createAnnouncement(
        variables: Variables$Mutation$createAnnouncement(input: input),
      ),
    );
    return createResponse.mapData((data) => data.createAnnouncement);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    final deleteResponse = await graphQLDatasource.mutate(
      Options$Mutation$deleteAnnouncement(
        variables: Variables$Mutation$deleteAnnouncement(id: id),
      ),
    );
    return deleteResponse.mapData((data) {});
  }

  @override
  Future<ApiResponse<Fragment$announcementDetails>> get({
    required String id,
  }) async {
    final getResponse = await graphQLDatasource.query(
      Options$Query$announcement(
        variables: Variables$Query$announcement(id: id),
      ),
    );
    return getResponse.mapData((data) => data.announcement);
  }

  @override
  Future<ApiResponse<Query$announcements>> getAll({
    required Input$OffsetPaging? paging,
    required Input$AnnouncementFilter filter,
    required List<Input$AnnouncementSort> sort,
  }) async {
    final getAllResponse = await graphQLDatasource.query(
      Options$Query$announcements(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Query$announcements(
          paging: paging,
          filter: filter,
          sort: sort,
        ),
      ),
    );
    return getAllResponse;
  }

  @override
  Future<ApiResponse<Fragment$announcementDetails>> update({
    required String id,
    required Input$UpdateAnnouncementInput input,
  }) async {
    final updateResponse = await graphQLDatasource.mutate(
      Options$Mutation$updateAnnouncement(
        variables: Variables$Mutation$updateAnnouncement(id: id, input: input),
      ),
    );
    return updateResponse.mapData((data) => data.updateOneAnnouncement);
  }
}
