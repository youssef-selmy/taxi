import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/blocs/settings.bloc.dart';
import 'package:admin_frontend/core/components/map/repositories/geo_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';

part 'search_location.state.dart';
part 'search_location.bloc.freezed.dart';

@lazySingleton
class SearchLocationCubit extends Cubit<SearchLocationState> {
  final GeoRepository _geoRepository;
  final SettingsCubit _settingsCubit;

  SearchLocationCubit(this._geoRepository, this._settingsCubit)
    : super(SearchLocationState());

  void startTyping() {
    emit(state.copyWith(places: ApiResponse.loading()));
  }

  void stopTyping({required String query}) async {
    emit(state.copyWith(places: ApiResponse.loading()));
    final places = await _geoRepository.getPlaces(
      query: query,
      location: null,
      language: Env.defaultLanguage,
      mapProvider: _settingsCubit.state.mapProvider,
    );
    emit(state.copyWith(places: places));
  }
}
