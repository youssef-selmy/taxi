import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/data/graphql/driver_pending_verification_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/data/repositories/driver_pending_verification_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_pending_verification_list.state.dart';
part 'driver_pending_verification_list.bloc.freezed.dart';

class DriverPendingVerificationListBloc
    extends Cubit<DriverPendingVerificationListState> {
  final DriverPendingVerificationListRepository
  _driverPendingVerificationListRepository =
      locator<DriverPendingVerificationListRepository>();

  DriverPendingVerificationListBloc()
    : super(
        // ignore: prefer_const_constructors
        DriverPendingVerificationListState(),
      );

  void onStarted() {
    _fetchDrivers();
  }

  Future<void> _fetchDrivers() async {
    emit(state.copyWith(driversState: const ApiResponse.loading()));

    var driversOrError = await _driverPendingVerificationListRepository
        .getDrivers(
          paging: state.paging,
          filter: Input$DriverFilter(
            status: Input$DriverStatusFilterComparison(
              $in: state.driverStatusFilter.isEmpty
                  ? [Enum$DriverStatus.PendingApproval]
                  : state.driverStatusFilter,
            ),
            or: state.searchQuery?.isEmpty == false
                ? [
                    Input$DriverFilter(
                      lastName: Input$StringFieldComparison(
                        like: '%${state.searchQuery}%',
                      ),
                    ),
                    Input$DriverFilter(
                      mobileNumber: Input$StringFieldComparison(
                        like: '%${state.searchQuery}%',
                      ),
                    ),
                  ]
                : [],
          ),
          sorting: state.sorting,
        );

    emit(state.copyWith(driversState: driversOrError));
  }

  void onStatusFilterChanged(List<Enum$DriverStatus> value) {
    emit(state.copyWith(driverStatusFilter: value));
    _fetchDrivers();
  }

  void onSortingChanged(List<Input$DriverSort> value) {
    emit(state.copyWith(sorting: value));
    _fetchDrivers();
  }

  void onSearchQueryChanged(String value) {
    emit(state.copyWith(searchQuery: value));
    _fetchDrivers();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchDrivers();
  }
}
