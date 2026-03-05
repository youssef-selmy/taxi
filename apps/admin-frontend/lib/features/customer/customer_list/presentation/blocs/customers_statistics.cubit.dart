import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_list/data/graphql/customers_statistics.graphql.dart';
import 'package:admin_frontend/features/customer/customer_list/data/repositories/customers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'customers_statistics.cubit.freezed.dart';
part 'customers_statistics.state.dart';

class CustomersStatisticsBloc extends Cubit<CustomersStatisticsState> {
  final CustomersRepository _customersRepository =
      locator<CustomersRepository>();

  CustomersStatisticsBloc() : super(CustomersStatisticsState.initial());

  void onStarted() {
    _fetchCustomersStatistics();
  }

  void onRevenueFilterChanged(Input$ChartFilterInput filter) async {
    emit(state.copyWith(revenueFilter: filter));
    final result = await _customersRepository.getRevenuePerApp(filter: filter);
    emit(
      state.copyWith(
        stats: result.mapData(
          (data) => state.stats.data!.copyWith(revenuePerApp: data),
        ),
      ),
    );
  }

  void _fetchCustomersStatistics() async {
    emit(state.copyWith(stats: const ApiResponse.loading()));
    final customersStatistics = await _customersRepository
        .getCustomersStatistics();
    emit(state.copyWith(stats: customersStatistics));
  }

  void onActiveInactiveUsersFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(activeInactiveUsersFilter: filterInput));
  }

  void onRetentionFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(retentionFilter: filterInput));
  }
}
