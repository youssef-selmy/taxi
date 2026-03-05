import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_role_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'staff_role_details.state.dart';
part 'staff_role_details.cubit.freezed.dart';

class StaffRoleDetailsBloc extends Cubit<StaffRoleDetailsState> {
  final StaffRoleRepository _staffRoleRepository =
      locator<StaffRoleRepository>();

  StaffRoleDetailsBloc() : super(StaffRoleDetailsState());

  void onStarted(String? id) {
    if (id != null) {
      emit(StaffRoleDetailsState(staffRoleId: id));
      getStaffRole();
    } else {
      emit(StaffRoleDetailsState(staffRole: const ApiResponse.loaded(null)));
    }
  }

  Future<void> getStaffRole() async {
    if (state.staffRoleId == null) return;
    emit(state.copyWith(staffRole: const ApiResponse.loading()));
    final staffDetails = await _staffRoleRepository.getOne(
      id: state.staffRoleId!,
    );
    final networkState = staffDetails;
    emit(
      state.copyWith(
        staffRole: networkState,
        taxiPermissions: networkState.data?.taxiPermissions ?? [],
        shopPermissions: networkState.data?.shopPermissions ?? [],
        parkingPermissions: networkState.data?.parkingPermissions ?? [],
        title: networkState.data?.title ?? "",
        allowedAppTypes: networkState.data?.allowedApps ?? [],
        permissions: networkState.data?.permissions ?? [],
      ),
    );
  }

  void updateCommonPermission(
    List<Enum$OperatorPermission> addPermissions,
    List<Enum$OperatorPermission> removePermissions,
  ) {
    final permissions = state.permissions
        .where((element) => !removePermissions.contains(element))
        .toList();
    permissions.addAll(addPermissions);
    emit(state.copyWith(permissions: permissions));
  }

  void updateTaxiPermission(
    List<Enum$TaxiPermission> addPermissions,
    List<Enum$TaxiPermission> removePermissions,
  ) {
    final permissions = state.taxiPermissions
        .where((element) => !removePermissions.contains(element))
        .toList();
    permissions.addAll(addPermissions);
    emit(state.copyWith(taxiPermissions: permissions));
  }

  void updateShopPermission(
    List<Enum$ShopPermission> addPermissions,
    List<Enum$ShopPermission> removePermissions,
  ) {
    final permissions = state.shopPermissions
        .where((element) => !removePermissions.contains(element))
        .toList();
    permissions.addAll(addPermissions);
    emit(state.copyWith(shopPermissions: permissions));
  }

  void updateParkingPermission(
    List<Enum$ParkingPermission> addPermissions,
    List<Enum$ParkingPermission> removePermissions,
  ) {
    final permissions = state.parkingPermissions
        .where((element) => !removePermissions.contains(element))
        .toList();
    permissions.addAll(addPermissions);
    emit(state.copyWith(parkingPermissions: permissions));
  }

  void onTitleChanged(String p1) {
    emit(state.copyWith(title: p1));
  }

  void saveChanges() {
    if (state.staffRoleId != null) {
      _updateOperatorRole();
    } else {
      _createOperatorRole();
    }
  }

  void _updateOperatorRole() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _staffRoleRepository.update(
      id: state.staffRoleId!,
      input: state.toInput(),
    );
    emit(state.copyWith(networkStateSave: result));
  }

  void _createOperatorRole() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _staffRoleRepository.create(input: state.toInput());
    emit(state.copyWith(networkStateSave: result));
  }

  void onParkingPanelSwitchChanged(bool p1) {
    _changeAppTypeAvailability(Enum$AppType.Parking, p1);
  }

  void onShopPanelSwitchChanged(bool p1) {
    _changeAppTypeAvailability(Enum$AppType.Shop, p1);
  }

  void onTaxiPanelSwitchChanged(bool p1) {
    _changeAppTypeAvailability(Enum$AppType.Taxi, p1);
  }

  void _changeAppTypeAvailability(Enum$AppType appType, bool p1) {
    if (p1) {
      _addAppType(appType);
    } else {
      _removeAppType(appType);
    }
  }

  void _removeAppType(Enum$AppType appType) {
    final allowedAppTypes = state.allowedAppTypes
        .where((element) => element != appType)
        .toList();
    emit(state.copyWith(allowedAppTypes: allowedAppTypes));
  }

  void _addAppType(Enum$AppType appType) {
    final allowedAppTypes = state.allowedAppTypes.followedBy([
      appType,
    ]).toList();
    emit(state.copyWith(allowedAppTypes: allowedAppTypes));
  }

  void deleteStaffRole() {
    if (state.staffRoleId != null) {
      _deleteOperatorRole();
    }
  }

  void _deleteOperatorRole() async {
    emit(state.copyWith(networkStateSave: const ApiResponse.loading()));
    final result = await _staffRoleRepository.delete(id: state.staffRoleId!);
    emit(state.copyWith(networkStateSave: result));
  }
}
