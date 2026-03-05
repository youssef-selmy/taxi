import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/data/graphql/create_new_driver.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/data/models/create_new_driver_documents.model.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/data/repositories/create_new_driver_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'create_new_driver.state.dart';
part 'create_new_driver.bloc.freezed.dart';

class CreateNewDriverBloc extends Cubit<CreateNewDriverState> {
  final CreateNewDriverRepository _createNewDriverRepository =
      locator<CreateNewDriverRepository>();

  CreateNewDriverBloc() : super(CreateNewDriverState.initial());

  void onStarted() {
    _fetchDriverDetails();
  }

  void _fetchDriverDetails() async {
    emit(state.copyWith(driverDetailsState: const ApiResponse.loading()));

    final driverDetailsOrError = await _createNewDriverRepository
        .getdriverDetails();

    emit(state.copyWith(driverDetailsState: driverDetailsOrError));
  }

  void onNextPage() {
    if (state.stepperCurrentIndex == 0 &&
        ((state.formKeyDriverDetails.currentState?.validate() ?? false) ==
            false)) {
      return;
    }
    if (state.stepperCurrentIndex >= 0 && state.stepperCurrentIndex < 2) {
      emit(state.copyWith(stepperCurrentIndex: state.stepperCurrentIndex + 1));
    }
    if (state.stepperCurrentIndex == 1) {
      fetchServices();
    }
  }

  void onPreviousPage() {
    if (state.stepperCurrentIndex > 0) {
      emit(state.copyWith(stepperCurrentIndex: state.stepperCurrentIndex - 1));
    }
  }

  void onProfileImageChanged(Fragment$Media? profileImage) {
    emit(state.copyWith(profileImage: profileImage));
  }

  void onFirstNameChange(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void onLastNameChange(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void onEmailChange(String email) {
    emit(state.copyWith(email: email));
  }

  void onPhoneChange((String, String?)? phone) {
    emit(state.copyWith(phoneNumber: phone!));
  }

  void onGenderChange(Enum$Gender? gender) {
    emit(state.copyWith(gender: gender));
  }

  void onFleetChange(Fragment$fleetListItem? fleet) {
    emit(state.copyWith(fleet: fleet));
  }

  void onCarModelChange(Fragment$vehicleModel? carModel) {
    emit(state.copyWith(carModel: carModel));
  }

  void onCarColorChange(Fragment$vehicleColor? carColor) {
    emit(state.copyWith(carColor: carColor));
  }

  void onCarProductionYearChange(int? carProductionYear) {
    emit(state.copyWith(carProductionYear: carProductionYear));
  }

  void onCarPlateNumberChange(String carPlateNumber) {
    emit(state.copyWith(carPlateNumber: carPlateNumber));
  }

  void onAccountNumberChange(String accountNumber) {
    emit(state.copyWith(accountNumber: accountNumber));
  }

  void onBankNameChange(String bankName) {
    emit(state.copyWith(bankName: bankName));
  }

  void onBankRoutingNumberChange(String bankRoutingNumber) {
    emit(state.copyWith(bankRoutingNumber: bankRoutingNumber));
  }

  void onBankSwiftChange(String bankSwift) {
    emit(state.copyWith(bankSwift: bankSwift));
  }

  void onPasswordChange(String password) {
    emit(state.copyWith(password: password));
  }

  void onAddressChange(String address) {
    emit(state.copyWith(address: address));
  }

  Future<void> fetchDriverDocuments() async {
    emit(state.copyWith(driverDocumentsState: const ApiResponse.loading()));

    final driverDocumentsOrFail = await _createNewDriverRepository
        .getDriverDocuments();

    final driverDocumentsToApiResponse = driverDocumentsOrFail;

    emit(state.copyWith(driverDocuments: CreateNewDriverDocumentsModel()));
    emit(
      state.copyWith(
        driverDocumentsState: driverDocumentsToApiResponse,
        driverDocuments: state.driverDocuments!.copyWith(
          driverDocumentsImage: List.generate(
            driverDocumentsToApiResponse.data?.driverDocuments.length ?? 0,
            (index) => null,
          ),
          driverDocumentsExpireDateTime: List.generate(
            driverDocumentsToApiResponse.data?.driverDocuments.length ?? 0,
            (index) => null,
          ),
          driverDocumentsExpireDate: List.generate(
            driverDocumentsToApiResponse.data?.driverDocuments.length ?? 0,
            (index) => false,
          ),
          driverDocumentsRetentionPolicy: List.generate(
            driverDocumentsToApiResponse.data?.driverDocuments.length ?? 0,
            (index) => null,
          ),
        ),
      ),
    );
  }

  void onDriverDocumentImageChange(int index, Fragment$Media? value) {
    emit(
      state.copyWith(
        driverDocuments: state.driverDocuments!.copyWith(
          driverDocumentsImage: state.driverDocumentsState.data!.driverDocuments
              .mapIndexed((secondIndex, element) {
                if (index == secondIndex) {
                  return value;
                }
                return state
                    .driverDocuments
                    ?.driverDocumentsImage?[secondIndex];
              })
              .toList(),
        ),
      ),
    );
  }

  void onDriverDocumentExpireDateChange(int index, bool value) {
    emit(
      state.copyWith(
        driverDocuments: state.driverDocuments?.copyWith(
          driverDocumentsExpireDate: state
              .driverDocumentsState
              .data!
              .driverDocuments
              .mapIndexed((secondIndex, element) {
                if (index == secondIndex) {
                  return value;
                }
                return state
                    .driverDocuments!
                    .driverDocumentsExpireDate![secondIndex];
              })
              .toList(),
        ),
      ),
    );
  }

  void onDriverDocumentsExpireDateTimeChange(int index, DateTime? value) {
    emit(
      state.copyWith(
        driverDocuments: state.driverDocuments?.copyWith(
          driverDocumentsExpireDateTime: state
              .driverDocumentsState
              .data!
              .driverDocuments
              .mapIndexed((secondIndex, element) {
                if (index == secondIndex) {
                  return value;
                }
                return state
                    .driverDocuments!
                    .driverDocumentsExpireDateTime?[secondIndex];
              })
              .toList(),
        ),
      ),
    );
  }

  void onDriverDocumenRetentionPolicyChange(
    int index,
    Fragment$driverDocumentRetentionPolicy? value,
  ) {
    emit(
      state.copyWith(
        driverDocuments: state.driverDocuments?.copyWith(
          driverDocumentsRetentionPolicy: state
              .driverDocumentsState
              .data!
              .driverDocuments
              .mapIndexed((secondIndex, element) {
                if (index == secondIndex) {
                  return value;
                }
                return state
                    .driverDocuments
                    ?.driverDocumentsRetentionPolicy?[secondIndex];
              })
              .toList(),
        ),
      ),
    );
  }

  Future<void> fetchServices() async {
    emit(state.copyWith(servicesState: const ApiResponse.loading()));

    final serviceCategoriesOrFail = await _createNewDriverRepository
        .getServices();

    final serviceCategoriesToApiResponse = serviceCategoriesOrFail;

    emit(
      state.copyWith(
        selectedServiceIds: [],
        servicesState: serviceCategoriesToApiResponse,
      ),
    );
  }

  void onSelectedServiceCategoryId(String id) {
    emit(state.copyWith(selectedServiceCategoryId: id));
  }

  void onSelectServiceChange(String id, bool value) {
    if (value) {
      final newServices = state.selectedServiceIds.followedBy([id]).toList();
      emit(state.copyWith(selectedServiceIds: newServices));
    } else {
      final newServices = state.selectedServiceIds
          .where((element) => element != id)
          .toList();
      emit(state.copyWith(selectedServiceIds: newServices));
    }
  }

  void onChangeCanDeliver(bool value) {
    emit(state.copyWith(canDeliver: value));
  }

  Future<void> onCreateDriver() async {
    emit(state.copyWith(createDriverState: const ApiResponse.initial()));

    var createDriverOrError = await _createNewDriverRepository.createDriver(
      input: Input$CreateOneDriverInput(
        driver: Input$UpdateDriverInput(
          mediaId: state.profileImage!.id,
          firstName: state.firstName,
          lastName: state.lastName,
          email: state.email,
          mobileNumber: state.phoneNumber.$2,
          gender: state.gender,
          fleetId: state.fleet?.id,
          carId: state.carModel?.id,
          carColorId: state.carColor?.id,
          carProductionYear: state.carProductionYear,
          carPlate: state.carPlateNumber,
          accountNumber: state.accountNumber,
          bankName: state.bankName,
          bankRoutingNumber: state.bankRoutingNumber,
          bankSwift: state.bankSwift,
          address: state.address,
          canDeliver: state.canDeliver,
          maxDeliveryPackageSize: state.deliveryPackageSize,
        ),
      ),
    );

    if (createDriverOrError.isError || createDriverOrError.data == null) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(createDriverState: ApiResponse.initial()));
      return;
    }
    // onCreateDriverToDriverDocument(
    //   createDriverOrError.data!.createOneDriver.id,
    // );
    onSetEnabledServices(createDriverOrError.data!.createOneDriver.id);

    emit(state.copyWith(createDriverState: createDriverOrError));
  }

  Future<void> onCreateDriverToDriverDocument(String driverId) async {
    state.driverDocumentsState.data!.driverDocuments.forEachIndexed((
      index,
      element,
    ) async {
      await _createNewDriverRepository.createDriverToDriverDocument(
        input: Input$CreateOneDriverToDriverDocumentInput(
          driverToDriverDocument: Input$DriverToDriverDocumentInput(
            driverId: driverId,
            driverDocumentId:
                state.driverDocumentsState.data!.driverDocuments[index].id,
            mediaId: state.driverDocuments!.driverDocumentsImage![index]!.id,
            expiresAt: state.driverDocuments!.driverDocumentsExpireDate![index]
                ? DateTime.now()
                : state.driverDocuments!.driverDocumentsExpireDateTime![index],
            retentionPolicyId: state
                .driverDocuments!
                .driverDocumentsRetentionPolicy![index]!
                .id,
          ),
        ),
      );
    });
  }

  Future<void> onSetEnabledServices(String driverId) async {
    emit(state.copyWith(setEnabledServicesState: const ApiResponse.initial()));
    var setEnabledServicesOrError = await _createNewDriverRepository
        .setEnabledServices(
          input: Input$SetActiveServicesOnDriverInput(
            driverId: driverId,
            serviceIds: state.selectedServiceIds,
          ),
        );
    emit(state.copyWith(setEnabledServicesState: setEnabledServicesOrError));
  }

  void onChangeDeliveryPackageSize(Enum$DeliveryPackageSize? packageSize) =>
      emit(state.copyWith(deliveryPackageSize: packageSize));
}
