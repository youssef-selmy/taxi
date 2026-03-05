import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'park_spot_detail.state.dart';
part 'park_spot_detail.cubit.freezed.dart';

class ParkSpotDetailBloc extends Cubit<ParkSpotDetailState> {
  final ParkSpotDetailRepository _parkSpotDetailRepository =
      locator<ParkSpotDetailRepository>();

  ParkSpotDetailBloc() : super(ParkSpotDetailState());

  void onStarted({required String parkSpotId}) {
    emit(state.copyWith(parkSpotId: parkSpotId));
    _fetchParkSpotDetail();
  }

  void onMainImageChanged(Fragment$Media? image) async {
    final parkSpotOrError = await _parkSpotDetailRepository.updateParkSpot(
      parkSpotId: state.parkSpotId!,
      input: Input$UpdateParkSpotInput(mainImageId: image?.id),
    );
    if (parkSpotOrError.isLoaded) {
      applyDetailUpdates(parkSpotOrError);
    }
  }

  void applyDetailUpdates(
    ApiResponse<Fragment$parkSpotDetail> parkSpotDetailState,
  ) {
    emit(
      state.copyWith(
        parkSpotDetailState: parkSpotDetailState,
        parkingName: parkSpotDetailState.data?.name,
        address: parkSpotDetailState.data?.address,
        coordinate: parkSpotDetailState.data?.location,
        description: parkSpotDetailState.data?.description,
        email: parkSpotDetailState.data?.email,
        mobileNumber: parkSpotDetailState.data?.phoneNumber,
        ownerFirstName: parkSpotDetailState.data?.owner?.firstName,
        ownerLastName: parkSpotDetailState.data?.owner?.lastName,
        ownerEmail: parkSpotDetailState.data?.owner?.email,
        ownerPhoneNumber: parkSpotDetailState.data?.owner?.mobileNumber,
        ownerGender: parkSpotDetailState.data?.owner?.gender,
        carSpaces: parkSpotDetailState.data?.carSpaces ?? 0,
        carPrice: parkSpotDetailState.data?.carPrice,
        carSize: parkSpotDetailState.data?.carSize,
        bikeSpaces: parkSpotDetailState.data?.bikeSpaces ?? 0,
        bikePrice: parkSpotDetailState.data?.bikePrice,
        truckSpaces: parkSpotDetailState.data?.truckSpaces ?? 0,
        truckPrice: parkSpotDetailState.data?.truckPrice,
        facilities: parkSpotDetailState.data?.facilities ?? [],
      ),
    );
  }

  void _fetchParkSpotDetail() async {
    emit(state.copyWith(parkSpotDetailState: const ApiResponse.loading()));
    final parkSpotDetailOrError = await _parkSpotDetailRepository
        .getParkSpotDetail(parkSpotId: state.parkSpotId!);
    final parkSpotDetailState = parkSpotDetailOrError;
    applyDetailUpdates(parkSpotDetailState);
  }

  void onStatusChanged(Enum$ParkSpotStatus? status) async {
    final parkSpotOrError = await _parkSpotDetailRepository.updateParkSpot(
      parkSpotId: state.parkSpotId!,
      input: Input$UpdateParkSpotInput(status: status),
    );
    if (parkSpotOrError.isLoaded) {
      applyDetailUpdates(parkSpotOrError);
    }
  }

  void onOpenHoursChanged(List<Input$WeekdayScheduleInput> p1) {
    emit(state.copyWith(openHours: p1));
  }

  void saveOpenHours() async {
    final parkSpotOrError = await _parkSpotDetailRepository.updateParkSpot(
      parkSpotId: state.parkSpotId!,
      input: Input$UpdateParkSpotInput(weeklySchedule: state.openHours),
    );
    applyDetailUpdates(parkSpotOrError);
  }

  void onNameChanged(String p1) {
    emit(state.copyWith(parkingName: p1));
  }

  void onOwnerPhoneNumberChanged(String p1) {
    emit(state.copyWith(ownerPhoneNumber: p1));
  }

  void onGenderChanged(Enum$Gender? p1) {
    emit(state.copyWith(ownerGender: p1));
  }

  void onOwnerEmailChanged(String p1) {
    emit(state.copyWith(ownerEmail: p1));
  }

  void onLastNameChanged(String p1) {
    emit(state.copyWith(ownerLastName: p1));
  }

  void onFirstNameChanged(String p1) {
    emit(state.copyWith(ownerFirstName: p1));
  }

  void onImagesChanged(List<Fragment$Media> p1) {
    emit(state.copyWith(images: p1));
  }

  void onPhoneNumberChanged(String p1) {
    emit(state.copyWith(mobileNumber: p1));
  }

  void onEmailChanged(String p1) {
    emit(state.copyWith(email: p1));
  }

  void onDescriptionChanged(String p1) {
    emit(state.copyWith(description: p1));
  }

  void onAddressChanged(String p1) {
    emit(state.copyWith(address: p1));
  }

  void saveDetails() async {
    final parkSpotOrError = await _parkSpotDetailRepository.updateParkSpot(
      parkSpotId: state.parkSpotId!,
      input: Input$UpdateParkSpotInput(
        name: state.parkingName,
        address: state.address,
        description: state.description,
        email: state.email,
        phoneNumber: state.mobileNumber,
        location: state.coordinate!.toPointInput(),
      ),
    );
    applyDetailUpdates(parkSpotOrError);
  }

  void onCoordinateChanged(Fragment$Coordinate? fragmentCoordinate) =>
      emit(state.copyWith(coordinate: fragmentCoordinate));

  void toggleCarSpaces() {
    emit(state.copyWith(carSpaces: state.carSpaces == 0 ? 1 : 0));
  }

  void toggleBikeSpaces() {
    emit(state.copyWith(bikeSpaces: state.bikeSpaces == 0 ? 1 : 0));
  }

  void toggleTruckSpaces() {
    emit(state.copyWith(truckSpaces: state.truckSpaces == 0 ? 1 : 0));
  }

  void onCarSpacesChanged(int? p1) {
    emit(state.copyWith(carSpaces: p1!));
  }

  void onBikeSpacesChanged(int? p1) {
    emit(state.copyWith(bikeSpaces: p1!));
  }

  void onTruckSpacesChanged(int? p1) {
    emit(state.copyWith(truckSpaces: p1!));
  }

  void onCarSizeChanged(Enum$ParkSpotCarSize? p1) {
    emit(state.copyWith(carSize: p1));
  }

  void onCarPriceChanged(double? p1) {
    emit(state.copyWith(carPrice: p1));
  }

  void onBikePriceChanged(double? p1) {
    emit(state.copyWith(bikePrice: p1));
  }

  void onTruckPriceChanged(double? p1) {
    emit(state.copyWith(truckPrice: p1));
  }

  void toggleFacility(Enum$ParkSpotFacility facility) {
    if (state.facilities.contains(facility)) {
      emit(
        state.copyWith(
          facilities: state.facilities
              .where((element) => element != facility)
              .toList(),
        ),
      );
    } else {
      emit(state.copyWith(facilities: [...state.facilities, facility]));
    }
  }

  void saveFacilitiesAndSpacePriceStatus() async {
    final parkSpotOrError = await _parkSpotDetailRepository.updateParkSpot(
      parkSpotId: state.parkSpotId!,
      input: Input$UpdateParkSpotInput(
        carSpaces: state.carSpaces,
        carPrice: state.carPrice,
        bikeSpaces: state.bikeSpaces,
        bikePrice: state.bikePrice,
        truckSpaces: state.truckSpaces,
        truckPrice: state.truckPrice,
        carSize: state.carSize,
        facilities: state.facilities,
      ),
    );
    applyDetailUpdates(parkSpotOrError);
  }
}
