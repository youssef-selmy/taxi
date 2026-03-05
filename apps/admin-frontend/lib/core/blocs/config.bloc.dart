import 'package:api_response/api_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/core/repositories/config_repository.dart';
import 'package:admin_frontend/schema.graphql.dart' as schema;

part 'config.state.dart';
part 'config.event.dart';
part 'config.bloc.freezed.dart';

@lazySingleton
class ConfigBloc extends HydratedBloc<ConfigEvent, ConfigState> {
  final ConfigRepository _licenseRepository;

  ConfigBloc(this._licenseRepository) : super(const ConfigState()) {
    on<ConfigEvent>((event, emit) async {
      switch (event) {
        case ConfigEventStarted():
          emit.forEach(
            _licenseRepository.configInformation,
            onData: (config) {
              return state.copyWith(config: config);
            },
          );
          await emit.forEach(
            _licenseRepository.licenseInformation,
            onData: (license) {
              if (license.data != null) {
                return state.copyWith(
                  license: license.mapData((data) => data!),
                );
              } else {
                return state.copyWith(
                  license: ApiResponse.error(
                    license.errorMessage ?? 'License not found',
                  ),
                );
              }
            },
          );

          // emit(
          //   await license.fold(
          //     (l) async => ConfigState.error(error: l),
          //     (r) async {
          //       if (r.licenseInformation == null) {
          //         return const ConfigState.unauthenticated();
          //       } else if (r.configInformation.isValid == false) {
          //         return ConfigState.authenticatedUnconfigured(
          //           license: r.licenseInformation!,
          //           config: r.configInformation,
          //         );
          //       } else {
          //         return ConfigState.done(
          //           license: r.licenseInformation!,
          //           config: r.configInformation,
          //         );
          //       }
          //     },
          //   ),
          // );
          break;
      }
    });
  }

  Future<void> onStarted() async {
    add(const ConfigEventStarted());
    return _licenseRepository.getConfigInformation();
  }

  @override
  ConfigState? fromJson(Map<String, dynamic> json) =>
      ConfigState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ConfigState state) => state.toJson();
}
