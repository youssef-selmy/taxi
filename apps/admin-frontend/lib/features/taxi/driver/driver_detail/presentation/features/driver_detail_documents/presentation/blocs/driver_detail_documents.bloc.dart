import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/data/graphql/driver_detail_documents.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/data/repositories/driver_detail_documents_repository.dart';

part 'driver_detail_documents.state.dart';
part 'driver_detail_documents.bloc.freezed.dart';

class DriverDetailDocumentsBloc extends Cubit<DriverDetailDocumentsState> {
  final DriverDetailDocumentsRepository _driverDetailDocumentsRepository =
      locator<DriverDetailDocumentsRepository>();

  DriverDetailDocumentsBloc() : super(DriverDetailDocumentsState());

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));
    _fetchDriverDocuments();
  }

  Future<void> _fetchDriverDocuments() async {
    emit(state.copyWith(driverDocumentsState: const ApiResponse.loading()));

    var driverDocumentsOrError = await _driverDetailDocumentsRepository
        .getDriverDocuments(id: state.driverId!);

    emit(state.copyWith(driverDocumentsState: driverDocumentsOrError));
  }
}
