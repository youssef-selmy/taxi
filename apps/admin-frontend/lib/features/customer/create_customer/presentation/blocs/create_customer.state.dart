part of 'create_customer.bloc.dart';

@freezed
sealed class CreateCustomerState with _$CreateCustomerState {
  const factory CreateCustomerState({
    String? firstName,
    String? lastName,
    String? countryCode,
    String? phoneNumber,
    Enum$Gender? gender,
    String? email,
    @Default(ApiResponseInitial())
    ApiResponse<Mutation$createCustomer> saveState,
  }) = _CreateCustomerState;
}
