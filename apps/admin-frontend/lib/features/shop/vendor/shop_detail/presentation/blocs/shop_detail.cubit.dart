import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/graphql/fragments/mobile_number.extensions.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_detail.state.dart';
part 'shop_detail.cubit.freezed.dart';

class ShopDetailBloc extends Cubit<ShopDetailState> {
  final ShopDetailRepository _shopDetailRepository =
      locator<ShopDetailRepository>();

  ShopDetailBloc() : super(ShopDetailState.initial());

  void onStarted({required String shopId}) {
    emit(state.copyWith(shopId: shopId));
    _fetchShopDetail();
  }

  void onMainImageChanged(Fragment$Media? image) async {
    final shopOrError = await _shopDetailRepository.updateShop(
      shopId: state.shopId!,
      input: Input$UpsertShopInput(imageId: image?.id),
    );
    if (shopOrError.isLoaded) {
      applyDetailUpdates(shopOrError);
    }
  }

  void applyDetailUpdates(ApiResponse<Fragment$shopDetail> shopDetailState) {
    emit(
      state.copyWith(
        shopDetailState: shopDetailState,
        shopName: shopDetailState.data?.name,
        address: shopDetailState.data?.address,
        coordinate: shopDetailState.data?.location,
        description: shopDetailState.data?.description,
        email: shopDetailState.data?.email,
        mobileNumber: shopDetailState.data!.mobileNumber.toPrimitive(),
        ownerFirstName: shopDetailState.data?.ownerInformation.firstName,
        ownerLastName: shopDetailState.data?.ownerInformation.lastName,
        ownerEmail: shopDetailState.data?.ownerInformation.email,
        ownerPhoneNumber: (
          shopDetailState.data?.ownerInformation.mobileNumber?.countryCode ??
              Env.defaultCountry.iso2CountryCode,
          shopDetailState.data?.ownerInformation.mobileNumber?.number,
        ),
      ),
    );
  }

  void _fetchShopDetail() async {
    emit(state.copyWith(shopDetailState: const ApiResponse.loading()));
    final shopDetailOrError = await _shopDetailRepository.getShopDetail(
      shopId: state.shopId!,
    );
    final shopDetailState = shopDetailOrError;
    applyDetailUpdates(shopDetailState);
  }

  void onStatusChanged(Enum$ShopStatus? status) async {
    final shopOrError = await _shopDetailRepository.updateShop(
      shopId: state.shopId!,
      input: Input$UpsertShopInput(status: status),
    );
    if (shopOrError.isLoaded) {
      applyDetailUpdates(shopOrError);
    }
  }

  void onOpenHoursChanged(List<Input$WeekdayScheduleInput> p1) {
    emit(state.copyWith(openHours: p1));
  }

  void saveOpenHours() async {
    final shopOrError = await _shopDetailRepository.updateShop(
      shopId: state.shopId!,
      input: Input$UpsertShopInput(weeklySchedule: state.openHours),
    );
    applyDetailUpdates(shopOrError);
  }

  void onNameChanged(String p1) {
    emit(state.copyWith(shopName: p1));
  }

  void onOwnerPhoneNumberChanged((String, String?)? p1) {
    emit(state.copyWith(ownerPhoneNumber: p1!));
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

  void onPhoneNumberChanged((String, String?)? p1) {
    emit(state.copyWith(mobileNumber: p1!));
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
    final shopOrError = await _shopDetailRepository.updateShop(
      shopId: state.shopId!,
      input: Input$UpsertShopInput(
        name: state.shopName,
        address: state.address,
        description: state.description,
        email: state.email,
        mobileNumber: state.mobileNumber.toInput(),
        location: state.coordinate!.toPointInput(),
      ),
    );
    applyDetailUpdates(shopOrError);
  }

  void onCoordinateChanged(Fragment$Coordinate? fragmentCoordinate) =>
      emit(state.copyWith(coordinate: fragmentCoordinate));
}
