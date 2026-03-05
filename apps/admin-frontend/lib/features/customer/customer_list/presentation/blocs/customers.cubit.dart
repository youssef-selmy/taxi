import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_list/data/repositories/customers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'customers.state.dart';
part 'customers.cubit.freezed.dart';

class CustomersBloc extends Cubit<CustomersState> {
  final CustomersRepository _customersRepository =
      locator<CustomersRepository>();

  CustomersBloc() : super(CustomersState.initial());

  void onInit() {
    _fetchCustomers();
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(query: query));
    _fetchCustomers();
  }

  void onFilterCustomerStatusChanged(
    List<Enum$RiderStatus> filterCustomerStatus,
  ) {
    emit(state.copyWith(filterCustomerStatus: filterCustomerStatus));
    _fetchCustomers();
  }

  void onSortFieldsChanged(List<Input$RiderSort> sortFields) {
    emit(state.copyWith(sortFields: sortFields));
    _fetchCustomers();
  }

  void _fetchCustomers() async {
    emit(state.copyWith(customers: const ApiResponse.loading()));
    final customers = await _customersRepository.getCustomers(
      paging: state.paging,
      filter: Input$RiderFilter(
        status: state.filterCustomerStatus.isEmpty
            ? null
            : Input$RiderStatusFilterComparison(
                $in: state.filterCustomerStatus,
              ),
        or: state.query?.isEmpty == false
            ? [
                Input$RiderFilter(
                  lastName: Input$StringFieldComparison(
                    like: '%${state.query}%',
                  ),
                ),
                Input$RiderFilter(
                  mobileNumber: Input$StringFieldComparison(
                    like: '%${state.query}%',
                  ),
                ),
              ]
            : [],
      ),
      sorting: state.sortFields,
    );
    emit(state.copyWith(customers: customers));
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchCustomers();
  }

  void refreshCustomers() {
    emit(state.copyWith(customers: const ApiResponse.loading()));
    _fetchCustomers();
  }
}
