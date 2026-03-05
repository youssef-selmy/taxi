import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff_role.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_role_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'staff_role_list.state.dart';
part 'staff_role_list.cubit.freezed.dart';

class StaffRoleListBloc extends Cubit<StaffRoleListState> {
  final StaffRoleRepository _staffRoleRepository =
      locator<StaffRoleRepository>();

  StaffRoleListBloc() : super(StaffRoleListState.initial());

  void onStarted() {
    getRoles();
  }

  Future<void> getRoles() async {
    emit(state.copyWith(staffRoles: const ApiResponse.loading()));

    final staffRoles = await _staffRoleRepository.getAll(
      filter: Input$OperatorRoleFilter(),
      sorting: [],
    );

    emit(state.copyWith(staffRoles: staffRoles));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    getRoles();
  }
}
