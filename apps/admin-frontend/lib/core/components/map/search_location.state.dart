part of 'search_location.bloc.dart';

@freezed
sealed class SearchLocationState with _$SearchLocationState {
  const factory SearchLocationState({
    @Default("") String query,
    @Default(ApiResponseInitial()) ApiResponse<List<Fragment$Place>> places,
  }) = _SearchLocationState;
}
