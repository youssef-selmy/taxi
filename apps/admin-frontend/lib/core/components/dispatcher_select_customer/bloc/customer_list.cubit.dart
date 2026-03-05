import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/documents/select_customer.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/customers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'customer_list.state.dart';
part 'customer_list.cubit.freezed.dart';

class CustomerListCubit extends Cubit<CustomerListState> {
  final CustomersRepository _customersRepository =
      locator<CustomersRepository>();

  CustomerListCubit() : super(CustomerListState());

  void onStarted() {
    _refreshList();
  }

  void _refreshList() async {
    emit(state.copyWith(customerList: ApiResponse.loading()));
    final customers = await _customersRepository.getCustomers(
      paging: state.paging,
      query: state.query,
    );
    emit(state.copyWith(customerList: customers));
  }

  void onPageChanged(Input$OffsetPaging pagination) {
    emit(state.copyWith(paging: pagination));
    _refreshList();
  }
}
