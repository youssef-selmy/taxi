import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/address.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/address_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'address.state.dart';
part 'address.cubit.freezed.dart';

class AddressBloc extends Cubit<AddressState> {
  final AddressRepository _addressRepository = locator<AddressRepository>();

  AddressBloc() : super(AddressState());

  void onStarted({required String customerId}) {
    emit(state.copyWith(customerId: customerId));
    _fetchAddresses();
  }

  Future<void> _fetchAddresses() async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final addressesOrError = await _addressRepository.getCustomerAddresses(
      state.customerId!,
    );
    final addressesState = addressesOrError;
    emit(state.copyWith(networkState: addressesState));
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchAddresses();
  }
}
