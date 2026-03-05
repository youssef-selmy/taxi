import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/marketing/announcement/data/graphql/announcement.graphql.dart';
import 'package:admin_frontend/features/marketing/announcement/data/repositories/announcement_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'announcement_list.state.dart';
part 'announcement_list.cubit.freezed.dart';

class AnnouncementListBloc extends Cubit<AnnouncementListState> {
  final AnnouncementRepository _announcementRepository =
      locator<AnnouncementRepository>();

  AnnouncementListBloc() : super(AnnouncementListState.initial());

  void onStarted() {
    _fetchAnnouncements();
  }

  void _fetchAnnouncements() async {
    emit(state.copyWith(announcements: const ApiResponse.loading()));
    final result = await _announcementRepository.getAll(
      paging: state.paging,
      sort: state.sorting,
      filter: Input$AnnouncementFilter(
        title: state.searchQuery == null
            ? null
            : Input$StringFieldComparison(like: '%${state.searchQuery}%'),
        appType: state.appTypeFilter == null
            ? null
            : Input$AppTypeFilterComparison($in: state.appTypeFilter),
      ),
    );
    final networkState = result;
    emit(state.copyWith(announcements: networkState));
  }

  void onSearchQueryChanged(String? searchQuery) {
    emit(state.copyWith(searchQuery: searchQuery));
    _fetchAnnouncements();
  }

  void onAppTypeFilterChanged(List<Enum$AppType>? appTypeFilter) {
    emit(state.copyWith(appTypeFilter: appTypeFilter));
    _fetchAnnouncements();
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchAnnouncements();
  }
}
