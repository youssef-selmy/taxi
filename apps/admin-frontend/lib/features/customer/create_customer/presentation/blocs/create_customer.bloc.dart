import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/create_customer/data/graphql/create_customer.graphql.dart';
import 'package:admin_frontend/features/customer/create_customer/data/repositories/create_customer_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'create_customer.state.dart';
part 'create_customer.bloc.freezed.dart';

class CreateCustomerBloc extends Cubit<CreateCustomerState> {
  final CreateCustomerRepository _createCustomerRepository =
      locator<CreateCustomerRepository>();

  CreateCustomerBloc() : super(CreateCustomerState());

  void onFirstNameChanged(String value) =>
      emit(state.copyWith(firstName: value));

  void onLastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void onEmailChanged(String value) => emit(state.copyWith(email: value));

  void onPhoneChanged(String value) => emit(state.copyWith(phoneNumber: value));

  void onGenderChanged(Enum$Gender? p0) => emit(state.copyWith(gender: p0));

  Future<void> onAddCustomer() async {
    emit(state.copyWith(saveState: const ApiResponse.loading()));
    final result = await _createCustomerRepository.createCustomer(
      firstName: state.firstName,
      lastName: state.lastName,
      email: state.email,
      countryCode: state.countryCode,
      phoneNumber: state.phoneNumber,
      gender: state.gender,
    );
    result.fold(
      (error, {failure}) =>
          emit(state.copyWith(saveState: ApiResponse.error(error))),
      (success) => emit(state.copyWith(saveState: ApiResponse.loaded(success))),
    );
  }
}
