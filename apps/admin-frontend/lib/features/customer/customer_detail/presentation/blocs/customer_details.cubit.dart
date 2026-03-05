import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_details_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'customer_details.state.dart';
part 'customer_details.cubit.freezed.dart';

class CustomerDetailsBloc extends Cubit<CustomerDetailsState> {
  final CustomerDetailsRepository _customerDetailsRepository =
      locator<CustomerDetailsRepository>();
  CustomerDetailsBloc() : super(CustomerDetailsState());

  void onStarted(String id) async {
    emit(state.copyWith(customerDetailsState: const ApiResponse.loading()));
    final customerDetailsOrError = await _customerDetailsRepository
        .getCustomerDetails(id);
    final customeDetailsState = customerDetailsOrError;
    emit(state.copyWith(customerDetailsState: customeDetailsState));
  }

  Future<ApiResponse<void>> updateCustomerDetails(
    Input$RiderInput customerDetails,
  ) async {
    final id = state.customerDetailsState.data!.id;
    final updatedCustomerDetailsOrError = await _customerDetailsRepository
        .updateCustomerDetails(
          Input$UpdateOneRiderInput(id: id, update: customerDetails),
        );
    final updatedCustomerDetailsState = updatedCustomerDetailsOrError;
    emit(state.copyWith(customerDetailsState: updatedCustomerDetailsState));
    return updatedCustomerDetailsState;
  }

  Future<ApiResponse<void>> deleteUser() async {
    emit(state.copyWith(deleteUserState: const ApiResponse.loading()));
    final deleteResponse = await _customerDetailsRepository.deleteUser(
      customerId: state.customerDetailsState.data!.id,
    );
    emit(state.copyWith(deleteUserState: deleteResponse));
    return deleteResponse;
  }
}
