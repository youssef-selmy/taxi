import 'package:api_response/api_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/data/graphql/driver_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/data/repositories/driver_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_detail.state.dart';
part 'driver_detail.bloc.freezed.dart';

class DriverDetailBloc extends Cubit<DriverDetailState> {
  final DriverDetailRepository _driverDetailRepository =
      locator<DriverDetailRepository>();

  DriverDetailBloc() : super(DriverDetailState());

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));
    _fetchDriverDetail();
  }

  Future<void> _fetchDriverDetail() async {
    emit(state.copyWith(driverDetailResponse: const ApiResponse.loading()));

    var driverDetailOrError = await _driverDetailRepository.getDriverDetail(
      driverId: state.driverId!,
    );

    var driverDetailToApiResponse = driverDetailOrError;

    emit(
      state.copyWith(
        selectedServiceCategoryId:
            driverDetailToApiResponse.data?.serviceCategories.firstOrNull?.id,
        selectedServiceIds:
            driverDetailToApiResponse.data?.driver.enabledServices
                .map((e) => e.service.id)
                .toList() ??
            [],
        updatedDriverDetail: driverDetailToApiResponse.data?.driver,
        driverDetailResponse: driverDetailToApiResponse,
      ),
    );
  }

  Future<void> onUpdateDriver() async {
    emit(state.copyWith(updateDriverState: ApiResponse.initial()));

    var updateDriverOrError = await _driverDetailRepository.updateDriver(
      input: Input$UpdateOneDriverInput(
        id: state.driverId!,
        update: Input$UpdateDriverInput(
          mediaId: state.updatedDriverDetail!.media?.id,
          firstName: state.updatedDriverDetail!.firstName,
          lastName: state.updatedDriverDetail!.lastName,
          email: state.updatedDriverDetail!.email,
          mobileNumber: state.updatedDriverDetail!.mobileNumber,
          gender: state.updatedDriverDetail!.gender,
          fleetId: state.updatedDriverDetail!.fleetId,
          carId: state.updatedDriverDetail!.carId,
          carColorId: state.updatedDriverDetail!.carColorId,
          carProductionYear: state.updatedDriverDetail!.carProductionYear,
          carPlate: state.updatedDriverDetail!.carPlate,
          accountNumber: state.updatedDriverDetail!.accountNumber,
          bankName: state.updatedDriverDetail!.bankName,
          bankRoutingNumber: state.updatedDriverDetail!.bankRoutingNumber,
          bankSwift: state.updatedDriverDetail!.bankSwift,
          address: state.updatedDriverDetail!.address,
          canDeliver: state.updatedDriverDetail!.canDeliver,
          maxDeliveryPackageSize:
              state.updatedDriverDetail!.maxDeliveryPackageSize,
        ),
      ),
    );
    emit(state.copyWith(updateDriverState: updateDriverOrError));
    onUpdateDriverServices();
  }

  Future<void> onUpdateDriverServices() async {
    emit(state.copyWith(updateDriverServiceState: const ApiResponse.initial()));
    var setActiveServicesOrError = await _driverDetailRepository
        .updateDriverService(
          input: Input$SetActiveServicesOnDriverInput(
            driverId: state.driverId!,
            serviceIds: state.selectedServiceIds.toList(),
          ),
        );
    emit(state.copyWith(updateDriverServiceState: setActiveServicesOrError));
  }

  Future<void> onUpdateDriverStatus(Enum$DriverStatus? status) async {
    if (status == null) return;
    emit(state.copyWith(updateDriverStatusState: ApiResponse.loading()));

    var updateDriverStatusOrError = await _driverDetailRepository
        .updateDriverStatus(id: state.driverId!, status: status);

    emit(
      state.copyWith(
        updateDriverStatusState: updateDriverStatusOrError,
        updatedDriverDetail: updateDriverStatusOrError.data?.updateDriverStatus,
      ),
    );
  }

  Future<void> onUpdateDriverImage(Fragment$Media? image) async {
    emit(state.copyWith(updateDriverState: ApiResponse.initial()));

    var updateDriverOrError = await _driverDetailRepository.updateDriver(
      input: Input$UpdateOneDriverInput(
        id: state.driverId!,
        update: Input$UpdateDriverInput(mediaId: image?.id),
      ),
    );
    emit(
      state.copyWith(
        updateDriverState: updateDriverOrError,
        updatedDriverDetail: updateDriverOrError.data?.updateOneDriver,
      ),
    );
  }

  void onProfileImageChange(Fragment$Media profileImage) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          media: profileImage,
        ),
      ),
    );
  }

  void onFirstNameChange(String firstName) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          firstName: firstName,
        ),
      ),
    );
  }

  void onLastNameChange(String lastName) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          lastName: lastName,
        ),
      ),
    );
  }

  void onEmailChange(String email) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(email: email),
      ),
    );
  }

  void onPhoneChange(String phone) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          mobileNumber: phone,
        ),
      ),
    );
  }

  void onGenderChange(Enum$Gender? gender) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          gender: gender,
        ),
      ),
    );
  }

  void onFleetChange(Fragment$fleetListItem? fleet) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          fleetId: fleet!.id,
        ),
      ),
    );
  }

  void onCarModelChange(Fragment$vehicleModel? carModel) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          carId: carModel!.id,
        ),
      ),
    );
  }

  void onCarColorChange(Fragment$vehicleColor? carColor) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          carColorId: carColor!.id,
        ),
      ),
    );
  }

  void onCarProductionYearChange(int? carProductionYear) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          carProductionYear: carProductionYear,
        ),
      ),
    );
  }

  void onCarPlateNumberChange(String carPlateNumber) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          carPlate: carPlateNumber,
        ),
      ),
    );
  }

  void onAccountNumberChange(String accountNumber) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          accountNumber: accountNumber,
        ),
      ),
    );
  }

  void onBankNameChange(String bankName) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          bankName: bankName,
        ),
      ),
    );
  }

  void onBankRoutingNumberChange(String bankRoutingNumber) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          bankRoutingNumber: bankRoutingNumber,
        ),
      ),
    );
  }

  void onBankSwiftChange(String bankSwift) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          bankSwift: bankSwift,
        ),
      ),
    );
  }

  void onAddressChange(String address) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          address: address,
        ),
      ),
    );
  }

  void onSelectServiceChange(String id, bool value) {
    if (value) {
      final newSelected = state.selectedServiceIds.followedBy([id]).toList();
      emit(state.copyWith(selectedServiceIds: newSelected));
    } else {
      final newSelected = state.selectedServiceIds
          .where((element) => element != id)
          .toList();
      emit(state.copyWith(selectedServiceIds: newSelected));
    }
  }

  void onChangeCanDeliver(bool value) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          canDeliver: value,
        ),
      ),
    );
  }

  void onServiceTabChange(String id) {
    emit(state.copyWith(selectedServiceCategoryId: id));
  }

  void onChangeDeliveryPackageSize(Enum$DeliveryPackageSize packageSize) {
    emit(
      state.copyWith(
        updatedDriverDetail: state.updatedDriverDetail?.copyWith(
          maxDeliveryPackageSize: packageSize,
        ),
      ),
    );
  }
}
