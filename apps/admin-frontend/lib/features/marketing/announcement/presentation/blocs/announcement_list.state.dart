part of 'announcement_list.cubit.dart';

@freezed
sealed class AnnouncementListState with _$AnnouncementListState {
  const factory AnnouncementListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$announcements> announcements,
    String? searchQuery,
    Input$OffsetPaging? paging,
    List<Enum$AppType>? appTypeFilter,

    required List<Input$AnnouncementSort> sorting,
  }) = _AnnouncementListState;

  // Initial State
  factory AnnouncementListState.initial() => AnnouncementListState(
    sorting: [
      Input$AnnouncementSort(
        field: Enum$AnnouncementSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );
}
