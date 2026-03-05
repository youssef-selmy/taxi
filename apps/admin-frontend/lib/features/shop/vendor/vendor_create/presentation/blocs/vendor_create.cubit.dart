import 'dart:math';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/graphql/fragments/mobile_number.extensions.dart';
import 'package:flutter/widgets.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/data/repositories/vendor_create_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:latlong2/latlong.dart';

part 'vendor_create.state.dart';
part 'vendor_create.cubit.freezed.dart';

class VendorCreateBloc extends Cubit<VendorCreateState> {
  final VendorCreateRepository _vendorCreateRepository =
      locator<VendorCreateRepository>();

  VendorCreateBloc() : super(VendorCreateState.initial());

  void onStarted({required String? vendorId}) {
    emit(VendorCreateState.initial().copyWith(vendorId: vendorId));
    _fetchCategories();
    if (vendorId != null) {
      _fetchVendorDetail();
    } else {
      emit(state.copyWith(vendorState: const ApiResponse.loaded(null)));
    }
  }

  Future<void> _fetchCategories() async {
    final categoriesOrError = await _vendorCreateRepository.getShopCategories();
    final categories = categoriesOrError;
    emit(state.copyWith(shopCategoriesState: categories));
  }

  void _fetchVendorDetail() async {
    emit(state.copyWith(vendorState: const ApiResponse.loading()));

    final vendorOrError = await _vendorCreateRepository.getShopDetail(
      id: state.vendorId!,
    );
    final vendorState = vendorOrError;
    _applyFormFieldUpdates(vendorState);
  }

  void _applyFormFieldUpdates(ApiResponse<Fragment$shopDetail> shopDetail) {
    final data = shopDetail.data;
    emit(
      state.copyWith(
        vendorState: shopDetail,
        name: data?.name ?? state.name,
        description: data?.description ?? state.description,
        password: data?.password ?? state.password,
        phoneNumber: data?.mobileNumber.toPrimitive() ?? state.phoneNumber,
        email: data?.email ?? state.email,
        profileImage: data?.image ?? state.profileImage,
        categories: data?.categories ?? state.categories,
        location: data?.location ?? state.location,
        ownerFirstName:
            data?.ownerInformation.firstName ?? state.ownerFirstName,
        ownerLastName: data?.ownerInformation.lastName ?? state.ownerLastName,
        ownerEmail: data?.ownerInformation.email ?? state.ownerEmail,
        ownerPhoneNumber:
            data?.ownerInformation.mobileNumber?.toPrimitive() ??
            state.ownerPhoneNumber,
        ownerGender: data?.ownerInformation.gender ?? state.ownerGender,
        isExpressDeliveryAvailable:
            data?.isExpressDeliveryAvailable ??
            state.isExpressDeliveryAvailable,
        expressDeliveryShopCommission:
            data?.expressDeliveryShopCommission ??
            state.expressDeliveryShopCommission,
        isShopDeliveryAvailable:
            data?.isShopDeliveryAvailable ?? state.isShopDeliveryAvailable,
        isOnlinePaymentAvailable:
            data?.isOnlinePaymentAvailable ?? state.isOnlinePaymentAvailable,
        isCashPaymentAvailable:
            data?.isCashOnDeliveryAvailable ?? state.isCashPaymentAvailable,
      ),
    );
  }

  void onPreviousPage() {
    emit(state.copyWith(wizardStep: max(0, state.wizardStep - 1)));
    state.pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onNextPage() {
    emit(state.copyWith(wizardStep: min(3, state.wizardStep + 1)));
    state.pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> onSubmit() async {
    emit(state.copyWith(saveState: ApiResponse.loading()));
    final saveResponse = await _vendorCreateRepository.createShop(
      input: state.toInput,
      categoryIds: state.categories.map((e) => e.id).toList(),
    );
    emit(state.copyWith(saveState: saveResponse));
    emit(state.copyWith(saveState: ApiResponse.initial()));
  }

  void onNameChanged(String p1) => emit(state.copyWith(name: p1));

  void onAddressChanged(String p1) {
    emit(state.copyWith(address: p1));
  }

  void onDescriptionChanged(String p1) {
    emit(state.copyWith(description: p1));
  }

  void onPasswordChanged(String p1) {
    emit(state.copyWith(password: p1));
  }

  void onEmailChanged(String p1) {
    emit(state.copyWith(email: p1));
  }

  void onPhoneNumberChanged((String, String?)? p1) {
    emit(state.copyWith(phoneNumber: p1!));
  }

  void onCategoriesChanged(List<Fragment$shopCategoryCompact>? value) {
    emit(state.copyWith(categories: value ?? []));
  }

  void onCategoryRemoved(Fragment$shopCategoryCompact category) {
    emit(
      state.copyWith(
        categories: state.categories.where((e) => e.id != category.id).toList(),
      ),
    );
  }

  void onLocationChanged(LatLng p1) =>
      emit(state.copyWith(location: p1.toFragmentCoordinate()));

  void onGenderChanged(Enum$Gender? p1) {
    emit(state.copyWith(ownerGender: p1));
  }

  void onOwnerPhoneNumberChanged((String, String?)? p1) {
    emit(state.copyWith(ownerPhoneNumber: p1!));
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

  void onIsShopDeliveryAvailableChanged(bool value) {
    emit(state.copyWith(isShopDeliveryAvailable: value));
  }

  void onIsExpressDeliveryAvailableChanged(bool p1) {
    emit(state.copyWith(isExpressDeliveryAvailable: p1));
  }

  void onExpressDeliveryShopCommissionChanged(int? p1) {
    emit(state.copyWith(expressDeliveryShopCommission: p1 ?? 0));
  }

  void onIsCashPaymentAvailableChanged(bool p1) {
    emit(state.copyWith(isCashPaymentAvailable: p1));
  }

  void onIsOnlinePaymentAvailableChanged(bool p1) {
    emit(state.copyWith(isOnlinePaymentAvailable: p1));
  }

  void onImageChanged(Fragment$Media? media) {
    emit(state.copyWith(profileImage: media));
  }
}
